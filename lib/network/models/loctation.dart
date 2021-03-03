import 'dart:convert';

Location LocationFromJson(String str) => Location.fromJson(json.decode(str));

String LoctionToJson(Location data) => json.encode(data.toJson());

class Location {
 
  Header header;
  List<LocationList> locationList;

  Location({this.header, this.locationList});

  Location.fromJson(Map<String, dynamic> json) {
    header =
    json['header'] != null ? new Header.fromJson(json['header']) : null;
    if (json['locationList'] != null) {
      locationList = new List<LocationList>();
      json['locationList'].forEach((v) {
        locationList.add(new LocationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    if (this.locationList != null) {
      data['locationList'] = this.locationList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Header {
  String status;
  String statusCode;
  String statusMessage;

  Header({this.status, this.statusCode, this.statusMessage});

  Header.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['statusMessage'] = this.statusMessage;
    return data;
  }
}

class LocationList {
  int locationId;
  String locationName;
  int memberId;

  LocationList({this.locationId, this.locationName, this.memberId});

  LocationList.fromJson(Map<String, dynamic> json) {
    locationId = json['locationId'];
    locationName = json['locationName'];
    memberId = json['memberId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationId'] = this.locationId;
    data['locationName'] = this.locationName;
    data['memberId'] = this.memberId;
    return data;
  }
}