import 'package:todoapp/add_book/add_book_page.dart';
import 'package:todoapp/book_list/book_list_model.dart';
import 'package:todoapp/domain/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/edit_book/edit_book_page.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBookList(), //画面起動した時にこの関数する
      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
        ),
        body: Center(
          child: Consumer<BookListModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;

            if (books == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = books
                .map(
                  (book) => Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    child: ListTile(
                      title: Text(book.title),
                      subtitle: Text(book.author),
                    ),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                          caption: '編集',
                          color: Colors.black45,
                          icon: Icons.more_horiz,
                          onTap: () async {
                            final String? title = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditBookPage(book),
                                ));

                            if (title != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.grey,
                                      content: Text("${title}を編集しました")));
                            }
                            model.fetchBookList();
                          }),
                      IconSlideAction(
                          caption: '削除',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () => null),
                    ],
                  ),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              final bool? added = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBookPage(),
                    fullscreenDialog: true,
                  ));

              if (added != null && added) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green, content: Text("本を追加しました")));
              }
              model.fetchBookList();
            },
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }
}
