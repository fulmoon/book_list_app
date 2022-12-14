import 'dart:typed_data';

import 'package:book_list_app/add_book/add_book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({Key? key}) : super(key: key);

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _titleTextController = TextEditingController();
  final _authorTextController = TextEditingController();

  final viewModel = AddBookViewModel();

  final ImagePicker _picker = ImagePicker();

  //byte array
  Uint8List? _bytes;

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
        title: const Text('λμ μΆκ°'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        //byte array
                        _bytes = await image.readAsBytes();
                        setState(() {});
                      }
                    },
                    child: _bytes == null
                        ? Container(
                            width: 200,
                            height: 200,
                            color: Colors.grey,
                          )
                        : Image.memory(
                            _bytes!,
                            width: 200,
                            height: 200,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (_) {
                      setState(() {});
                    },
                    controller: _titleTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'μ λͺ©',
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
                      labelText: 'μ μ',
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: viewModel.isValid(
                      _titleTextController.text,
                      _authorTextController.text,
                    )
                        ? () async {
                            setState(() {
                              viewModel.startLoading();
                            });

                            await viewModel.addBook(
                              title: _titleTextController.text,
                              author: _authorTextController.text,
                              bytes: _bytes,
                            );
                            setState(() {
                              viewModel.endLoading();
                            });

                            Navigator.pop(context);
                          }
                        : null,
                    child: const Text('λμμΆκ°'))
              ],
            ),
            if (viewModel.isLoading)
              Container(
                color: Colors.black45,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
