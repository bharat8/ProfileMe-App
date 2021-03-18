import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: 60,
        height: 60,
        margin: EdgeInsets.only(
            top: 20 + MediaQuery.of(context).padding.top, left: 20),
        decoration: BoxDecoration(
            color: Colors.black38, borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.all(15),
        child: FittedBox(
            child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        )),
      ),
    );
  }
}
