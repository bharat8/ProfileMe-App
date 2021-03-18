import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile_me/providers/user_bloc.dart';
import 'package:provider/provider.dart';

class UsersProvider extends ChangeNotifier {
  List<String> areaOfInterests = [
    "Photography",
    "Bollywood",
    "Sports",
    "House Parties",
    "Dog Lover",
    "Soccer",
    "Walking",
    "Vlogging",
    "Language Exchange",
    "Road Trips",
    "Fishing",
    "Activism",
    "Politics",
    "Hip Hop",
    "Ludo",
    "Instagram",
    "Stand Up Comedy",
    "Sushi",
    "Spirtuality",
    "Cycling",
    "Environmentalist",
    "Trivia",
    "Cat Lover",
    "Music",
    "K-Pop",
    "Working-out",
    "Poetry",
    "Museum",
    "Shopping",
    "Baking",
    "Reading",
    "Climbing",
    "Movies",
    "Running",
    "New in Town",
    "Travel",
    "Tea",
    "Gardening",
    "Vegan",
    "Comedy",
    "Slam Poetry",
    "Picnicking",
    "Cooking",
    "Cricket",
    "90s Kids",
    "Disney",
    "Athelete",
    "Biryani",
    "Foodie",
    "Yoga",
    "Art",
    "Golf",
    "Grab a drink",
    "Surfing",
    "Netflix",
    "Voulenteering",
    "Craft Bear",
    "Karakoe",
    "Swimming",
    "VR Room",
    "Sneakers",
    "Potterhead",
    "DIY",
    "Astrology",
    "Coffee",
    "Musician",
    "Hiking",
    "Maggi",
    "Board Games",
    "Brunch",
    "Writer",
    "Outdoors",
    "Bhangra",
    "Dancing",
    "Wine",
    "Festivals",
    "Blogging",
    "Gamer",
    "Vegeterian",
    "Fashion"
  ];

  List<String> _filters = [];

  List<String> get filters => _filters;

  RangeValues _ageRange = RangeValues(18, 50);

  RangeValues get ageRange => _ageRange;

  selectFilters(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Select all filters you want",
            style: TextStyle(fontFamily: "SF Pro Display"),
          ),
          actionsPadding: EdgeInsets.zero,
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.28,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Text(
                  "Age :",
                  style: TextStyle(fontFamily: "SF Pro Display"),
                ),
                RangeSlider(
                  onChanged: (RangeValues newRange) {
                    Provider.of<UsersProvider>(context, listen: false)
                        ._ageRange = newRange;
                    notifyListeners();
                  },
                  values: _ageRange,
                  divisions: 6,
                  labels: RangeLabels(_ageRange.start.toInt().toString(),
                      _ageRange.end.toInt().toString()),
                  min: 18,
                  max: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Interests :",
                    style: TextStyle(fontFamily: "SF Pro Display"),
                  ),
                ),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: areaOfInterests
                      .map((e) => buildChip(e, context))
                      .toList(),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () => reactToFilters(context),
                child: Text("Continue"))
          ],
        );
      },
    );
  }

  Widget buildChip(String interest, BuildContext context) {
    return FilterChip(
      padding: EdgeInsets.all(2),
      label: Text(
        interest,
        style: TextStyle(color: Colors.black),
      ),
      selectedShadowColor: Colors.transparent,
      selectedColor: Colors.transparent,
      checkmarkColor: Colors.blueAccent,
      shape: StadiumBorder(
          side: BorderSide(
              width: 1.5,
              color: _filters.contains(interest)
                  ? Colors.blueAccent
                  : Colors.black54)),
      backgroundColor: Colors.transparent,
      selected: Provider.of<UsersProvider>(context)._filters.contains(interest),
      onSelected: (bool selected) {
        if (selected) {
          _filters.add(interest);
        } else {
          _filters.removeWhere((element) => element == interest);
        }
        notifyListeners();
      },
    );
  }

  void reactToFilters(BuildContext context) {
    Provider.of<UserListBloc>(context, listen: false).clearStream();
    _filters.length > 0 || (_ageRange.start > 18 || _ageRange.end < 50)
        ? Provider.of<UserListBloc>(context, listen: false)
            .fetchQueryList(_filters, _ageRange)
        : Provider.of<UserListBloc>(context, listen: false).fetchFirstList();
    notifyListeners();
    Navigator.of(context).pop();
  }

  void scrollControllerListener(
      ScrollController _controller, BuildContext context) {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange &&
        _filters.length == 0 &&
        (_ageRange.start > 18 || _ageRange.start < 50)) {
      Provider.of<UserListBloc>(context, listen: false).fetchNextList();
    }
  }
}
