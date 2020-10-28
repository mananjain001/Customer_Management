import 'package:customer_management/HomeScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username, password;
  bool usernameerror = false, passworderror = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Management'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 100.0,
              ),
              Text(
                'Login Page',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              TextField(
                onChanged: (newvalue) {
                  username = newvalue;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Username',
                  icon: Icon(Icons.account_circle),
                  border: OutlineInputBorder(),
                  errorText: usernameerror ? 'Wrong Username' : null,
                ),
              ),
              SizedBox(
                height: 7.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (newvalue) {
                  password = newvalue;
                },
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                  errorText: passworderror ? 'Wrong Password' : null,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Colors.blue),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  if (username == "" ||
                      password == "" ||
                      username == null ||
                      password == null) {
                    setState(() {
                      usernameerror = true;
                    });
                    return;
                  }
                  DatabaseReference _databaseReference =
                      FirebaseDatabase.instance.reference();
                  _databaseReference
                      .child('Users')
                      .once()
                      .then((DataSnapshot snapshot) {
                    if (snapshot != null) {
                      for (var key in snapshot.value.keys) {
                        if (username == key) {
                          if (password == snapshot.value[key]) {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                            setState(() {
                              usernameerror = passworderror = false;
                            });
                            return;
                          }
                          setState(() {
                            passworderror = true;
                            usernameerror = false;
                          });
                          return;
                        }
                        setState(() {
                          usernameerror = true;
                          passworderror = false;
                        });
                        return;
                      }
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
