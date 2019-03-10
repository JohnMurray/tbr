import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../reducer.dart';
import 'reducer.dart';

class _ViewState {
  List<Book> books;

  _ViewState({this.books});
}

_ViewState _viewStateBuilder(Store<AppState> store) =>
    _ViewState(books: store.state.bookListState.bookList);

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return StoreConnector<AppState, _ViewState>(
      converter: _viewStateBuilder,
      builder: (context, mod) {
        return Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: buildBookList()
          ),
        );
      },
    );
  }

  List<Widget> buildBookList() {
    return <Widget>[
      Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Text('start'),
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[ Text('stuff') ],
                )
              )
            ]
          )
        )
      )
    ];
  }
}
