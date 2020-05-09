import 'package:flutter/cupertino.dart';
import 'package:mychat/app/screens/chat_room/chat_room_screen.dart';
import 'package:mychat/app/screens/login_screen.dart';
import 'package:mychat/src/bloc/abstract_bloc.dart';
import 'package:provider/provider.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AbstractBloc>(context);
    return StreamBuilder<String>(
      stream: bloc.onAuthStateChanged,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return snapshot.data.isNotEmpty ? ChatRoomScreen() : LoginScreen();
        }
        return Container();
      },
    );
  }
}
