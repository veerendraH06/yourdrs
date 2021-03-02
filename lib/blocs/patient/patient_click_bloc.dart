
import 'package:YOURDRS_FlutterAPP/blocs/base/base_bloc.dart';
import 'package:YOURDRS_FlutterAPP/blocs/patient/patient_bloc_event.dart';
import 'package:YOURDRS_FlutterAPP/blocs/patient/patient_bloc_state.dart';
import 'package:YOURDRS_FlutterAPP/network/models/appointment.dart';
import 'package:YOURDRS_FlutterAPP/network/services/appointment_service.dart';

class Click_PatientsBloc extends BaseBloc<PatientAppointmentBlocEvent,PatientAppointmentBlocState>{

  Click_PatientsBloc(PatientAppointmentBlocState initialState) : super(initialState);

  Stream<PatientAppointmentBlocState> mapEventToState( PatientAppointmentBlocEvent event) async*{

    print("mapEventToState=$event");

    if(event is GetPatientAppointmentBlocEvent){

    }

    if( event is GetPatientAppointmentBlocEvent)
    {
      yield state.copyWith(isLoading: true);
    }
    List<Patient> filteredUsers;

    filteredUsers = await Services.getUsers();

    if(filteredUsers != null || filteredUsers.isEmpty )
    {
      yield state.copyWith(isLoading: false,errorMsg: null, users: filteredUsers);

    }
    else
    {
      yield state.copyWith(isLoading: false,errorMsg: "No such element found");
    }

  }

}