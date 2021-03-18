import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:profile_me/widgets/back_button.dart';
import 'package:profile_me/widgets/user_details.dart';
import 'package:profile_me/widgets/users_area_of_interest.dart';

class DetailsScreen extends StatelessWidget {
  final String name;
  final String imageUrl;
  final int age;
  final String height;
  final List areaOfInterests;
  final String location;
  final String heroTag;

  DetailsScreen(
      {this.age,
      this.areaOfInterests,
      this.height,
      this.imageUrl,
      this.name,
      this.heroTag,
      this.location});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Hero(
                  tag: heroTag,
                  child: Container(
                    width: mediaQuery.size.width,
                    height:
                        mediaQuery.size.height * 0.65 - mediaQuery.padding.top,
                    // color: Colors.black12,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(60),
                      ),
                      child: InteractiveViewer(
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => SpinKitThreeBounce(
                            color: Colors.blue[300],
                            size: 15,
                          ),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.height * 0.15,
                  padding: EdgeInsets.all(20),
                  // color: Colors.black12,
                  alignment: Alignment.centerLeft,
                  child: UserDetails(
                    age: age,
                    height: height,
                    imageUrl: imageUrl,
                    location: location,
                    name: name,
                  ),
                ),
                UsersAreaOfInterests(areaOfInterests)
              ],
            ),
            BackButtonWidget()
          ],
        ),
      ),
    );
  }
}
