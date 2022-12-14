import 'package:book_list_app/update_book/update_book_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateBookScreen extends StatefulWidget {
  final DocumentSnapshot document;

  const UpdateBookScreen(this.document, {Key? key}) : super(key: key);

  @override
  State<UpdateBookScreen> createState() => _UpdateBookScreenState();
}

class _UpdateBookScreenState extends State<UpdateBookScreen> {
  final _titleTextController = TextEditingController();
  final _authorTextController = TextEditingController();

  final viewModel = UpdateBookViewModel();

  @override
  void initState() {
    super.initState();

    _titleTextController.text = widget.document['title'];
    _authorTextController.text = widget.document['author'];
  }

  @override
  void dispose() {
    _authorTextController.dispose();
    _titleTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('도서 갱신'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (_) {
                  setState(() {});
                },
                controller: _titleTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '제목',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (_) {
                  setState(() {});
                },
                controller: _authorTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '저자',
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Validation
          try {
            // 에러가 날 것 같은 코드
            viewModel.updateBook(
              id: widget.document.id,
              title: _titleTextController.text,
              author: _authorTextController.text,
            );
            Navigator.pop(context);
          } catch (e) {
            // 에러가 났을 때
            final snackBar = SnackBar(
              content: Text(e.toString()),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } finally {
            //[옵션] 에러에 상관없이 해야하는 코드
          }
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
