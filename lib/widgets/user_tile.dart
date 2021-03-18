import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:profile_me/screens/details_screen.dart';

class UserTile extends StatelessWidget {
  final int index;
  final List<DocumentSnapshot> snap;

  const UserTile({this.index, this.snap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DetailsScreen(
                      age: snap[index]["Age"],
                      areaOfInterests: snap[index]["Area of Interests"],
                      height: snap[index]["Height"],
                      heroTag: "UserImageWithIndex$index",
                      imageUrl: snap[index]["Image"],
                      name: snap[index]["Name"],
                      location: snap[index]["Location"],
                    ))),
            child: Hero(
              tag: "UserImageWithIndex$index",
              child: Container(
                color: Colors.black12,
                child: CachedNetworkImage(
                  imageUrl: snap[index].data()["Image"],
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => SpinKitThreeBounce(
                    color: Colors.blue[300],
                    size: 15,
                  ),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            )));
  }
}
