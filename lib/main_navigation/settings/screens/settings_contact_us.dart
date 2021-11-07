import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guided/helpers/constant.dart';

/// Screen for settings contact us
class SettingsContactUs extends StatefulWidget {
  /// Constructor
  const SettingsContactUs({Key? key}) : super(key: key);

  @override
  _SettingsContactUsState createState() => _SettingsContactUsState();
}

class _SettingsContactUsState extends State<SettingsContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset('assets/images/svg/arrow_back_with_tail.svg',
                height: 29, width: 34),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: Column(
                children: <Widget>[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Contact US',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          'Leave us a message. We’ll get contact you as soon as possible',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: ConstantHelpers.grey)),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: ConstantHelpers.nobel,
                            fontSize: 16),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        filled: true,
                        hintText: 'Name',
                        contentPadding: const EdgeInsets.all(25),
                        fillColor: Colors.white70),
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: ConstantHelpers.nobel,
                            fontSize: 16),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        filled: true,
                        hintText: 'Email',
                        contentPadding: const EdgeInsets.all(25),
                        fillColor: Colors.white70),
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    minLines:
                        6, // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        hintText: 'Message'),
                  ),
                  SizedBox(
                    width: double.maxFinite, // set width to maxFinite
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(20)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ConstantHelpers.spruce),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ))),
                        child: const Text(
                          'Send',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
