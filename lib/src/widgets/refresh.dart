import 'package:flutter/material.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  final bloc;

  Refresh({this.child, this.bloc});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
    );
  }
}
