import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import './loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (context,
          AsyncSnapshot<Map<int, Map<int, Future<ItemModel>>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        //  snapshot.data[itemId].
        return FutureBuilder(
          future: snapshot.data[itemId][1],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapShot) {
            if (!itemSnapShot.hasData) {
              return FutureBuilder(
                future: snapshot.data[itemId][0],
                builder: (context, AsyncSnapshot<ItemModel> itemSnapShot) {
                  if (!itemSnapShot.hasData) {
                    return LoadingContainer();
                  }
                  return buildTile(itemSnapShot.data);
                },
              );
            }
            return buildTile(itemSnapShot.data);
          },
        );
      },
    );
  }

  Widget buildTile(ItemModel item) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(item.title),
          subtitle: Text('${item.score} points'),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }
}
