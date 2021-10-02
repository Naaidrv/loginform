import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginform/model/model.dart';
import 'package:loginform/screens/login.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("¡Bienvenido!"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  height: 300,
                  child: Image.asset(
                    "assets/logow.png",
                    fit: BoxFit.contain,
                  )),
              Text(
                "Que gusto verte de nuevo!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Hola, ${loggedInUser.fisrtname} ${loggedInUser.secondname} 😄",
                style: TextStyle(
                    color: Color(0xFF104599C),
                    fontWeight: FontWeight.w500,
                    fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                "${loggedInUser.email}",
                style: TextStyle(
                    color: Color(0xFF104599C), fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 35),
              ActionChip(
                  elevation: 5,
                  backgroundColor: Color(0xFF104599C),
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                  label: Text(
                    "Cerrar sesión",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    logout(context);
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
