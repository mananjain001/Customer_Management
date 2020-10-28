import 'package:customer_management/CustomerDetail.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const TextStyle ktextStyle =
    TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400);

class SearchCustomer extends StatefulWidget {
  @override
  _SearchCustomerState createState() => _SearchCustomerState();
}

class _SearchCustomerState extends State<SearchCustomer> {
  TextEditingController _controller = new TextEditingController();
  String _search, _currentSelection = "name";
  int _radiosearch = 0;
  List<Widget> _searchResult = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_search != null) {
              _searchResult = await createResult();
            }
            setState(() {});
          },
          child: Icon(Icons.refresh),
        ),
        appBar: AppBar(
          title: Text('Customer Management'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Search By:',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                  value: 0,
                                  groupValue: _radiosearch,
                                  activeColor: Colors.black,
                                  onChanged: (value) {
                                    setState(() {
                                      _handlesearchradio(value);
                                    });
                                  }),
                              Text('Name'),
                              SizedBox(
                                width: 12.0,
                              ),
                              Radio(
                                  value: 1,
                                  groupValue: _radiosearch,
                                  activeColor: Colors.black,
                                  onChanged: (value) {
                                    setState(() {
                                      _handlesearchradio(value);
                                    });
                                  }),
                              Text('Contact No.'),
                              SizedBox(
                                width: 12.0,
                              ),
                              Radio(
                                  value: 2,
                                  groupValue: _radiosearch,
                                  activeColor: Colors.black,
                                  onChanged: (value) {
                                    setState(() {
                                      _handlesearchradio(value);
                                    });
                                  }),
                              Text('Address'),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 12.0, left: 12.0, right: 12.0),
                child: TextField(
                  onChanged: (newvalue) {
                    _search = newvalue;
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Type Here',
                    icon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () async {
                  _searchResult = await createResult();
                  setState(() {
                    if (_search != null) {
                      FocusScope.of(context).unfocus();
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Search',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: _searchResult,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handlesearchradio(int value) {
    _radiosearch = value;
    _currentSelection = value == 0
        ? "name"
        : value == 1
            ? "mobileno"
            : "address";
  }

  createResult() async {
    RegExp regExp = RegExp(
      "/*$_search/*",
      caseSensitive: false,
    );
    List<Widget> searchResult = [];
    DatabaseReference _databaseReference =
        await FirebaseDatabase.instance.reference();
    await _databaseReference
        .child('Customers')
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot != null) {
        for (var key in snapshot.value.keys) {
          if (regExp.hasMatch(snapshot.value[key][_currentSelection])) {
            searchResult.add(addElement(
                name: snapshot.value[key]["name"],
                amount: snapshot.value[key]["amount"],
                mobileno: snapshot.value[key]["mobileno"],
                address: snapshot.value[key]["address"],
                key: key));
          }
        }
      }
    });
    return searchResult;
  }

  Widget addElement({String name, address, mobileno, amount, key}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerDetail(
                address: address,
                mobileno: mobileno,
                amount: amount,
                name: name,
                Customerkey: key,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: ktextStyle,
                  ),
                  Text(
                    amount,
                    style: ktextStyle,
                  )
                ],
              ),
              Text(
                mobileno,
                style: ktextStyle,
              ),
              Text(
                address,
                style: ktextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
