import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

final _fs = Provider<FirebaseFirestore>((_) => FirebaseFirestore.instance);

final usersInCompanyProvider =
    FutureProvider.family<List<AppUser>, String>((ref, companyId) async {
  final fs = ref.read(_fs);
  final q = await fs
      .collection('users')
      .where('companyId', isEqualTo: companyId)
      .limit(500)
      .get();
  return q.docs
      .map((d) => AppUser.fromDoc(d))
      .toList();
});
