import 'dart:developer';

import 'package:YOURDRS_FlutterAPP/network/services/appointment_service.dart';
import 'package:YOURDRS_FlutterAPP/widget/buttons/dropdowns.dart';
import 'package:flutter/material.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();

  static Location fromJson(decode) {}

  // static Location fromJson(decode) {}
}

class _LocationState extends State<Location> {

  var _currentSelectedValue;

  // final String url = "https://jsonplaceholder.typicode.com/users";

  List data = List(); //edited line

  Services apiServices = Services();


  // Future<String> getSWData() async {
  //   var res = await http
  //       .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  //   var resBody = json.decode(res.body);
  //
  //   setState(() {
  //     data = resBody;
  //   });
  //
  //   print(resBody);
  //
  //   return "Sucess";
  // }

  @override
  void initState() {
    super.initState();
    // this.getSWData();
  }
  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();

    // Location location= await apiServices.getLocation();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 20),
            child: Container(
                height: 55,
                width: 250,
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      isEmpty: _currentSelectedValue == '',
                      child: DropDown(
                        value: _currentSelectedValue,
                        hint: "Dictation",
                        onChanged: (String newValue) {
                          setState(() {
                            _currentSelectedValue = newValue;
                            state.didChange(newValue);

                            print(_currentSelectedValue);
                          });
                        },
                        //Binding data hear
                        items: data.map((item) {
                          return DropdownMenuItem<String>(
                            child: new Text(item['name']),
                            value: item['id'].toString(),
                          );
                        }).toList(),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
