import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../reducer.dart';
import '../page.dart';
import 'reducer.dart' as navv;

class _ViewState {
  void Function(int index) menuTapCallback;
  navv.NavigationState nav;

  _ViewState({this.nav, this.menuTapCallback});
}

_ViewState _viewStateBuilder(Store<AppState> store) => _ViewState(
  // state
    nav: store.state.nav,

    // actions
    menuTapCallback: (int index) {
      switch(index) {
        case 0: store.dispatch(navv.NavActions.SwitchToBookList);break;
        default:
      }
    }
);

class BottomNavigation extends StatelessWidget {
  final List<NavigableSubPage> subPages;

  BottomNavigation({Key key, this.subPages}): super(key: key);

  menuTabCallback(int index) {

  }

  getIndex(String key) {
    return subPages.indexWhere((nsp) => nsp.key == key);
  }

  @override
  Widget build(BuildContext ctx) {
    return StoreConnector<AppState, _ViewState>(
      converter: _viewStateBuilder,
      builder: (context, mod) {
        return new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: mod.nav.navIndex,
          iconSize: 26.0,
          onTap: mod.menuTapCallback,
          items: subPages.map((nsp) => new BottomNavigationBarItem(
            icon: nsp.navIcon,
            title: Text(nsp.navTitle),
          )),
        );
      },
    );
  }
}
