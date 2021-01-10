import 'package:flutter/material.dart';
import 'package:flutter_project/models/order.dart';
import 'package:provider/provider.dart';
import 'order_tile.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context);

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderTile(order: orders[index]);
      },
    );
  }
}
