import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:mychat/app/router/route_name.dart';
import 'package:mychat/app/auth.dart';
import 'package:mychat/app/screens/chat_room/chat_room_screen.dart';
import 'package:mychat/app/screens/chat_room/view_contact.dart';
import 'package:mychat/app/screens/login_screen.dart';
import 'package:mychat/src/bloc/abstract_bloc.dart';
import 'package:mychat/src/bloc/service_bloc.dart';

import 'package:provider/provider.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return new PageRouteBuilder<dynamic>(
      settings: settings,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        switch (settings.name) {
          case RouteName.auth:
            return Provider<AbstractBloc>(
              create: (_) => ServiceBloc(),
              dispose: (_, value) => value.dispose(),
              child: Auth(),
            );
          case RouteName.login:
            return Provider<AbstractBloc>(
              create: (_) => ServiceBloc(),
              dispose: (_, value) => value.dispose(),
              child: LoginScreen(),
            );
          case RouteName.chatroom:
            return Provider<AbstractBloc>(
              create: (_) => ServiceBloc(),
              dispose: (_, value) => value.dispose(),
              child: ChatRoomScreen(),
            );
          case RouteName.viewContact:
            return ViewContact();
          default:
            return Scaffold(
              body:
                  Center(child: Text('No route defined for ${settings.name}')),
            );
        }
      },
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return effectMap[PageTransitionType.fadeIn](
            Curves.linear, animation, secondaryAnimation, child);
      },
    );
  }
}
