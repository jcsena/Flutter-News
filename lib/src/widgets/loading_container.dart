import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(right: 150.0),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }

  Widget buildContainer({double right: 10.0}) {
    return Container(
      color: Colors.grey[100],
      height: 24.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: right),
    );
  }
}
