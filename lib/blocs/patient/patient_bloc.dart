import 'dart:async';

import 'package:YOURDRS_FlutterAPP/blocs/base/base_bloc.dart';
import 'package:YOURDRS_FlutterAPP/blocs/patient/patient_bloc_event.dart';
import 'package:YOURDRS_FlutterAPP/blocs/patient/patient_bloc_state.dart';
import 'package:YOURDRS_FlutterAPP/network/models/appointment.dart';
import 'package:YOURDRS_FlutterAPP/network/services/appointment_service.dart';

class PatientBloc
    extends BaseBloc<PatientAppointmentBlocEvent, PatientAppointmentBlocState> {
  PatientBloc() : super(PatientAppointmentBlocState.initial());

  @override
  Stream<PatientAppointmentBlocState> mapEventToState(
      PatientAppointmentBlocEvent event) async* {
    print("mapEventToState=$event");

    if (event is GetPatientAppointmentBlocEvent) {
      yield state.copyWith(
        isLoading: true,
      );

      List<Patient> users;
      users = await Services.getUsers();

      if (users == null || users.isEmpty) {
        yield state.copyWith(
            isLoading: false, errorMsg: 'No patients available', users: users);
      } else {
        yield state.copyWith(isLoading: false, errorMsg: null, users: users);
      }
    }

    if (event is SearchPatientEvent) {
      yield state.copyWith(keyword: event.keyword);
    }
  }
}
