import 'dart:convert';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/network/models/appointment.dart';
import 'package:YOURDRS_FlutterAPP/network/models/loctation.dart';
import 'package:http/http.dart' as http;

class Services {

  static const String url = 'https://jsonplaceholder.typicode.com/users';

  static Future<List<Patient>> getUsers() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Patient> list = parseUsers(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Patient> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Patient>((json) => Patient.fromJson(json)).toList();
  }



  // Future<String> getSWData() async {
  //   var res = await http
  //       .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  //   var resBody = json.decode(res.body);
  //
  //   print(resBody);
  //
  //   return "Sucess";
  // }

  Future<Location> getLocation() async{
    try{
      var endPointUrl =ApiUrlConstants.getLocation;
      Map<String ,String> queryparms={
        "MemberId":'1',
      };
      String queryString =Uri(queryParameters: queryparms).query;
      final requestUrl =endPointUrl + '?'+ queryString;
      final response =await http.get(Uri.encodeFull(requestUrl),
          headers:{"Accept":"appliction/json"});

      if(response.statusCode == 200)
        {
          Location location = parseLoction(response.body);

          return location;
        }
      else{
            throw Exception("Error msg");
      }


    }
    catch (e)
    {
      throw Exception(e);
    }

  }

  Location parseLoction(String responseBody) {
    final Location location = Location.fromJson(json.decode(responseBody));
    return location;
  }

}
