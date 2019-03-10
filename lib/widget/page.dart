import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../reducer.dart';
import 'navigation/widget.dart';
import 'title.dart';

class _ViewState {
  final String activePageKey;
  _ViewState({this.activePageKey});
}
// TODO: Set the key from the nav-state, once it's hooked up
_ViewState _stateBuilder(Store<AppState> store) => _ViewState(activePageKey: true);

/// Represents a page that is navigable to other sub-pages or is navigable back
/// to a previous page. This can be used in one of two ways.
///   * Specifying children will not display a bottom navigation and will render
///     as only one page. This often used with the back-button.
///   * Specifying subPages will generate a bottom navigation and handle switching
///     between the pages
///
/// Since this Widget lays things out using the Scaffold, you should only be
/// creating top-level components with this class and not nesting NavigablePage
/// objects within each other (That's what `subPages` are for)..
class NavigablePage extends StatelessWidget {
  final String title;
  final bool showBackButton;

  final List<Widget> children;
  final List<NavigableSubPage> subPages;

  NavigablePage({
    Key key,
    this.title,
    this.children,
    this.subPages,
    this.showBackButton = true,
  }) : super(key: key) {
    if (this.children == null && this.subPages == null) {
      throw "Must provide either 'children' for 'subPages' to render a page";
    }
    if (this.children != null && this.subPages != null) {
      throw "Cannot provide both 'children' and 'subPages'. Only one is allowed";
    }
  }

  Widget build(BuildContext ctx) {
    var buildChildren = <Widget>[];
    buildChildren
      ..addAll(<Widget>[
        AppHeaderMenu(renderBackButton: showBackButton),
        AppHeaderTitle(title: title),
      ])
      ..addAll(children);

    return Scaffold(
      body: Column(children: buildChildren),
      bottomNavigationBar: subPages.isNotEmpty ? BottomNavigation() : null,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: null,
        onPressed: () {},
        elevation: 2.0,
      ),
    );
  }
}

/// A NavigablePage that uses a bottom-navigation bar will require sub-pages to
/// be rendered. This represents the sub-page and also helps build the navigation
/// bar dynamically.
///
/// @see NavigablePage
abstract class NavigableSubPage {
  /// A unique value to identify the active page
  /// Required, non-nul
  final String key;

  /// The icon to display on the bottom navigation
  /// Required, non-nul
  final Icon navIcon;

  /// The title shown below the navigation icon.
  /// Required, non-null
  final String navTitle;

  /// The floating action button to display if one is needed on the page.
  /// Optional.
  final FloatingActionButton floatingActionButton;

  NavigableSubPage({
    this.key,
    this.navIcon,
    this.navTitle,
    this.floatingActionButton,
  }) {
    if (this.key == null || this.key.isEmpty) {
      throw "Must provide a non-null, non-empty value for 'key'";
    }
    if (this.navIcon == null) {
      throw "Must provide a non-null value for 'navIcon'";
    }
    if (this.navTitle == null || this.navTitle.isEmpty) {
      throw "Must provide a non-null, nom-epty value for 'navTitle'";
    }
  }

  /// Build returns the top-level widget displayed within the main content area
  /// of the page
  Widget build(BuildContext ctx);
}