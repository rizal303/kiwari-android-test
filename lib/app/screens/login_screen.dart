import 'package:flutter/material.dart';
import 'package:mychat/app/common/alert_dialog/platform_exception_alert_dialog.dart';
import 'package:mychat/app/utils/color_util.dart';
import 'package:mychat/src/bloc/abstract_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginScreen> {
  final _btnController = new RoundedLoadingButtonController();
  bool _visibility = true;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<AbstractBloc>(context);
    return Scaffold(
      backgroundColor: ColorUtil().parseHexColor("#435a64"),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 45),
          children: <Widget>[
            logo(),
            SizedBox(height: 48.0),
            username(bloc),
            SizedBox(height: 8.0),
            password(bloc),
            SizedBox(height: 24.0),
            buttonLogin(context, bloc),
          ],
        ),
      ),
    );
  }

  Widget logo() {
    return Hero(
      tag: 'icon-chat',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 80.0,
        child: Image.asset("assets/images/icon-chat.png"),
      ),
    );
  }

  Widget username(AbstractBloc bloc) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      onChanged: bloc.onChangEmail,
      enableSuggestions: false,
      decoration: InputDecoration(
        hintText: 'E-mail',
        filled: true,
        fillColor: Colors.white,
        contentPadding: contentPadding(),
        border: border(),
      ),
    );
  }

  Widget password(AbstractBloc bloc) {
    return TextFormField(
      autofocus: false,
      obscureText: _visibility,
      enableSuggestions: false,
      onChanged: bloc.onChangePassword,
      decoration: InputDecoration(
        hintText: 'Password',
        errorStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _visibility = _visibility ? false : true;
              });
            },
            child: Icon(
              _visibility ? Icons.visibility : Icons.visibility_off,
            )),
        contentPadding: contentPadding(),
        border: border(),
      ),
    );
  }

  Widget buttonLogin(BuildContext context, AbstractBloc bloc) {
    return RoundedLoadingButton(
      child: Text(
        'LOGIN',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      animateOnTap: true,
      controller: _btnController,
      onPressed: () => _handleLogin(context, bloc),
      color: ColorUtil().parseHexColor("#32AC71"),
      width: 320,
    );
  }

  Future<void> _handleLogin(BuildContext context, AbstractBloc bloc) async {
    try {
      await bloc.signInWithEmailAndPassword();
    } on PlatformException catch (error) {
      _btnController.reset();
      PlatformExceptionAlertDialog(
        title: "Gagal Login",
        exception: error,
      ).show(context);
    }
  }

  EdgeInsetsGeometry contentPadding() {
    return EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0);
  }

  InputBorder border() {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(32.0));
  }
}
