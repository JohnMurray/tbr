class NavigationState {
  NavigationState({this.item, this.navIndex});

  NavigationState.initialState() {
    item = NavItem.BookList;
    navIndex = 0;
    pageTitle = 'TBR Jar';
  }

  /// The index of the nav-item selected (used by widgets)
  int navIndex;

  /// Human-readable enum of the current page
  NavItem item;

  /// Title of the currently selected page */
  String pageTitle;
}

enum NavItem {
  BookList
}

enum NavActions {
  SwitchToBookList,
}

NavigationState navigationReducer(NavigationState state, dynamic action) {
  if (action is NavActions) {
    switch(action) {
      case NavActions.SwitchToBookList:
        state.navIndex = 0;
        state.item = NavItem.BookList;
        state.pageTitle = 'TBR Jar';
        break;
    }
  }
  return state;
}
