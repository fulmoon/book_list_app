import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class BookListViewModel {
  final _db = FirebaseFirestore.instance;
  final _googleSingIn = GoogleSignIn();

  Stream<QuerySnapshot> get bookStream => _db.collection('books').snapshots();

  void deleteBook(String id){
    _db.collection('books').doc(id).delete();
  }

  void logout() async {
    await _googleSingIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}