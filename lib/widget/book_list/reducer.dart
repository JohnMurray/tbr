class Book {
  String name;
}

class BookListState {
  List<Book> bookList;

  BookListState({this.bookList});

  BookListState.initialState() {
    this.bookList = List();
  }
}

BookListState bookListStateReducer(BookListState state, dynamic action) {
  return state;
}
