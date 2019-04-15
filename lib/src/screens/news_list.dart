import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import '../widgets/news_list_tile.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    bloc.fetchTopIds();
    return Scaffold(
        appBar: AppBar(
          title: Text('Top News'),
        ),
        body: builList(bloc));
  }

  Widget builList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, int index) {
            final int itemId = snapshot.data[index];
            bloc.fetchItem(itemId);
            return  NewsListTile(itemId: itemId,);
          },
        );
      },
    );
  }
}
