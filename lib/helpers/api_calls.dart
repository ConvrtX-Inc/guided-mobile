import 'package:flutter/material.dart';
import 'package:guided/main_navigation/main_navigation.dart';
import 'package:guided/signin_signup/create_new_password_screen.dart';
import 'package:guided/signin_signup/reset_password_verify_phone.dart';
import 'package:guided/signin_signup/signup_form.dart';
import 'package:guided/signin_signup/signup_verify_phone.dart';
import 'package:http/http.dart' as http;

class ApiCalls {

    // Send code to user
    static sendCode(BuildContext context, String phoneNumber, String id) async {
      try{
        var response = await http.post(Uri.parse('http://localhost:3000/api/v1/auth/verify/mobile/send'),
            body: {
              'phone_number': phoneNumber,
            });

        if(response.statusCode == 201){
          await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupVerify(phoneNumber: phoneNumber))
          );
        }
      }
      catch(e){
        print(e);
      }
    }

    // Send code to user
    static reSendCode(String phoneNumber) async {
      try{
        var response = await http.post(Uri.parse('http://localhost:3000/api/v1/auth/verify/mobile/send'),
            body: {
              'phone_number': phoneNumber,
            });
      }
      catch(e){
        print(e);
      }
    }

    // Verify code (Sign up)
    static verifyCode(BuildContext context, String phoneNumber, String code) async {
      try{
        var response = await http.post(Uri.parse('http://localhost:3000/api/v1/auth/verify/mobile/check'),
            body: {
              'phone_number': phoneNumber,
              'verifyCode': code,
            });
        if(response.statusCode == 201){
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SignupForm()
            ),
          );
        }
      }
      catch(e){
        print(e);
      }
    }

    // Verify code (Reset Password)
    static verifyForgotPassword(BuildContext context, String code, String phoneNumber) async {
      try{
        var response = await http.post(Uri.parse('http://localhost:3000/api/v1/auth/email/confirm'),
            body: {
              'hash': code,
            });

        if(response.statusCode == 200){
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreateNewPasswordScreen(code: code, phoneNumber: phoneNumber)
            ),
          );
        }
      }
      catch(e){
        print(e);
      }
    }

    // Login API
    static login(BuildContext context, String email, String password) async {
      try{
        var response = await http.post(Uri.parse('http://localhost:3000/api/v1/auth/email/login'),
            body: {
              'email': email,
              'password': password,
            });

        if(response.statusCode == 200){
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MainNavigationScreen(navIndex: 0, contentIndex: 0,)),
          );
        }
      }
      catch(e){
        print(e);
      }
    }

    // Forgot Password
    static forgotPassword(BuildContext context, String email, String phoneNumber) async {
      try{
        var response = await http.post(Uri.parse('http://localhost:3000/api/v1/auth/forgot/password'),
            body: {
              'email': email,
              'phone_no': phoneNumber
            });

        if(response.statusCode == 200){
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResetVerifyPhone(email: email, phoneNumber: phoneNumber)),
          );
        }
      }
      catch(e){
        print(e);
      }
    }

    // Resend OTP (Forgot Password)
    static resendOTP(String email, String phoneNumber) async {
      try{
        var response = await http.post(Uri.parse('http://localhost:3000/api/v1/auth/forgot/password'),
            body: {
              'email': email,
              'phone_no': phoneNumber
            });
      }
      catch(e){
        print(e);
      }
    }

    static resetPassword(String password, String code, String phoneNumber) async {
      try{
        var response = await http.post(Uri.parse('http://localhost:3000/api/v1/auth/reset/password'),
        body: {
          'password': password,
          'hash': code,
          'phone': phoneNumber
        });
      }
      catch(e){
        print(e);
      }
    }
}
