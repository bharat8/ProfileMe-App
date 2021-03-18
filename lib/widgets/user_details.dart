import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  final String name;
  final String imageUrl;
  final int age;
  final String height;
  final String location;
  const UserDetails({
    this.name,
    this.imageUrl,
    this.age,
    this.height,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "SF Pro Display",
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            Spacer(),
            Text(
              age.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "SF Pro Display",
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(left: 5),
                padding: EdgeInsets.all(2),
                child: FittedBox(
                  child: Image.asset(
                    "assets/images/age.png",
                    fit: BoxFit.contain,
                  ),
                ))
          ],
        ),
        Row(
          children: [
            Text(
              location,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                  fontFamily: "SF Pro Display",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              height,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "SF Pro Display",
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(left: 5),
                padding: EdgeInsets.all(4),
                child: FittedBox(
                  child: Image.asset(
                    "assets/images/height.png",
                    fit: BoxFit.contain,
                  ),
                ))
          ],
        )
      ],
    );
  }
}
