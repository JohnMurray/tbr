import 'widget/book_list/reducer.dart';
import 'widget/navigation/reducer.dart';

class AppState {
  NavigationState nav;
  BookListState bookListState;

  AppState({
    this.bookListState,
    this.nav,
  });

  AppState.initialState() {
    this.bookListState = BookListState.initialState();
    this.nav = NavigationState.initialState();
  }

}

AppState reducer(AppState state, dynamic _action) => new AppState(
  nav: navigationReducer(state.nav, _action),
  bookListState: bookListStateReducer(state.bookListState, _action),
);