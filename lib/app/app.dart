import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mychat/app/router/route_name.dart';
import 'package:mychat/app/router/router.dart';
import 'package:mychat/app/utils/color_util.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _initSystemChrome();
    return MaterialApp(
      title: "My Chat",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primaryColor: Colors.blue,
        cursorColor: Colors.black,
        fontFamily: "Roboto",
      ),
      onGenerateRoute: Router.generateRoute,
      initialRoute: RouteName.auth,
    );
  }

  void _initSystemChrome() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorUtil().parseHexColor("#435a64"),
    ));
  }
}
