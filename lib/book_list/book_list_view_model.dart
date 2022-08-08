import 'package:cloud_firestore/cloud_firestore.dart';

class BookListViewModel {
  final _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> get bookStream => _db.collection('books').snapshots();

  void deleteBook(String id){
    _db.collection('books').doc(id).delete();
  }
}