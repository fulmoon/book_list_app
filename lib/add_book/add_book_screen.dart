import 'package:book_list_app/add_book/add_book_view_model.dart';
import 'package:flutter/material.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({Key? key}) : super(key: key);

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _titleTextController = TextEditingController();
  final _authorTextController = TextEditingController();

  final viewModel = AddBookViewModel();

  @override
  void dispose() {
    _titleTextController.dispose();
    _authorTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('도서 추가'),
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
            ),
            ElevatedButton(
                onPressed: viewModel.isValid(
                  _titleTextController.text,
                  _authorTextController.text,
                )
                    ? () {
                        viewModel.addBook(
                          title: _titleTextController.text,
                          author: _authorTextController.text,
                        );

                        Navigator.pop(context);
                      }
                    : null,
                child: const Text('도서추가'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.addBook(
            title: _titleTextController.text,
            author: _authorTextController.text,
          );

          Navigator.pop(context);
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
