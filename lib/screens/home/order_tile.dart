import 'package:flutter/material.dart';
import 'package:flutter_project/models/order.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  OrderTile({this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
          ), //image on left
          title: Text(order.name),
          subtitle: Text(
              'Rice: ${order.rice ~/ 100}\nDish: ${order.dish}\nSides: ${order.sides}'),
        ),
      ),
    );
  }
}
