import 'package:YOURDRS_FlutterAPP/blocs/base/base_bloc_event.dart';
import 'package:flutter/widgets.dart';

abstract class PatientAppointmentBlocEvent extends BaseBlocEvent {}

class GetPatientAppointmentBlocEvent extends PatientAppointmentBlocEvent {
  @override
  List<Object> get props => [];
}

/// SearchPatient Event
class SearchPatientEvent extends PatientAppointmentBlocEvent {
  final String keyword;

  SearchPatientEvent({@required this.keyword});

  @override
  List<Object> get props => [this.keyword];
}

// /// FilterPatient Event
// class FilterPatientEvent extends PatientAppointmentBlocEvent{
//   final String users;
//
//   FilterPatientEvent({@required this.users});
//
//   @override
//   List<Object> get props =>[this.users];
// }


/// on_tap event for list of data in home page
class ClickPatientEvent extends PatientAppointmentBlocEvent {
  final String users;


  ClickPatientEvent({@required this.users});

  @override
  // TODO: implement props
  List<Object> get props => [this.users];
}
