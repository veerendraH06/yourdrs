import 'dart:async';
import 'dart:convert';
import 'package:YOURDRS_FlutterAPP/blocs/patient/patient_bloc.dart';
import 'package:YOURDRS_FlutterAPP/blocs/patient/patient_bloc_event.dart';
import 'package:YOURDRS_FlutterAPP/blocs/patient/patient_bloc_state.dart';

import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/common/app_pop_menu.dart';
import 'package:YOURDRS_FlutterAPP/network/models/appointment.dart';


import 'package:YOURDRS_FlutterAPP/ui/home/patient_details.dart';
import 'package:YOURDRS_FlutterAPP/widget/dropdowns/dictation.dart';

import 'package:YOURDRS_FlutterAPP/widget/dropdowns/provider.dart';
import 'package:YOURDRS_FlutterAPP/widget/input_fields/search_bar.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePortrait extends StatefulWidget {
  @override
  _HomePortraitState createState() => _HomePortraitState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _HomePortraitState extends State<HomePortrait> {
  final _debouncer = Debouncer(milliseconds: 500);
  List<dynamic> allData = [];
  List<dynamic> appointmentData = [];
  Map<String, dynamic> appointment;

//API json related code
  List<Patient> users = List();
  List<Patient> filteredUsers = List();
  // bool isSearching = false;

  @override
  void initState() {
    super.initState();
    // this.getjsondata();
    // Services.getUsers().then((usersFromServer) {
    //   setState(() {
    //     users = usersFromServer;
    //     filteredUsers = users;
    //   });
    // });
    BlocProvider.of<PatientBloc>(context).add(GetPatientAppointmentBlocEvent());
  }

  // ignore: missing_return
  Future<String> getjsondata() async {
    String jsonData = await DefaultAssetBundle.of(context)
        .loadString("assets/json/appointment.json");
    final jsonResult = json.decode(jsonData);
    // print(jsonResult)
    allData = jsonResult;
    appointmentData = allData;
    setState(() {});
  }

//filter method  for selected date
  getSelectedDateAppointments() {
    appointmentData = allData.where((element) {
      print(element);
      Map<String, dynamic> appItem = element;
      return appItem['appointmentDate'] == _selectedValue.toString();
    }).toList();
    setState(() {});
  }

//Date Picker Controller related code
  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: CustomizedColors.primaryColor,
        title: ListTile(
          leading: CircleAvatar(
            radius: 18,
            child: ClipOval(
              child: Image.network(
                  "https://image.freepik.com/free-vector/doctor-icon-avatar-white_136162-58.jpg"),
            ),
          ),
          title: Row(
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                  color: CustomizedColors.textColor,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Dr.sciliaris",
                style: TextStyle(
                    color: CustomizedColors.textColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: FlatButton(
            minWidth: 2,
            padding: EdgeInsets.only(right: 0),
            child: Icon(
              Icons.segment,
              color: CustomizedColors.iconColor,
            ),
            onPressed: () {
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(
                    "Select a filter",
                    style: TextStyle(),
                  ),
                  actions: <Widget>[
                    Provider(),
                    Dictation(),
                    // Location(),
                    FlatButton(
                      onPressed: () => Navigator.pop(context),
                      // onPressed: ()
                      // {
                      //
                      //   // Navigator.push(ctx, MaterialPageRoute(builder: (ctx)=> Login_Screen() ),);
                      // },
                      child: Text('Ok'),
                    ),
                  ],
                ),
              );
//
            },
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //color: Colors.black,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.10,
              color: CustomizedColors.primaryColor,
            ),
            Positioned(
              top: 45,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Column(
                  children: <Widget>[
                    PatientSerach(
                      width: 250,
                      height: 60,
                      onChanged: (string) {
                        // isSearching = true;
                        _debouncer.run(() {
                          // setState(() {
                          //   filteredUsers = users
                          //       .where((u) => (u.name
                          //               .toLowerCase()
                          //               .contains(string.toLowerCase()) ||
                          //           u.email
                          //               .toLowerCase()
                          //               .contains(string.toLowerCase())))
                          //
                          // });
                          BlocProvider.of<PatientBloc>(context)
                              .add(SearchPatientEvent(keyword: string));
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.grey[100],
                      child: DatePicker(
                        DateTime.now().subtract(Duration(days: 3)),
                        width: 45.0,
                        height: 80,
                        controller: _controller,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: CustomizedColors.primaryColor,
                        selectedTextColor: CustomizedColors.textColor,
                        dayTextStyle: TextStyle(fontSize: 10.0),
                        dateTextStyle: TextStyle(fontSize: 14.0),
                        // inactiveDates: [
                        //   DateTime.now().add(Duration(days: 3)),
                        //   DateTime.now().add(Duration(days: 4)),
                        // ],
                        onDateChange: (date) {
                          // New date selected

                          setState(() {
                            _selectedValue = date;
                            getSelectedDateAppointments();
                          });
                          print(_selectedValue);
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),

            // BlocListener<Click_PatientsBloc,PatientAppointmentBlocState>(listener: (context,state){
            //
            //   // ignore: unrelated_type_equality_checks
            //   if(state.filteredUsers == filteredUsers)
            //     {
            //       Navigator.push(context, MaterialPageRoute(builder: (context) => PatientDetail()));
            //     }
            //   else
            //     {
            //
            //     }
            // },
            //   // child:
              Container(
                child: Stack(
                  children: <Widget>[
                    SafeArea(
                      bottom: false,
                      child: Stack(
                        children: <Widget>[
                          DraggableScrollableSheet(
                            maxChildSize: .7,
                            initialChildSize: .7,
                            minChildSize: .6,
                            builder: (context, scrollController) {
                              return Container(
                                height: 100,
                                padding: EdgeInsets.only(
                                    left: 19,
                                    right: 19,
                                    top:
                                        16), //symmetric(horizontal: 19, vertical: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                  color: CustomizedColors.textColor,
                                ),
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  controller: scrollController,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "HEMA 54-DEAN (4)",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            )
                                          ],
                                        ),
                                        BlocBuilder<PatientBloc,
                                                PatientAppointmentBlocState>(
                                            builder: (context, state) {
                                          print('BlocBuilder state $state');
                                          if (state.isLoading) {
                                            return CircularProgressIndicator();
                                          }

                                          if (state.errorMsg != null &&
                                              state.errorMsg.isNotEmpty) {
                                            return Text(state.errorMsg);
                                          }

                                          if (state.users == null ||
                                              state.users.isEmpty) {
                                            return Text(
                                              "No patients found",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: CustomizedColors.noAppointment),
                                            );
                                          }

                                          // if (!isSearching) {
                                          users = state.users;
                                          // }

                                          if (state.keyword != null &&
                                              state.keyword.isNotEmpty) {
                                            filteredUsers = users
                                                .where((u) => (u.name
                                                        .toLowerCase()
                                                        .contains(state.keyword
                                                            .toLowerCase()) ||
                                                    u.email.toLowerCase().contains(
                                                        state.keyword
                                                            .toLowerCase())))
                                                .toList();
                                          } else {
                                            filteredUsers = users;
                                          }

                                          return filteredUsers != null &&
                                                  filteredUsers.isNotEmpty
                                              ? ListView.separated(
                                                  separatorBuilder:
                                                      (context, index) => Divider(
                                                    color: CustomizedColors.title,
                                                  ),
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: filteredUsers.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Hero(
                                                      tag: filteredUsers[index],
                                                      child: Material(
                                                        child: ListTile(
                                                          contentPadding:
                                                              EdgeInsets.all(0),
                                                          leading: Icon(
                                                            Icons.bookmark,
                                                            color: Colors.green,
                                                          ),

                                                          onTap: () {

                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    PatientDetail(),
                                                                // Pass the arguments as part of the RouteSettings. The
                                                                // DetailScreen reads the arguments from these settings.
                                                                settings:
                                                                    RouteSettings(
                                                                  arguments:
                                                                      filteredUsers[
                                                                          index],
                                                                ),
                                                              ),
                                                            );

                                                          },
                                                          title: Text(
                                                              filteredUsers[index]
                                                                  .name),
                                                          subtitle: Text(
                                                              filteredUsers[index]
                                                                  .email
                                                                  .toLowerCase()),
                                                          trailing: Column(
                                                            children: [
                                                              Spacer(),
                                                              RichText(
                                                                text: TextSpan(
                                                                  text: '• ',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize: 14),
                                                                  children: <
                                                                      TextSpan>[
                                                                    // TextSpan(
                                                                    //   text: 'Dictation' +

                                                                    // ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container(
                                                  //   child: Text(
                                                  //   "No Results Found",
                                                  //   style: TextStyle(
                                                  //       fontSize: 18.0,
                                                  //       fontWeight: FontWeight.bold,
                                                  //       color: CustomizedColors
                                                  //           .noAppointment),
                                                  // )
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.fromLTRB(
                                                                  50, 25, 50, 45)),
                                                      Text(
                                                        "No results found for related search",
                                                        style: TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: CustomizedColors
                                                                .noAppointment),
                                                      )
                                                    ],
                                                  ),
                                                );
                                        }),
                                      ],
                                    ),
                                  ),
                                );
                              // );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            // ),

            Container(
              padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                    backgroundColor: CustomizedColors.primaryColor,
                    onPressed: () {},
                    tooltip: 'Increment',
                    child: Pop(
                      initialValue: 1,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute(Patient patient) {
    return PageRouteBuilder(
      settings: RouteSettings(
        arguments: patient,
      ),
      pageBuilder: (context, animation, secondaryAnimation) => PatientDetail(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
