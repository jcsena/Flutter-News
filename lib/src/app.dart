import 'package:flutter/material.dart';
import './screens/news_list.dart';
import './screens/news_detail.dart';
// import './blocs/stories_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => NewsList(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final String pathName = settings.name;
        final int itemId = int.parse(pathName.replaceFirst('/', ''));

        return MaterialPageRoute(
          builder: (BuildContext context) {
            return NewsDetail(
              itemId: itemId,
            );
          },
        );
      },
      onUnknownRoute: (RouteSettings settings) {
        return null;
      },
      // home: NewsList(),
    );
  }
}
