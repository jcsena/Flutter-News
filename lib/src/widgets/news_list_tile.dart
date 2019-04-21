import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import './loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;
  final bloc;

  NewsListTile({this.itemId, this.bloc});

  @override
  Widget build(BuildContext context) {
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
                  return buildTile(context: context, item: itemSnapShot.data);
                },
              );
            }
            return buildTile(context: context, item: itemSnapShot.data);
          },
        );
      },
    );
  }

  Widget buildTile({BuildContext context, ItemModel item}) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/${item.id}');
          },
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
