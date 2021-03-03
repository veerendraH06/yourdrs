import 'package:YOURDRS_FlutterAPP/common/app_constants.dart';

class AppStrings {
  static const welcome = 'Welcome';
  static const signIn = "Signin";
  static const tryAgain = "tryAgain";
  static const notNow = "notNow";
}

class ApiUrlConstants{

  /// for getting locations through Api
  static const getLocation =AppConstants.dioBaseUrl + "api/Schedule/GetMemberLocations";

  ///  for getting Provider through Api
  static const getProvider = AppConstants.dioBaseUrl+ "api/Schedule/GetAssociatedProvider";

  /// for getting Schedulers data
  static const getSchedules = AppConstants.dioBaseUrl + "api/Schedule/GetSchedules";
}