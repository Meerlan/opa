import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/constants.dart';
import 'package:flutter_application_1/models/user_model.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin{
  static const String idScreen = "profile";

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Профиль',
            style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: <Widget>[
            Container(
                height: 150.0,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black,Constants.kAccentColor]
                    )
                ),
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          child: Image.asset(
                            'lib/assets/images/user_icon.png',
                          ),
                          radius: 50.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text("${loggedInUser.fullName}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Brand Bold",
                            )),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                )
            ),
            const SizedBox(
              height: 5.0,
            ),
            Container(
              width: 300.00,
              color: const Color(0xffFFFFFF),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Text(
                                  'Персональная информация',
                                  style: TextStyle(
                                    fontFamily: "ubuntu",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                _status ? _getEditIcon() : Container(),
                              ],
                            )
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 25.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Text(
                                    'Имя пользователя',
                                    style: TextStyle(
                                      fontFamily: "ubuntu",
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.0,
                                )
                                ),
                              ],
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "${loggedInUser.username}",
                                  hintStyle: const TextStyle(
                                    fontFamily: "ubuntu",
                                    fontSize: 11.0,
                                  ),
                                ),
                                enabled: !_status,
                                autofocus: !_status,

                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 25.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Text(
                                  'Полное имя',
                                  style: TextStyle(
                                    fontFamily: "ubuntu",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 2.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "${loggedInUser.fullName}",
                                  hintStyle: const TextStyle(
                                    fontFamily: "ubuntu",
                                    fontSize: 11.0,
                                ),),
                                enabled: !_status,
                                autofocus: !_status,
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 25.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Text(
                                  'Мобильный',
                                  style: TextStyle(
                                    fontFamily: "ubuntu",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 2.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Flexible(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "${loggedInUser.phoneNumber}",
                                  hintStyle: const TextStyle(
                                    fontFamily: "ubuntu",
                                    fontSize: 11.0,
                                  ),
                                ),
                                enabled: !_status,
                              ),
                            ),
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 1.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                          ],
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 2.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                          ],
                        )),
                    !_status ? _getActionButtons() : Container(),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ElevatedButton(
                child: const Text("Сохранить",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    shadowColor: Colors.black,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                // onPressed: () {
                //   setState(() {
                //     _status = true;
                //     FocusScope.of(context).requestFocus(FocusNode());
                //   });
                // },
                onPressed: () {
                  setState(() {
                    _status = true; // Switch back to view mode
                  });

                  // Update the user data in Firestore
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(user!.uid)
                      .update({
                    "username": loggedInUser.username,
                    "fullName": loggedInUser.fullName,
                    "phoneNumber": loggedInUser.phoneNumber,
                  })
                      .then((_) {
                    // Show a message or perform any other action upon successful update
                    print("Данные успешно обновлены");
                  })
                      .catchError((error) {
                    // Handle errors, e.g., display an error message
                    print("Не удалось обновить данные: $error");
                  });
                },


              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ElevatedButton(
                child: const Text("Отмена"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shadowColor: Colors.black,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
              ),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: const CircleAvatar(
        backgroundColor: Constants.kAccentColor,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

}