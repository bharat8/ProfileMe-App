import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:profile_me/providers/user_bloc.dart';
import 'package:profile_me/widgets/user_tile.dart';
import 'package:provider/provider.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  void didChangeDependencies() {
    Provider.of<UserListBloc>(context).fetchFirstList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<UserListBloc>(context);
    return StreamBuilder<List<DocumentSnapshot>>(
        stream: imageProvider.userDataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snapshot.hasData == false) {
            return Center(
              child: Text("No data available"),
            );
          }
          return StaggeredGridView.countBuilder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) =>
                UserTile(index: index, snap: snapshot.data),
            staggeredTileBuilder: (int index) =>
                StaggeredTile.count(2, index.isEven ? 3 : 2),
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          );
        });
  }
}
