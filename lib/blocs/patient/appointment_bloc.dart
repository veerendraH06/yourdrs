//TODO: imports

//TODO: List of employees
//TODO: Stream controllers

//TODO: Stream Sink getter

//TODO: Constructor - add data; listen to changes

//TODO: Core functions

//TODO: dispose

import 'dart:async';

import 'package:YOURDRS_FlutterAPP/network/models/appointment.dart';

class EmployeeBloc {
  //sink to add in pipe
  //stream to get data from pipe
  //by pipe i mean data flow

  List<Patient> _employeeList = [];

  final _employeeListStreamController = StreamController<List<Patient>>();

  //for inc and dec
  final _employeeSalaryIncrementStreamController = StreamController<Patient>();
  final _employeeSalaryDecrementStreamController = StreamController<Patient>();

  //getters

  Stream<List<Patient>> get employeeListStream =>
      _employeeListStreamController.stream;
  List<Patient> users;

  StreamSink<List<Patient>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<Patient> get employeeSalaryIncrement =>
      _employeeSalaryIncrementStreamController.sink;

  StreamSink<Patient> get employeeSalaryDecrement =>
      _employeeSalaryDecrementStreamController.sink;

  EmployeeBloc() {
    _employeeListStreamController.add(_employeeList);
  }

  void dispose() {
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeListStreamController.close();
  }
}
