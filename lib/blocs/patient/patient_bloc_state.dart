import 'package:YOURDRS_FlutterAPP/blocs/base/base_bloc_state.dart';
import 'package:YOURDRS_FlutterAPP/network/models/appointment.dart';


class PatientAppointmentBlocState extends BaseBlocState {
  final bool isLoading;
  final String errorMsg;
  final List<Patient> users;
  final String keyword;
  final String filteredUsers;


  factory PatientAppointmentBlocState.initial() => PatientAppointmentBlocState(
        errorMsg: null,
        isLoading: false,
        users: null,
      );

  PatientAppointmentBlocState reset() => PatientAppointmentBlocState.initial();

  PatientAppointmentBlocState({
    this.isLoading = false,
    this.errorMsg,
    this.users,
    this.keyword,
    this.filteredUsers,

  });

  @override
  List<Object> get props => [
        this.isLoading,
        this.errorMsg,
        this.users,
        this.keyword,
      ];

  PatientAppointmentBlocState copyWith({
    bool isLoading,
    String errorMsg,
    List<Patient> users,
    String keyword,
  }) {
    return new PatientAppointmentBlocState(
      isLoading: isLoading ?? this.isLoading,
      errorMsg: errorMsg ?? this.errorMsg,
      users: users ?? this.users,
      keyword: keyword ?? this.keyword,
    );
  }

  @override
  String toString() {
    return 'PatientAppointmentMainState{isLoading: $isLoading, errorMsg: $errorMsg, users: $users, keyword: $keyword}';
  }
}
