import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/models/order.dart';
import 'package:flutter_project/models/user.dart';

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

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      userID: userID,
      name: snapshot.data['name'],
      rice: snapshot.data['rice'],
      dish: snapshot.data['dish'],
      sides: snapshot.data['sides'],
    );
  }

  //get orders stream
  Stream<List<Order>> get orders {
    return orderDetails.snapshots().map(_orderListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return orderDetails.document(userID).snapshots().map(_userDataFromSnapshot);
  }
}
