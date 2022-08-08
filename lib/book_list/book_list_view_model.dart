import 'package:cloud_firestore/cloud_firestore.dart';

class BookListViewModel {
  final db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> get bookStream => db.collection('books').snapshots();
}