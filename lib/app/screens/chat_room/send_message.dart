import 'package:flutter/material.dart';
import 'package:mychat/app/utils/color_util.dart';

class SendMessage extends StatelessWidget {
  final VoidCallback callback;
  final TextEditingController messageController;

  const SendMessage({
    Key key,
    @required this.callback,
    @required this.messageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              autocorrect: false,
              enableSuggestions: false,
              onSubmitted: (value) => callback(),
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                hintText: "Ketik Pesan...",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              ),
              controller: messageController,
            ),
          ),
          SizedBox(width: 10),
          Material(
            borderRadius: BorderRadius.circular(50.0),
            color: ColorUtil().parseHexColor("#32AC71"),
            child: InkWell(
              onTap: callback,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
