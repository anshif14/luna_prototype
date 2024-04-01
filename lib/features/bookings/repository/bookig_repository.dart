import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/core/providers/firebase_provider.dart';
import 'package:luna_demo/model/booking_model.dart';
import 'package:luna_demo/model/product_Model.dart';
final bookingRepositoryProvider=Provider((ref)=>BookingRepository(firestore:ref.watch(firestoreProvider)));

class BookingRepository{
  final FirebaseFirestore _firestore;
  BookingRepository({required FirebaseFirestore firestore}):_firestore=firestore;

  CollectionReference get _booking=> _firestore.collection("bookings");
  CollectionReference get _product=> _firestore.collection("product");
  addBooking(BookingModel bookingdata){
    _booking.add(bookingdata.toMap()).then((value) {
      value.update(bookingdata.copyWith(buyerId: value.id).toMap());
    },);
  }
  // singleProductStream(productid){
  //   _product.doc(productid).snapshots().map((event) {
  //     return ProductModel.fromMap(event.data() as Map<String,dynamic>);
  //   });
  // }

}