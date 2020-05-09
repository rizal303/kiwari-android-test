import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:mychat/src/helper/flutter_local_storage.dart';
import 'package:mychat/app/utils/color_util.dart';

class Message extends StatelessWidget {
  final String from;
  final String text;
  final DateTime date;

  const Message({Key key, this.from, this.text, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: _isMe() ? Alignment.topRight : Alignment.topLeft,
      child: Bubble(
        color: _isMe()
            ? ColorUtil().parseHexColor("#075e54")
            : ColorUtil().parseHexColor("#435a64"),
        nip: _isMe() ? BubbleNip.rightTop : BubbleNip.leftTop,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _isMe()
                ? const SizedBox()
                : Text(
                    _displayName(),
                    style: TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      letterSpacing: 0.2,
                    ),
                  ),
            SizedBox(height: _isMe() ? 0 : 3),
            RichText(
              text: TextSpan(
                text: text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 0.2,
                ),
                children: <TextSpan>[
                  TextSpan(text: "\t\t\t"),
                  TextSpan(
                    text: date.toString().substring(10, 16).trim(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _isMe() {
    return FlutterLocalStorage().getEmail() == from ? true : false;
  }

  String _displayName() {
    return from.contains("ismail") ? "Ismail bin Mail" : "Jarjit Singh";
  }
}
