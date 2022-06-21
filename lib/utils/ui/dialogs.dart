import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///App Dialogs
class AppDialogs{

  ///Dialog for Success
  void showSuccess(){

  }

  ///Dialog for Error
  void showError({required BuildContext context, required String message, required String title, Function? onOkPressed}){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      title: title,
      titleTextStyle:
      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
      headerAnimationLoop: false,
      desc: message,
      btnOkOnPress:(){
        onOkPressed!();
      },
    ).show();
  }

  ///Dialog for Warning
  void showWarning(){

  }
}