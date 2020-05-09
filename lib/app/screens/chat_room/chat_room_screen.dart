import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mychat/app/common/alert_dialog/platform_exception_alert_dialog.dart';
import 'package:mychat/app/router/route_name.dart';
import 'package:mychat/app/screens/chat_room/message.dart';
import 'package:mychat/app/screens/chat_room/send_message.dart';
import 'package:mychat/src/bloc/abstract_bloc.dart';
import 'package:flutter/services.dart';
import 'package:mychat/src/helper/flutter_local_storage.dart';
import 'package:provider/provider.dart';
import 'package:mychat/app/utils/color_util.dart';

class ChatRoomScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatRoomState();
  }
}

class _ChatRoomState extends State<ChatRoomScreen> {
  final choices = <String>['Lihat Kontak', 'Logout'];
  final Firestore _firestore = Firestore.instance;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AbstractBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtil().parseHexColor("#435a64"),
        title: Text("My Chat"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              select(value, bloc);
            },
            itemBuilder: (BuildContext context) {
              return choices.map((menu) {
                return PopupMenuItem<String>(
                  value: menu,
                  child: Text(menu),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/images/background.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('messages')
                      .orderBy('date')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: CircularProgressIndicator(),
                      );

                    List<DocumentSnapshot> docs = snapshot.data.documents;

                    return ListView(
                      controller: scrollController,
                      children: List.generate(docs.length, (index) {
                        DateTime date =
                            DateTime.parse(docs[index].data['date']);

                        return Column(
                          children: <Widget>[
                            index == 0
                                ? dateReceived(date)
                                : showDateReceived(
                                    DateTime.parse(
                                        docs[index - 1].data['date']),
                                    date),
                            Message(
                              from: docs[index].data['from'],
                              text: docs[index].data['text'],
                              date: date,
                            )
                          ],
                        );
                      }),
                    );
                  },
                ),
              ),
              SendMessage(
                callback: () => callback(),
                messageController: messageController,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showDateReceived(DateTime oldValue, DateTime newValue) {
    final formatter = DateFormat("dd/MM/yyyy");
    if (formatter.format(oldValue) != formatter.format(newValue)) {
      return dateReceived(newValue);
    }
    return Container();
  }

  Widget dateReceived(DateTime date) {
    final formatter = DateFormat("MMM dd, yyyy");
    return Container(
      padding: const EdgeInsets.all(10),
      child: Material(
        color: Color.fromRGBO(212, 234, 244, 1.0),
        borderRadius: BorderRadius.circular(4.0),
        elevation: 5,
        child: Container(
            padding: const EdgeInsets.all(7),
            child: Text(
              formatter.format(date) == formatter.format(DateTime.now())
                  ? "HARI INI"
                  : formatter.format(date),
            )),
      ),
    );
  }

  void select(String menu, AbstractBloc bloc) {
    if (menu.toLowerCase().contains("logout")) {
      handleLogout(bloc);
    } else {
      if (FlutterLocalStorage().getEmail() != null) {
        Navigator.pushNamed(context, RouteName.viewContact);
      }
    }
  }

  Future<void> handleLogout(AbstractBloc bloc) async {
    try {
      await bloc.signOut();
    } on PlatformException catch (error) {
      PlatformExceptionAlertDialog(
        title: "Gagal Logout",
        exception: error,
      ).show(context);
    }
  }

  Future<void> callback() async {
    if (messageController.text.length > 0) {
      await _firestore.collection('messages').add({
        'text': messageController.text,
        'from': FlutterLocalStorage().getEmail(),
        'date': DateTime.now().toIso8601String().toString(),
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }
}
