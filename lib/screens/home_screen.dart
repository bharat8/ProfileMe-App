import 'package:flutter/material.dart';
import 'package:profile_me/providers/users_provider.dart';
import 'package:profile_me/widgets/app_name.dart';
import 'package:profile_me/widgets/users_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    _controller.addListener(() =>
        Provider.of<UsersProvider>(context, listen: false)
            .scrollControllerListener(_controller, context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final userProvider = Provider.of<UsersProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            controller: _controller,
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                    width: mediaQuery.size.width,
                    height: mediaQuery.size.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppName(),
                        GestureDetector(
                          onTap: () => userProvider.selectFilters(context),
                          child: Container(
                              width: 60,
                              height: 60,
                              padding: EdgeInsets.all(15),
                              child: FittedBox(
                                  child: Icon(Icons.filter_list_rounded))),
                        )
                      ],
                    )),
                Container(
                  width: mediaQuery.size.width,
                  height: mediaQuery.size.height * 0.1,
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "People Around You",
                          style: TextStyle(
                              color: Color(0xff0E3854),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "SF Pro Display"),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                UsersList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
