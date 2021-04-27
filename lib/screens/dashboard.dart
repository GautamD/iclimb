import 'package:example_app/models/user.dart';
import 'package:example_app/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  User _user;
  FToast fToast;
  TextEditingController mobileNoFieldController;

  @override
  void initState() {
    super.initState();
    fetchUser()
        .then((user) => setState(() => _user = user))
        .catchError((err) => showToast(err.toString()));
    mobileNoFieldController = new TextEditingController();
    fToast = FToast();
    fToast.init(context);
  }

  void updateUserMobile(String mobileNo) {
    fetchUserWithMobile(mobileNo)
        .then((user) => setState(() => _user = user))
        .catchError((err) => showToast(err.toString()));
  }

  void showToast(String message) {
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.greenAccent,
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.check),
          SizedBox(width: 12.0),
          Text(message),
        ]));

    fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 2));
  }

  Widget detailWidget(IconData icon, String detail) => Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(children: [
        SizedBox(width: 30.0),
        Icon(icon),
        SizedBox(width: 20.0),
        Text(detail)
      ]));

  Widget mobileWidget() => Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(children: [
        SizedBox(width: 30.0),
        Icon(Icons.call),
        SizedBox(width: 20.0),
        Expanded(
            child: TextField(
                controller: mobileNoFieldController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Mobile No'))),
        SizedBox(width: 20.0),
        ElevatedButton(
            onPressed: () => updateUserMobile(mobileNoFieldController.text),
            child: Text('Update'))
      ]));

  Widget profileWidget() {
    if (_user == null) {
      return Center(child: CircularProgressIndicator());
    }
    mobileNoFieldController.text = _user.mobile;
    return SingleChildScrollView(
      child: Column(children: [
        ColumnSuper(children: [
          Image.network(_user.firmImage),
          Container(
              width: 100.0,
              height: 100.0,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new NetworkImage(_user.profileImage),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                  border: new Border.all(
                    color: Colors.white,
                    width: 4.0,
                  )))
        ], innerDistance: -50.0),
        SizedBox(height: 30.0),
        detailWidget(Icons.person, _user.name),
        mobileWidget(),
        detailWidget(Icons.business, _user.firmName),
        detailWidget(Icons.place, _user.address),
        detailWidget(Icons.av_timer, _user.expiryDate),
        detailWidget(Icons.schedule, _user.email)
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: profileWidget(),
      ),
    );
  }
}
