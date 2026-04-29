"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.onLeaseExpiry = exports.onPaymentWebhook = exports.onApplicationApproved = exports.onUnitWrite = exports.onUserCreate = void 0;
const functions = __importStar(require("firebase-functions"));
const admin = __importStar(require("firebase-admin"));
const crypto = __importStar(require("crypto"));
admin.initializeApp();
const db = admin.firestore();
const auth = admin.auth();
function buildNotification(userId, type, title, message, relatedId) {
    return {
        user_id: userId,
        type,
        title,
        message,
        is_read: false,
        related_id: relatedId ?? null,
        created_at: admin.firestore.FieldValue.serverTimestamp(),
    };
}
exports.onUserCreate = functions.auth
    .user()
    .onCreate(async (user) => {
    try {
        await auth.setCustomUserClaims(user.uid, { role: "guest" });
        await db.collection("users").doc(user.uid).set({
            name: user.displayName ?? "",
            phone: "",
            role: "guest",
            profile_image: user.photoURL ?? null,
            created_at: admin.firestore.FieldValue.serverTimestamp(),
            updated_at: admin.firestore.FieldValue.serverTimestamp(),
        });
        functions.logger.info(`onUserCreate: user ${user.uid} created with role: guest`);
    }
    catch (error) {
        functions.logger.error(`onUserCreate: failed for user ${user.uid}`, error);
        throw error;
    }
});
exports.onUnitWrite = functions.firestore
    .document("units/{unitId}")
    .onWrite(async (change) => {
    const unitData = change.after.exists ? change.after.data() : change.before.data();
    const propertyId = unitData?.property_id;
    if (!propertyId) {
        functions.logger.warn("onUnitWrite: no property_id found on unit document");
        return;
    }
    try {
        const allUnitsSnap = await db
            .collection("units")
            .where("property_id", "==", propertyId)
            .get();
        const total = allUnitsSnap.size;
        const available = allUnitsSnap.docs.filter((d) => d.data().unit_status === "available").length;
        await db.collection("properties").doc(propertyId).update({
            total_units: total,
            available_units: available,
            updated_at: admin.firestore.FieldValue.serverTimestamp(),
        });
        functions.logger.info(`onUnitWrite: property ${propertyId} total: ${total}, available: ${available}`);
    }
    catch (error) {
        functions.logger.error(`onUnitWrite: failed for property ${propertyId}`, error);
        throw error;
    }
});
exports.onApplicationApproved = functions.firestore
    .document("applications/{appId}")
    .onUpdate(async (change) => {
    const before = change.before.data();
    const after = change.after.data();
    if (!before || !after)
        return;
    if (before.application_status === after.application_status)
        return;
    if (after.application_status !== "approved")
        return;
    const allowedPrevious = ["pending", "interviewPending"];
    if (!allowedPrevious.includes(before.application_status))
        return;
    const unitRef = db.collection("units").doc(after.unit_id);
    const appRef = change.after.ref;
    const adminSnap = await db
        .collection("users")
        .where("role", "==", "admin")
        .get();
    const adminIds = adminSnap.docs.map((d) => d.id);
    try {
        await db.runTransaction(async (tx) => {
            const unitSnap = await tx.get(unitRef);
            const unitData = unitSnap.data();
            if (!unitSnap.exists || unitData?.unit_status !== "available") {
                functions.logger.warn(`onApplicationApproved: unit ${after.unit_id} already taken ` +
                    `auto-rejecting application ${change.after.id}`);
                tx.update(appRef, {
                    application_status: "rejectedUnitTaken",
                    updated_at: admin.firestore.FieldValue.serverTimestamp(),
                });
                const applicantNotifRef = db.collection("notifications").doc();
                tx.set(applicantNotifRef, buildNotification(after.applicant_id, "application_update", "Application Unsuccessful", "Unfortunately the unit you applied for has just been reserved by another applicant.", change.after.id));
                for (const adminId of adminIds) {
                    const adminNotifRef = db.collection("notifications").doc();
                    tx.set(adminNotifRef, buildNotification(adminId, "application_update", "Application Auto-Rejected", "An approved application was auto-rejected because the unit was taken.", change.after.id));
                }
                return;
            }
            tx.update(unitRef, {
                unit_status: "reserved",
                current_tenant_id: after.applicant_id,
                updated_at: admin.firestore.FieldValue.serverTimestamp(),
            });
            const notifRef = db.collection("notifications").doc();
            tx.set(notifRef, buildNotification(after.applicant_id, "application_update", "Application Approved", "Congratulations! Your application has been approved. " +
                "The admin will be in touch shortly to finalise your lease.", change.after.id));
        });
        functions.logger.info(`onApplicationApproved: application ${change.after.id} processed`);
    }
    catch (error) {
        functions.logger.error(`onApplicationApproved: transaction failed for application ${change.after.id}`, error);
        throw error;
    }
});
exports.onPaymentWebhook = functions.https.onRequest(async (req, res) => {
    if (req.method !== "POST") {
        res.status(405).send("Method Not Allowed");
        return;
    }
    const paystackSecret = functions.config().paystack?.secret ?? "PAYSTACK_SECRET_NOT_SET";
    if (paystackSecret === "PAYSTACK_SECRET_NOT_SET") {
        functions.logger.error("onPaymentWebhook: PAYSTACK_SECRET not configured. " +
            "Run: firebase functions:config:set paystack.secret=sk_live_XXXXX");
        res.status(500).send("Webhook secret not configured");
        return;
    }
    const signatureHeader = req.headers["x-paystack-signature"];
    const signature = Array.isArray(signatureHeader)
        ? signatureHeader[0]
        : signatureHeader;
    if (!signature) {
        res.status(400).send("Missing signature");
        return;
    }
    const hash = crypto
        .createHmac("sha512", paystackSecret)
        .update(req.rawBody)
        .digest("hex");
    if (hash !== signature) {
        functions.logger.warn("onPaymentWebhook: invalid signature rejected");
        res.status(401).send("Invalid signature");
        return;
    }
    const event = req.body;
    if (event.event !== "charge.success") {
        res.status(200).send("OK - ignored");
        return;
    }
    const data = event.data;
    const reference = data.reference;
    const status = data.status;
    const amountKobo = data.amount;
    const paymentMethod = data.channel;
    const metadata = data.metadata ?? {};
    const leaseId = metadata.leaseId;
    const tenantId = metadata.tenantId;
    const unitId = metadata.unitId;
    if (!leaseId || !tenantId || !unitId) {
        functions.logger.error("onPaymentWebhook: missing metadata fields", {
            leaseId,
            tenantId,
            unitId,
            reference,
        });
        res.status(400).send("Missing metadata");
        return;
    }
    try {
        const existing = await db
            .collection("payments")
            .where("reference_id", "==", reference)
            .limit(1)
            .get();
        if (!existing.empty) {
            functions.logger.info(`onPaymentWebhook: duplicate reference ${reference} ignored`);
            res.status(200).send("OK - duplicate");
            return;
        }
        await db.collection("payments").add({
            tenant_id: tenantId,
            lease_id: leaseId,
            amount_paid: amountKobo / 100,
            status: status === "success" ? "cleared" : "failed",
            payment_method: paymentMethod,
            reference_id: reference,
            period_start: admin.firestore.FieldValue.serverTimestamp(),
            period_end: admin.firestore.FieldValue.serverTimestamp(),
            due_date: admin.firestore.FieldValue.serverTimestamp(),
            date_paid: status === "success"
                ? admin.firestore.FieldValue.serverTimestamp()
                : null,
            created_at: admin.firestore.FieldValue.serverTimestamp(),
            updated_at: admin.firestore.FieldValue.serverTimestamp(),
        });
        if (status === "success") {
            await db.collection("leases").doc(leaseId).update({
                status: "active",
                updated_at: admin.firestore.FieldValue.serverTimestamp(),
            });
            await db.collection("units").doc(unitId).update({
                unit_status: "occupied",
                updated_at: admin.firestore.FieldValue.serverTimestamp(),
            });
            await auth.setCustomUserClaims(tenantId, { role: "tenant" });
            await db.collection("users").doc(tenantId).update({
                role: "tenant",
                updated_at: admin.firestore.FieldValue.serverTimestamp(),
            });
            await db.collection("notifications").add(buildNotification(tenantId, "lease_activated", "Welcome Home", "Your payment has been confirmed and your tenancy is now active. " +
                "You can view your lease and raise maintenance requests from your dashboard.", leaseId));
            functions.logger.info(`onPaymentWebhook: lease ${leaseId} activated, ` +
                `unit ${unitId} occupied, user ${tenantId} promoted to tenant`);
        }
        res.status(200).send("OK");
    }
    catch (error) {
        functions.logger.error("onPaymentWebhook: processing failed", error);
        res.status(500).send("Internal Server Error");
    }
});
exports.onLeaseExpiry = functions.pubsub
    .schedule("0 0 * * *")
    .timeZone("Africa/Lagos")
    .onRun(async () => {
    const now = admin.firestore.Timestamp.now();
    try {
        const expiredLeasesSnap = await db
            .collection("leases")
            .where("status", "==", "active")
            .where("end_date", "<", now)
            .get();
        if (expiredLeasesSnap.empty) {
            functions.logger.info("onLeaseExpiry: no expired leases found");
            return;
        }
        functions.logger.info(`onLeaseExpiry: processing ${expiredLeasesSnap.size} expired leases`);
        for (const leaseDoc of expiredLeasesSnap.docs) {
            const leaseData = leaseDoc.data();
            const tenantId = leaseData.tenant_id;
            const unitId = leaseData.unit_id;
            try {
                await leaseDoc.ref.update({
                    status: "expired",
                    updated_at: admin.firestore.FieldValue.serverTimestamp(),
                });
                await db.collection("units").doc(unitId).update({
                    unit_status: "available",
                    current_tenant_id: null,
                    updated_at: admin.firestore.FieldValue.serverTimestamp(),
                });
                await auth.setCustomUserClaims(tenantId, { role: "guest" });
                await db.collection("users").doc(tenantId).update({
                    role: "guest",
                    updated_at: admin.firestore.FieldValue.serverTimestamp(),
                });
                await db.collection("notifications").add(buildNotification(tenantId, "lease_expiry", "Your Lease Has Expired", "Your tenancy agreement has come to an end. " +
                    "Please contact the property manager if you wish to renew.", leaseDoc.id));
                functions.logger.info(`onLeaseExpiry: lease ${leaseDoc.id} expired ` +
                    `unit ${unitId} freed, user ${tenantId} downgraded to guest`);
            }
            catch (leaseError) {
                functions.logger.error(`onLeaseExpiry: failed for lease ${leaseDoc.id}`, leaseError);
            }
        }
    }
    catch (error) {
        functions.logger.error("onLeaseExpiry: query failed", error);
        throw error;
    }
});
//# sourceMappingURL=index.js.map