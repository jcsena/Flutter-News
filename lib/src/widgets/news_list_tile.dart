import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';


class NewsListTile extends StatelessWidget {

  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(stream: bloc.items, 
    builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>>snapshot){
      if(!snapshot.hasData){
        return Text('Stream still loading');
      }
      return FutureBuilder(future: snapshot.data[itemId],
      builder: (context, AsyncSnapshot<ItemModel>itemSnapShot){
          if(!itemSnapShot.hasData){
            return Text('Loading item $itemId...');
          }
          return Text(itemSnapShot.data.title);
      },);

    },);
  }
}