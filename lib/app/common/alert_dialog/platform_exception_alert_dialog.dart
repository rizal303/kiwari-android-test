import 'package:flutter/services.dart';
import 'package:mychat/app/common/alert_dialog/platform_alert_dialog.dart';


class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog(
      {String title, bool isClosePopUp, PlatformException exception})
      : super(
          title: title,
          content: _message(exception),
          defaultActionText: "Tutup",
        );

  static String _message(PlatformException exception) {
    return exception.message;
  }

}
