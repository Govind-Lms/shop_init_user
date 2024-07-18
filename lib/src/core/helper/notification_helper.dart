// import '../../const/constant.dart';

// class NotificationHelper{
//   Stream<List<OrderModel>> getOrderList() {
//     return orderRef.snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) {
//         Map<String, dynamic> data = doc.data();
//         return OrderModel(
//           totalAmt: data['totalAmt'],
//           totalQty: data['totalQty'],
//           id: data['id'],
//           // cartLists: data['cartLists'],
//           timestamp: data['timestamp'], uid: data['uid'],
//         );
//       }).toList();
//     });
//   }

//   Future<void> addOrderList(OrderModel orderModel) {
//     return orderRef.doc(firebaseAuth.currentUser?.uid).collection("orders").doc(orderModel.id).set({
//       // 'cartLists': orderModel.cartLists ,
//       'uid': firebaseAuth.currentUser?.uid,
//       'id': orderModel.id,
//       'timestamp': orderModel.timestamp ?? '',
//       'total' : orderModel.totalAmt,
//       'totalQty' : orderModel.totalQty,
//       'approve': orderModel.approve,
      
//     }).onError((error, stackTrace) => print("Errror in upload :::::$error $stackTrace"),);
//   }

//   Future<void> deleteOrder(OrderModel orderModel) {
//     return orderRef.doc(firebaseAuth.currentUser?.uid).delete();
//   }
// }