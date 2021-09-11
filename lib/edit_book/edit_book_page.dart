import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/domain/book.dart';

import 'edit_book_model.dart';

class EditBookPage extends StatelessWidget {
  final Book book;
  EditBookPage(this.book);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditBookModel>(
      create: (_) => EditBookModel(book),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
        ),
        body: Center(
          child: Consumer<EditBookModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: model.titleController,
                    decoration: InputDecoration(
                      hintText: '本のタイトル',
                    ),
                    onChanged: (text) {
                      model.title = text;
                      model.setTitle(text);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: model.authorController,
                    decoration: InputDecoration(
                      hintText: '著者',
                    ),
                    onChanged: (text) {
                      model.author = text;
                      model.setAuthor(text);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: model.isUpdated()
                          ? () async {
                              try {
                                await model.updateBook();
                                Navigator.of(context).pop(model.title);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(e.toString())));
                              }
                            }
                          : null,
                      child: Text('更新する'))
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
