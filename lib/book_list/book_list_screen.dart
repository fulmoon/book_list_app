import 'package:book_list_app/add_book/add_book_screen.dart';
import 'package:book_list_app/update_book/update_book_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_list_app/book_list/book_list_view_model.dart';
import 'package:flutter/material.dart';

class BookListScreen extends StatelessWidget {
  BookListScreen({Key? key}) : super(key: key);

  final viewModel = BookListViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('도서 리스트 앱'),
      ), //AppBar
      body: StreamBuilder<QuerySnapshot>(
          stream: viewModel.bookStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading');
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Dismissible(
                  onDismissed: (_) {
                    viewModel.deleteBook(document.id);
                  },
                  background: Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  key: ValueKey(document.id),
                  child: ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateBookScreen(document)),
                      );
                    },
                    title: Text(data['title']),
                    subtitle: Text(data['author']),
                    leading: Image.network(data['imageUrl'], width: 50, height: 100, fit: BoxFit.cover,)
                  ),
                );
              }).toList(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBookScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
