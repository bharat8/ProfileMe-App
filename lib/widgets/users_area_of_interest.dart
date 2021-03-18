import 'package:flutter/material.dart';
import 'package:profile_me/providers/users_provider.dart';
import 'package:provider/provider.dart';

class UsersAreaOfInterests extends StatefulWidget {
  final List interests;
  UsersAreaOfInterests(this.interests);
  @override
  _UsersAreaOfInterestsState createState() => _UsersAreaOfInterestsState();
}

class _UsersAreaOfInterestsState extends State<UsersAreaOfInterests> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        children: widget.interests.map((e) => _buildChip(e)).toList(),
      ),
    );
  }

  Widget _buildChip(String interest) {
    return Consumer<UsersProvider>(builder: (context, value, child) {
      return Chip(
          padding: EdgeInsets.all(2),
          label: Text(
            interest,
            style: TextStyle(color: Colors.black),
          ),
          shape: StadiumBorder(
              side: BorderSide(
                  width: 1.5,
                  color: value.filters.contains(interest)
                      ? Colors.blueAccent
                      : Colors.black54)),
          backgroundColor: Colors.transparent);
    });
  }
}
