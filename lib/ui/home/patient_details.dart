import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/network/models/appointment.dart';
import 'package:flutter/material.dart';

class PatientDetail extends StatefulWidget {
  @override
  // final List<Patient> todos;

  // PatientDetail({Key key, @required this.todos}) : super(key: key);
  _PatientDetailState createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {

  // Map arguments = Map();
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   arguments = ModalRoute.of(context).settings.arguments;
  // }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final Patient item = ModalRoute.of(context).settings.arguments;
    print(item);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "back",
          style: TextStyle(color: CustomizedColors.textColor, fontSize: 14.0),
        ),
        backgroundColor: CustomizedColors.primaryColor,
        elevation: 0.2,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          CustomizedColors.primaryColor,
          CustomizedColors.primaryColor,
          CustomizedColors.primaryColor
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // SizedBox(
            //   height: 80,
            // ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: Hero(
                        transitionOnUserGestures: true,
                        tag: item,
                        child: Transform.scale(
                          scale: 2.0,
                          child: CircleAvatar(
                            radius: 18,
                            child: ClipOval(
                              child: Image.network(
                                  "https://image.freepik.com/free-vector/doctor-icon-avatar-white_136162-58.jpg"),
                            ),
                          ),
                        )),
                    trailing:
                        Icon(Icons.mic, color: CustomizedColors.iconColor),
                    title: Row(
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Text(
                             item.email,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Text(
                              item.id.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(right: 10)),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            item.name,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            item.email,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(
                           item.id.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row()
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
