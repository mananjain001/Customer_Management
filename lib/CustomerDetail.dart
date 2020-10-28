import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

const TextStyle ktextStyle =
    TextStyle(fontSize: 26.0, fontWeight: FontWeight.w800);

class CustomerDetail extends StatefulWidget {
  String name, address, mobileno, amount, Customerkey;
  CustomerDetail(
      {this.amount, this.mobileno, this.address, this.name, this.Customerkey});

  @override
  _CustomerDetailState createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  bool editAmount = false, deleteaccount = false, editAccount = false;
  String newAmount, newName, newNumber, newAddress;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Customer Management'),
          backgroundColor: Colors.blue,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(editAmount ? Icons.save : Icons.edit),
          onPressed: () {
            setState(() {
              editAmount = !editAmount;
              if (newAmount == null || newAmount == "") return;
              DatabaseReference ref = FirebaseDatabase.instance.reference();
              ref
                  .child('Customers')
                  .child(widget.Customerkey)
                  .child('amount')
                  .set(newAmount);
              widget.amount = newAmount;
            });
          },
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: editAccount ? 3 : null,
                            child: Text(
                              'Name',
                              style: ktextStyle,
                            ),
                          ),
                          editAccount
                              ? Expanded(
                                  flex: 3,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: widget.name),
                                    onChanged: (newvalue) {
                                      newName = newvalue;
                                    },
                                  ),
                                )
                              : Text(
                                  widget.name,
                                  style: ktextStyle,
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: editAccount ? 3 : null,
                            child: Text(
                              'Phone Number',
                              style: ktextStyle,
                            ),
                          ),
                          editAccount
                              ? Expanded(
                                  flex: 3,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: widget.mobileno,
                                    ),
                                    onChanged: (newvalue) {
                                      newNumber = newvalue;
                                    },
                                  ),
                                )
                              : Text(
                                  widget.mobileno,
                                  style: ktextStyle,
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: editAccount ? 3 : null,
                            child: Text(
                              'Address',
                              style: ktextStyle,
                            ),
                          ),
                          editAccount
                              ? Expanded(
                                  flex: 3,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: widget.address),
                                    onChanged: (newvalue) {
                                      newAddress = newvalue;
                                    },
                                  ),
                                )
                              : Text(
                                  widget.address,
                                  style: ktextStyle,
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: editAmount ? 3 : null,
                            child: Text(
                              'Amount',
                              style: ktextStyle,
                            ),
                          ),
                          editAmount
                              ? Expanded(
                                  flex: 3,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: widget.amount),
                                    onChanged: (newvalue) {
                                      newAmount = newvalue;
                                    },
                                  ),
                                )
                              : Text(
                                  widget.amount,
                                  style: ktextStyle,
                                ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: editAccount ? true : false,
                      child: Text(
                        '*Do not edit the fields which you dont want to change',
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
                Visibility(
                  visible: editAmount ? false : true,
                  child: Column(
                    children: [
                      FlatButton(
                        onPressed: () {
                          if (editAccount) {
                            DatabaseReference ref =
                                FirebaseDatabase.instance.reference();
                            if (!(newName == '' || newName == null)) {
                              ref
                                  .child('Customers')
                                  .child(widget.Customerkey)
                                  .child('name')
                                  .set(newName);
                              widget.name = newName;
                            }
                            if (!(newNumber == '' || newNumber == null)) {
                              ref
                                  .child('Customers')
                                  .child(widget.Customerkey)
                                  .child('mobileno')
                                  .set(newNumber);
                              widget.mobileno = newNumber;
                            }
                            if (!(newAddress == '' || newAddress == null)) {
                              ref
                                  .child('Customers')
                                  .child(widget.Customerkey)
                                  .child('address')
                                  .set(newAddress);
                              widget.address = newAddress;
                            }
                          }
                          setState(() {
                            editAccount = !editAccount;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              color: Colors.blue),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              editAccount ? 'Save Details' : 'Edit Account',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FlatButton(
                        onPressed: () async {
                          await _showMyDialog();
                          if (!deleteaccount) return;
                          setState(() {
                            DatabaseReference ref =
                                FirebaseDatabase.instance.reference();
                            ref
                                .child('Customers')
                                .child(widget.Customerkey)
                                .set(null);
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              color: Colors.blue),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Delete Account',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Customer'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to Delete the Customer Details'),
                Text(
                    'You will not be able to retrive the details once deleted'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Decline'),
              onPressed: () {
                deleteaccount = false;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                deleteaccount = true;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
