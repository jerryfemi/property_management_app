// PropApp Firestore Seed Script
//
// How to run:
//   1. npm install firebase-admin
//   2. Place serviceAccountKey.json in this same folder
//   3. node seed_firestore.js
//
// Notes:
// - This script is idempotent. Running it again overwrites the same docs.
// - It also calculates total_units and available_units without Cloud Functions.

const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();
const now = admin.firestore.FieldValue.serverTimestamp();

function unit(
    propertyId,
    unitNumber,
    bedrooms,
    bathrooms,
    baseRent,
    amenities = [],
    status = "available"
) {
    return {
        property_id: propertyId,
        unit_number: unitNumber,
        bedrooms,
        bathrooms,
        base_rent: baseRent,
        amenities,
        unit_status: status,
        current_tenant_id: null,
        floor_plan_url: null,
        created_at: now,
        updated_at: now,
    };
}

const properties = [
    {
        id: "prop_lekki_gardens",
        data: {
            title: "Lekki Gardens Estate",
            description:
                "Experience premium living at Lekki Gardens Estate. Located in the heart of Phase 1, this modern complex offers serene environments, top-notch security, and world-class facilities perfect for professionals and families.",
            address: "Block 14, Admiralty Way",
            city: "Lagos",
            state: "Lagos",
            property_type: "apartment",
            rent_period: "yearly",
            amenities: ["pool", "security", "generator", "gym", "water"],
            image_urls: [
                "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800&q=80",
                "https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800&q=80",
            ],
            is_furnished: false,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_vi_heights",
        data: {
            title: "Victoria Island Heights",
            description:
                "Luxury serviced apartments in the heart of Victoria Island. Walking distance to major corporate offices, fine dining, and the lagoon. Fully furnished with premium finishes throughout.",
            address: "10 Adeola Odeku Street",
            city: "Lagos",
            state: "Lagos",
            property_type: "apartment",
            rent_period: "yearly",
            amenities: ["security", "generator", "water", "concierge", "parking"],
            image_urls: [
                "https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800&q=80",
                "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=800&q=80",
            ],
            is_furnished: true,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_ikoyi_villas",
        data: {
            title: "Ikoyi Luxury Villas",
            description:
                "Exclusive detached villas set within a private gated community in Old Ikoyi. Each villa comes with a private garden, dedicated parking for 4 cars, and direct access to the community clubhouse.",
            address: "15 Glover Road",
            city: "Lagos",
            state: "Lagos",
            property_type: "house",
            rent_period: "yearly",
            amenities: ["pool", "security", "generator", "gym", "water", "garden"],
            image_urls: [
                "https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde?w=800&q=80",
                "https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=800&q=80",
            ],
            is_furnished: false,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_surulere_flats",
        data: {
            title: "Surulere Modern Flats",
            description:
                "Newly built modern flats in a central Surulere location. Ideal for young professionals seeking quality accommodation close to Lagos Island without the premium price tag.",
            address: "22 Adeniran Ogunsanya Street",
            city: "Lagos",
            state: "Lagos",
            property_type: "apartment",
            rent_period: "yearly",
            amenities: ["security", "generator", "water", "parking"],
            image_urls: [
                "https://images.unsplash.com/photo-1574362848149-11496d93a7c7?w=800&q=80",
            ],
            is_furnished: false,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_ajah_court",
        data: {
            title: "Ajah Court Residences",
            description:
                "Spacious family apartments in the fast-growing Ajah corridor. Close to international schools, shopping malls, and the Lekki-Epe Expressway. Large compound with ample parking.",
            address: "5 Abraham Adesanya Road",
            city: "Lagos",
            state: "Lagos",
            property_type: "apartment",
            rent_period: "yearly",
            amenities: ["security", "generator", "water", "parking", "playground"],
            image_urls: [
                "https://images.unsplash.com/photo-1560185007-cde436f6a4d0?w=800&q=80",
                "https://images.unsplash.com/photo-1486325212027-8081e485255e?w=800&q=80",
            ],
            is_furnished: false,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_yaba_studio",
        data: {
            title: "Yaba Studio Apartments",
            description:
                "Purpose-built studio and one-bedroom apartments in the heart of Yaba's tech hub. Perfect for developers, designers and startup founders who want to live steps from their office.",
            address: "18 Herbert Macaulay Way",
            city: "Lagos",
            state: "Lagos",
            property_type: "apartment",
            rent_period: "yearly",
            amenities: ["security", "generator", "water", "wifi"],
            image_urls: [
                "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800&q=80",
            ],
            is_furnished: true,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_magodo_estate",
        data: {
            title: "Magodo Phase 2 Homes",
            description:
                "Detached and semi-detached homes in the prestigious Magodo Phase 2. Quiet, residential neighbourhood with excellent road infrastructure, estate security, and proximity to GRA.",
            address: "Plot 45 Magodo Phase 2",
            city: "Lagos",
            state: "Lagos",
            property_type: "house",
            rent_period: "yearly",
            amenities: ["security", "generator", "water", "parking", "garden"],
            image_urls: [
                "https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800&q=80",
                "https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=800&q=80",
            ],
            is_furnished: false,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_oniru_shortlet",
        data: {
            title: "Oniru Shortlet Suites",
            description:
                "Premium shortlet suites steps from Oniru Private Beach. Fully furnished and serviced with hotel-standard housekeeping. Ideal for business travellers and extended vacation stays.",
            address: "3 Oniru Road",
            city: "Lagos",
            state: "Lagos",
            property_type: "shortLet",
            rent_period: "nightly",
            amenities: [
                "pool",
                "security",
                "generator",
                "gym",
                "water",
                "concierge",
                "wifi",
            ],
            image_urls: [
                "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&q=80",
                "https://images.unsplash.com/photo-1591088398332-8a7791972843?w=800&q=80",
            ],
            is_furnished: true,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_gbagada_duplex",
        data: {
            title: "Gbagada Executive Duplexes",
            description:
                "Brand new executive duplexes in a serene Gbagada estate. Each unit spans 4 floors with a rooftop terrace, fitted kitchen, and BQ quarters. Excellent value in a well-established neighbourhood.",
            address: "12 Tony Anegbode Street",
            city: "Lagos",
            state: "Lagos",
            property_type: "house",
            rent_period: "yearly",
            amenities: ["security", "generator", "water", "parking", "bq"],
            image_urls: [
                "https://images.unsplash.com/photo-1600585154526-990dced4db0d?w=800&q=80",
            ],
            is_furnished: false,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_chevron_selfcon",
        data: {
            title: "Chevron Self-Contain Units",
            description:
                "Well-maintained self-contain units within a secure compound on the Chevron Drive axis. Great for single occupants or young couples. Close to Shoprite, cinemas, and major bus stops.",
            address: "Chevron Drive, Lekki",
            city: "Lagos",
            state: "Lagos",
            property_type: "selfCon",
            rent_period: "yearly",
            amenities: ["security", "generator", "water"],
            image_urls: [
                "https://images.unsplash.com/photo-1493809842364-78817add7ffb?w=800&q=80",
            ],
            is_furnished: false,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    // --- Additional properties ---
    {
        id: "prop_abuja_asokoro",
        data: {
            title: "Asokoro Ridge Residences",
            description:
                "Upscale residences in Asokoro with embassy-district proximity, private security, and panoramic city views.",
            address: "14 Yakubu Gowon Crescent",
            city: "Abuja",
            state: "FCT",
            property_type: "house",
            rent_period: "yearly",
            amenities: ["security", "generator", "water", "parking", "garden"],
            image_urls: [
                "https://images.unsplash.com/photo-1572120360610-d971b9d7767c?w=800&q=80",
            ],
            is_furnished: false,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_abuja_wuse",
        data: {
            title: "Wuse Central Apartments",
            description:
                "Modern apartments in Wuse 2 with fast access to business hubs, malls, and restaurants.",
            address: "9 Aminu Kano Crescent",
            city: "Abuja",
            state: "FCT",
            property_type: "apartment",
            rent_period: "yearly",
            amenities: ["security", "generator", "water", "parking"],
            image_urls: [
                "https://images.unsplash.com/photo-1565182999561-18d7dc61c393?w=800&q=80",
            ],
            is_furnished: true,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_portharcourt_gra",
        data: {
            title: "Port Harcourt GRA Suites",
            description:
                "Serviced suites in GRA with backup power, security, and concierge services.",
            address: "5 Liberation Stadium Road",
            city: "Port Harcourt",
            state: "Rivers",
            property_type: "apartment",
            rent_period: "yearly",
            amenities: ["security", "generator", "water", "concierge", "wifi"],
            image_urls: [
                "https://images.unsplash.com/photo-1554995207-c18c203602cb?w=800&q=80",
            ],
            is_furnished: true,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_kano_city",
        data: {
            title: "Kano City Gardens",
            description:
                "Family-friendly estate in Kano with strong community security and open green spaces.",
            address: "12 Zoo Road",
            city: "Kano",
            state: "Kano",
            property_type: "house",
            rent_period: "yearly",
            amenities: ["security", "generator", "water", "parking", "garden"],
            image_urls: [
                "https://images.unsplash.com/photo-1502005229762-cf1b2da7c5d6?w=800&q=80",
            ],
            is_furnished: false,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_ibadan_bodija",
        data: {
            title: "Bodija Heights",
            description:
                "Comfortable apartments in Bodija with reliable utilities and easy access to schools.",
            address: "7 Bodija Estate Road",
            city: "Ibadan",
            state: "Oyo",
            property_type: "apartment",
            rent_period: "yearly",
            amenities: ["security", "generator", "water", "parking"],
            image_urls: [
                "https://images.unsplash.com/photo-1480074568708-e7b720bb3f09?w=800&q=80",
            ],
            is_furnished: false,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_enugu_newhaven",
        data: {
            title: "New Haven Lofts",
            description:
                "Stylish lofts in Enugu with modern finishes, secure parking, and strong water supply.",
            address: "3 Chime Avenue",
            city: "Enugu",
            state: "Enugu",
            property_type: "apartment",
            rent_period: "yearly",
            amenities: ["security", "generator", "water", "parking"],
            image_urls: [
                "https://images.unsplash.com/photo-1494526585095-c41746248156?w=800&q=80",
            ],
            is_furnished: true,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_uyo_greens",
        data: {
            title: "Uyo Green Estate",
            description:
                "Quiet gated estate in Uyo with children-friendly spaces and on-site maintenance.",
            address: "6 Oron Road",
            city: "Uyo",
            state: "Akwa Ibom",
            property_type: "house",
            rent_period: "yearly",
            amenities: ["security", "generator", "water", "parking", "playground"],
            image_urls: [
                "https://images.unsplash.com/photo-1449844908441-8829872d2607?w=800&q=80",
            ],
            is_furnished: false,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_lekki_coastal",
        data: {
            title: "Lekki Coastal View",
            description:
                "Waterfront apartments with ocean breezes and private balconies near the coastal road.",
            address: "2 Coastal Road",
            city: "Lekki",
            state: "Lagos",
            property_type: "apartment",
            rent_period: "yearly",
            amenities: ["security", "generator", "water", "parking", "pool"],
            image_urls: [
                "https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=800&q=80",
            ],
            is_furnished: true,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_kaduna_miniflats",
        data: {
            title: "Kaduna Mini Flats",
            description:
                "Affordable mini flats with prepaid meters and reliable water supply in Kaduna North.",
            address: "11 Ali Akilu Road",
            city: "Kaduna",
            state: "Kaduna",
            property_type: "selfCon",
            rent_period: "yearly",
            amenities: ["security", "water"],
            image_urls: [
                "https://images.unsplash.com/photo-1507089947368-19c1da9775ae?w=800&q=80",
            ],
            is_furnished: false,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
    {
        id: "prop_owerri_gra",
        data: {
            title: "Owerri GRA Terraces",
            description:
                "Modern terrace homes in Owerri GRA with security patrols and stable utilities.",
            address: "4 Government House Road",
            city: "Owerri",
            state: "Imo",
            property_type: "house",
            rent_period: "yearly",
            amenities: ["security", "generator", "water", "parking"],
            image_urls: [
                "https://images.unsplash.com/photo-1449844908441-8829872d2607?w=800&q=80",
            ],
            is_furnished: false,
            is_published: true,
            total_units: 0,
            available_units: 0,
            created_at: now,
            updated_at: now,
        },
    },
];

const units = [];

function addUnits(propertyId, configs) {
    configs.forEach((config) => {
        const [unitNumber, bedrooms, bathrooms, baseRent, amenities, status] =
            config;
        units.push(
            unit(
                propertyId,
                unitNumber,
                bedrooms,
                bathrooms,
                baseRent,
                amenities,
                status
            )
        );
    });
}

addUnits("prop_lekki_gardens", [
    ["A1", 1, 1, 2500000, ["balcony", "ac"]],
    ["A2", 1, 1, 2500000, ["balcony", "ac"]],
    ["B1", 2, 2, 3500000, ["balcony", "ac", "en-suite"]],
    ["B2", 2, 2, 3500000, ["balcony", "ac", "en-suite"]],
    ["C1", 3, 3, 5500000, ["balcony", "ac", "en-suite", "bq"]],
]);

addUnits("prop_vi_heights", [
    ["101", 1, 1, 4200000, ["furnished", "ac", "balcony"]],
    ["102", 1, 1, 4200000, ["furnished", "ac", "balcony"]],
    ["201", 2, 2, 6500000, ["furnished", "ac", "balcony", "en-suite"]],
    ["202", 2, 2, 6500000, ["furnished", "ac", "balcony", "en-suite"]],
]);

addUnits("prop_ikoyi_villas", [
    ["Villa 1", 4, 4, 18000000, ["garden", "bq", "ac", "en-suite", "pool"]],
    ["Villa 2", 4, 4, 18000000, ["garden", "bq", "ac", "en-suite", "pool"]],
    [
        "Villa 3",
        5,
        5,
        25000000,
        ["garden", "bq", "ac", "en-suite", "pool", "cinema"],
    ],
]);

addUnits("prop_surulere_flats", [
    ["1A", 1, 1, 1200000, ["ac"]],
    ["1B", 1, 1, 1200000, ["ac"]],
    ["2A", 2, 1, 1800000, ["ac"]],
    ["2B", 2, 1, 1800000, ["ac"]],
    ["3A", 3, 2, 2500000, ["ac", "en-suite"]],
]);

addUnits("prop_ajah_court", [
    ["101", 2, 2, 2200000, ["ac", "balcony"]],
    ["102", 2, 2, 2200000, ["ac", "balcony"]],
    ["201", 3, 3, 3200000, ["ac", "balcony", "en-suite"]],
    ["202", 3, 3, 3200000, ["ac", "balcony", "en-suite"]],
    ["301", 4, 4, 4500000, ["ac", "balcony", "en-suite", "bq"]],
]);

addUnits("prop_yaba_studio", [
    ["S01", 0, 1, 800000, ["furnished", "wifi"]],
    ["S02", 0, 1, 800000, ["furnished", "wifi"]],
    ["1A", 1, 1, 1200000, ["furnished", "wifi", "balcony"]],
    ["1B", 1, 1, 1200000, ["furnished", "wifi", "balcony"]],
]);

addUnits("prop_magodo_estate", [
    ["House 1", 4, 4, 12000000, ["garden", "bq", "ac", "parking"]],
    ["House 2", 4, 4, 12000000, ["garden", "bq", "ac", "parking"]],
    [
        "House 3",
        5,
        5,
        16000000,
        ["garden", "bq", "ac", "parking", "pool"],
    ],
]);

addUnits("prop_oniru_shortlet", [
    ["Suite A", 1, 1, 85000, ["furnished", "wifi", "ac", "housekeeping"]],
    ["Suite B", 1, 1, 85000, ["furnished", "wifi", "ac", "housekeeping"]],
    [
        "Suite C",
        2,
        2,
        150000,
        ["furnished", "wifi", "ac", "housekeeping", "ocean-view"],
    ],
    [
        "Penthouse",
        3,
        3,
        250000,
        ["furnished", "wifi", "ac", "housekeeping", "ocean-view", "terrace"],
    ],
]);

addUnits("prop_gbagada_duplex", [
    ["Duplex 1", 4, 4, 9000000, ["bq", "rooftop", "ac", "en-suite"]],
    ["Duplex 2", 4, 4, 9000000, ["bq", "rooftop", "ac", "en-suite"]],
    [
        "Duplex 3",
        4,
        4,
        9500000,
        ["bq", "rooftop", "ac", "en-suite", "garden"],
    ],
]);

addUnits("prop_chevron_selfcon", [
    ["SC-01", 0, 1, 600000, ["ac"]],
    ["SC-02", 0, 1, 600000, ["ac"]],
    ["SC-03", 0, 1, 650000, ["ac", "extra-room"]],
    ["1BD-01", 1, 1, 950000, ["ac"]],
    ["1BD-02", 1, 1, 950000, ["ac"]],
]);

addUnits("prop_abuja_asokoro", [
    ["Villa A", 4, 4, 15000000, ["garden", "ac", "bq", "en-suite"]],
    ["Villa B", 4, 4, 15000000, ["garden", "ac", "bq", "en-suite"]],
    ["Villa C", 5, 5, 22000000, ["garden", "ac", "bq", "en-suite"]],
]);

addUnits("prop_abuja_wuse", [
    ["101", 1, 1, 4500000, ["furnished", "ac", "balcony"]],
    ["102", 1, 1, 4500000, ["furnished", "ac", "balcony"]],
    ["201", 2, 2, 6500000, ["furnished", "ac", "balcony", "en-suite"]],
]);

addUnits("prop_portharcourt_gra", [
    ["A1", 1, 1, 3500000, ["furnished", "ac", "wifi"]],
    ["B1", 2, 2, 5200000, ["furnished", "ac", "wifi", "en-suite"]],
    ["B2", 2, 2, 5200000, ["furnished", "ac", "wifi", "en-suite"]],
]);

addUnits("prop_kano_city", [
    ["H1", 3, 3, 4000000, ["garden", "ac", "parking"]],
    ["H2", 3, 3, 4000000, ["garden", "ac", "parking"]],
]);

addUnits("prop_ibadan_bodija", [
    ["1A", 2, 2, 2200000, ["ac", "balcony"]],
    ["1B", 2, 2, 2200000, ["ac", "balcony"]],
    ["2A", 3, 3, 3200000, ["ac", "balcony", "en-suite"]],
]);

addUnits("prop_enugu_newhaven", [
    ["L1", 1, 1, 2000000, ["ac", "parking"]],
    ["L2", 2, 2, 2800000, ["ac", "parking"]],
]);

addUnits("prop_uyo_greens", [
    ["A", 3, 3, 3800000, ["garden", "ac", "parking"]],
    ["B", 4, 4, 5200000, ["garden", "ac", "parking", "bq"]],
]);

addUnits("prop_lekki_coastal", [
    ["101", 2, 2, 4800000, ["balcony", "ac", "ocean-view"]],
    ["102", 2, 2, 4800000, ["balcony", "ac", "ocean-view"]],
    ["201", 3, 3, 6200000, ["balcony", "ac", "ocean-view"]],
]);

addUnits("prop_kaduna_miniflats", [
    ["M1", 0, 1, 700000, ["ac"]],
    ["M2", 0, 1, 700000, ["ac"]],
    ["M3", 1, 1, 950000, ["ac"]],
]);

addUnits("prop_owerri_gra", [
    ["T1", 3, 3, 4200000, ["ac", "parking"]],
    ["T2", 3, 3, 4200000, ["ac", "parking"]],
    ["T3", 4, 4, 5500000, ["ac", "parking", "bq"]],
]);

function summarizeUnits() {
    return units.reduce(
        (acc, u) => {
            const entry = acc[u.property_id] || { total: 0, available: 0 };
            entry.total += 1;
            if (u.unit_status === "available") {
                entry.available += 1;
            }
            acc[u.property_id] = entry;
            return acc;
        },
        {}
    );
}

async function seed() {
    console.log("Starting PropApp seed...");

    const unitSummary = summarizeUnits();

    console.log(`Writing ${properties.length} properties...`);
    for (const prop of properties) {
        const summary = unitSummary[prop.id] || { total: 0, available: 0 };
        await db.collection("properties").doc(prop.id).set({
            ...prop.data,
            total_units: summary.total,
            available_units: summary.available,
        });
        console.log(`  Wrote ${prop.data.title}`);
    }

    console.log(`Writing ${units.length} units...`);
    const batch = db.batch();
    for (const u of units) {
        const unitId = `${u.property_id}_${u.unit_number.replace(/\s/g, "_")}`;
        const ref = db.collection("units").doc(unitId);
        batch.set(ref, u);
    }
    await batch.commit();
    console.log(`  Wrote ${units.length} units`);

    const adminUid = process.env.PROPAPP_ADMIN_UID || "REPLACE_WITH_YOUR_UID";
    await db.collection("users").doc(adminUid).set({
        name: "Admin User",
        phone: "+2348000000000",
        role: "admin",
        profile_image: null,
        created_at: now,
        updated_at: now,
    });
    console.log("Admin user doc written. Update PROPAPP_ADMIN_UID if needed.");

    console.log("Seed complete.");
    process.exit(0);
}

seed().catch((err) => {
    console.error("Seed failed:", err);
    process.exit(1);
});
