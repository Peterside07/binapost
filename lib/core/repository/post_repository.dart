import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/models/post_model.dart';

class PostRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PostModel>> fetchPosts() async {
    try {
      final querySnapshot = await _firestore.collection('post').get();
      return querySnapshot.docs.map((doc) {
        return PostModel.fromMap(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }
}
