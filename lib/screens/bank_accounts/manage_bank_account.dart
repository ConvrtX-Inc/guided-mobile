import 'package:flutter/material.dart';

///Manage Bank Account
class ManageBankAccountScreen extends StatefulWidget {
  ///Constructor
  const ManageBankAccountScreen({Key? key}) : super(key: key);

  @override
  _ManageBankAccountScreenState createState() =>
      _ManageBankAccountScreenState();
}

class _ManageBankAccountScreenState extends State<ManageBankAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Manage Bank Account',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontFamily: 'Gilroy'),
        ),
      ),
      body: buildBankAccountUI(),
    );
  }

  Widget buildBankAccountUI() => Container();
}
