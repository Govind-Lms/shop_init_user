import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String uid;
  String id;
  int totalAmt;
  int totalQty;
  Timestamp? timestamp = Timestamp.now();
  String? approve;
 

  OrderModel({
    required this.uid,
    required this.totalAmt,
    required this.totalQty,
    required this.id,
    this.timestamp,
    this.approve,
  });

  factory OrderModel.fromJson(document){
    final data = document;
    if (data.isEmpty) return OrderModel(id:'',totalAmt: 0,totalQty: 0, uid: '');
    return OrderModel(
      id: data.containsKey('id') ? data['id'] : '',
      totalAmt: data['total'],
      totalQty: data['totalQty'],
      approve: data['approve'],
      timestamp: data['timestamp'],
      uid: data['uid'],

    );
  }
}

