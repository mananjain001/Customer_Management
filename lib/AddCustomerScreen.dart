import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AddCustomer extends StatelessWidget {
  String _name, _mobilenumber, _address, _amount;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Customer Management'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (newvalue) {
                    _name = newvalue;
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    icon: Icon(Icons.account_circle),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                  onChanged: (newvalue) {
                    _address = newvalue;
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Address',
                    icon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                  onChanged: (newvalue) {
                    _mobilenumber = newvalue;
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Mobile number',
                    icon: Icon(Icons.phone_android),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextField(
                  onChanged: (newvalue) {
                    _amount = newvalue;
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Amount',
                    icon: Icon(Icons.money),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FlatButton(
                  onPressed: () {
                    if (_name == "" ||
                        _amount == "" ||
                        _address == "" ||
                        _name == null ||
                        _amount == null ||
                        _address == null) {
                      _scaffoldKey.currentState.showSnackBar(
                          SnackBar(content: Text('Please enter the details')));
                      return;
                    }
                    try {
                      var key = _databaseReference.child("Customers").push();
                      key.child("name").set(_name).asStream();
                      key.child("address").set(_address).asStream();
                      key.child("mobileno").set(_mobilenumber).asStream();
                      key.child("amount").set(_amount).asStream();
                    } catch (e) {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text('Something went wrong. Retry')));
                      return;
                    }
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
