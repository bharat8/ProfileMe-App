import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class UserListBloc extends ChangeNotifier {
  List<DocumentSnapshot> documentList;

  BehaviorSubject<List<DocumentSnapshot>> userController;

  UserListBloc() {
    userController = BehaviorSubject<List<DocumentSnapshot>>();
  }

  Stream<List<DocumentSnapshot>> get userDataStream => userController.stream;

  void clearStream() {
    userController = BehaviorSubject<List<DocumentSnapshot>>();
  }

/*This method will automatically fetch first 10 elements from the document list */
  Future fetchFirstList() async {
    await Firebase.initializeApp();

    try {
      documentList = (await FirebaseFirestore.instance
              .collection("UserData")
              .limit(10)
              .get())
          .docs;
      userController.sink.add(documentList);
    } on SocketException {
      userController.sink.addError(SocketException("No Internet Connection"));
    } catch (e) {
      print(e.toString());
      userController.sink.addError(e);
    }
  }

/*This will automatically fetch the next 10 elements from the list*/
  fetchNextList() async {
    try {
      List<DocumentSnapshot> newDocumentList = (await FirebaseFirestore.instance
              .collection("UserData")
              .startAfterDocument(documentList[documentList.length - 1])
              .limit(10)
              .get())
          .docs;
      documentList.addAll(newDocumentList);
      userController.sink.add(documentList);
    } on SocketException {
      userController.sink.addError(SocketException("No Internet Connection"));
    } catch (e) {
      print(e.toString());
      userController.sink.addError(e);
    }
  }

  Future fetchQueryList(
      List<String> _fetchedFilters, RangeValues selectedRange) async {
    print(selectedRange);
    try {
      List<DocumentSnapshot> newDocumentList;
      if (_fetchedFilters.length > 0)
        newDocumentList = (await FirebaseFirestore.instance
                .collection("UserData")
                .where('Area of Interests', arrayContainsAny: _fetchedFilters)
                .where('Age', isGreaterThanOrEqualTo: selectedRange.start)
                .where('Age', isLessThanOrEqualTo: selectedRange.end)
                .get())
            .docs;
      else
        newDocumentList = (await FirebaseFirestore.instance
                .collection("UserData")
                .where('Age', isGreaterThanOrEqualTo: selectedRange.start)
                .where('Age', isLessThanOrEqualTo: selectedRange.end)
                .get())
            .docs;
      userController.sink.add(newDocumentList);
    } on SocketException {
      userController.sink.addError(SocketException("No Internet Connection"));
    } catch (e) {
      print(e.toString());
      userController.sink.addError(e);
    }
  }

  @override
  void dispose() {
    userController.close();
    super.dispose();
  }
}
