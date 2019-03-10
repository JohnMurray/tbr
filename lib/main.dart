import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'reducer.dart';
import 'widget/book_list/widget.dart';
import 'widget/feedback_page.dart';
import 'widget/halp_page.dart';
import 'widget/legal_stuff_page.dart';
import 'widget/navigation/reducer.dart' as nav;
import 'widget/page.dart';

void main() {
  final store = Store<AppState>(
    reducer,
    initialState: AppState.initialState(),
    middleware: [new LoggingMiddleware.printer()],
  );
  runApp(FlutterReduxApp(
    title: 'TBR Jar',
    store: store,
  ));
}

class FlutterReduxApp extends StatelessWidget {
  final Store<AppState> store;
  final String title;

  FlutterReduxApp({Key key, this.title, this.store}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.deepPurple,
        ),
        routes: {
          '/haalp': (ctx) => HalpPage(),
          '/feedback': (ctx) => FeedbackPage(),
          '/legal_stuff': (ctx) => LegalStuffPage(),
        },
        home: NavigablePage(
          showBackButton: false,
          children: <Widget>[buildBody()],
        ),
      )
    );
  }

  Widget buildBody() {
    var build = (nav.NavigationState state) {
      switch (state.item) {
        case nav.NavItem.BookList:
          return BookList();
      }
    };
    return StoreConnector<AppState, nav.NavigationState>(
      converter: (s) => s.state.nav,
      builder: (ctx, model) {
        return build(model);
      },
    );
  }
}
