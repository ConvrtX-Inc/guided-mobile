// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CreateAvailabilityScreen extends StatefulWidget {
  const CreateAvailabilityScreen({Key? key}) : super(key: key);

  @override
  _CreateAvailabilityScreenState createState() =>
      _CreateAvailabilityScreenState();
}

class _CreateAvailabilityScreenState extends State<CreateAvailabilityScreen> {
  bool _switchValue = true;
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.white,
        height: height,
        width: width,
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Schedule',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Set Your Self As Unavailable',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Spacer(),
                            FlutterSwitch(
                              height: 22.0,
                              width: 40.0,
                              padding: 4.0,
                              toggleSize: 15.0,
                              borderRadius: 10.0,
                              activeColor: Colors.green,
                              value: _switchValue,
                              onToggle: (value) {
                                setState(() {
                                  _switchValue = value;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: 350,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 15,
                                        bottom: 11,
                                        top: 11,
                                        right: 15),
                                    hintText: "Why? (Optional)"),
                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  // _reviewText = value;
                                },
                                maxLength: 100,
                                style: const TextStyle(color: Colors.black),
                                maxLines: 6,
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Return Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: Text(
                                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            )
                          ],
                        )),
                  ],
                ))),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedDate = pickedDate;
      });
  }
}
