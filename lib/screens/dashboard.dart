import 'package:example_app/models/user.dart';
import 'package:example_app/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  Widget detailWidget(IconData icon, String detail) => Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(children: [
        SizedBox(width: 30.0),
        Icon(icon),
        SizedBox(width: 20.0),
        Text(detail)
      ]));

  Widget profileWidget(User user) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              ColumnSuper(children: [
                Image.network(user.firmImage),
                Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(user.profileImage),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(50.0)),
                        border: new Border.all(
                          color: Colors.white,
                          width: 4.0,
                        )))
              ], innerDistance: -50.0),
              SizedBox(height: 30.0),
              detailWidget(Icons.person, user.name),
              detailWidget(Icons.call, user.mobile),
              detailWidget(Icons.business, user.firmName),
              detailWidget(Icons.place, user.address),
              detailWidget(Icons.av_timer, user.expiryDate),
              detailWidget(Icons.schedule, user.email)
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return profileWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }
}
