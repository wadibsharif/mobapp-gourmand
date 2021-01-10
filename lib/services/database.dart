import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/models/order.dart';

class DatabaseService {
  final String userID;
  DatabaseService({this.userID});

  //collection reference
  final CollectionReference orderDetails =
      Firestore.instance.collection('orders');

  Future updateUserData(
      String name, int rice, String dish, String sides) async {
    return await orderDetails.document(userID).setData({
      'name': name,
      'rice': rice,
      'dish': dish,
      'sides': sides,
    });
  }

  //orderlist from snapshot
  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Order(
        name: doc.data['name'] ?? '',
        rice: doc.data['rice'] ?? 0,
        dish: doc.data['dish'] ?? '0',
        sides: doc.data['sides'] ?? '0',
      );
    }).toList();
  }

  //get orders stream
  Stream<List<Order>> get orders {
    return orderDetails.snapshots().map(_orderListFromSnapshot);
  }
}
