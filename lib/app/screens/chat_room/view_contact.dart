import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mychat/app/utils/color_util.dart';
import 'package:mychat/src/helper/flutter_local_storage.dart';

class ViewContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              FadeInImage.assetNetwork(
                placeholder: "assets/gif/loading-circle.gif",
                image: _urlImage(),
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    _name(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Material(
                    borderRadius: BorderRadius.circular(50.0),
                    color: ColorUtil().parseHexColor("#32AC71"),
                    child: InkWell(
                      onTap: () => Navigator.pop(context, null),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _urlImage() {
    return FlutterLocalStorage().getEmail() != null &&
            FlutterLocalStorage().getEmail().contains("jarjit")
        ? "https://api.adorable.io/avatars/160/ismail@mail.com.png"
        : "https://api.adorable.io/avatars/160/jarjit@mail.com.png";
  }

  String _name() {
    return FlutterLocalStorage().getEmail() != null &&
            FlutterLocalStorage().getEmail().contains("jarjit")
        ? "Ismail bin Mail"
        : "Jarjit Singh";
  }
}
