import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pro_app/features/auth/data/user_model.dart';

class UserRepository {
  UserRepository(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _db.collection('users');

  // stream to watch userProfile -- (currentUserPprofile)
  Stream<UserModel?> watchUser(String uid) => _collection
      .doc(uid)
      .snapshots()
      .map((doc) => doc.exists ? UserModel.fromFirestore(doc) : null);

  // fetch userProfile (once) -- used by admin to see useprofile
  Future<UserModel?> fetch(String uid) async {
    final doc = await _collection.doc(uid).get();
    return doc.exists ? UserModel.fromFirestore(doc) : null;
  }

  // update profile(currentUser)
  Future<void> updateProfile(
    String uid, {
    String? name,
    String? phone,
    String? profileImage,
  }) => _collection.doc(uid).update({
    if (name != null) 'name': name,
    if (phone != null) 'phone': phone,
    if (profileImage != null) 'profile_image': profileImage,
    'updated_at': FieldValue.serverTimestamp(),
  });
}
