// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:guided/models/requests.dart';
import 'package:guided/utils/requests.dart';

class RequestsScreen extends StatefulWidget {
  @override
  _RequestsScreenState createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  bool _isLoading = true;
  final List<RequestsScreenModel> requestsItems =
      RequestsScreenUtils.getMockedDataRequestsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getScaffold(context),
    );
  }

  Widget getScaffold(BuildContext context) {
    return requestsItems.isNotEmpty
        ? Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 40, 0, 0),
                    child: Row(children: <Widget>[
                      const Text(
                        'Requests',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                          onTap: () {},
                          child: const Icon(Icons.tune
                          // child: Container(
                          //   width: 25,
                          //   height: 25,
                          //   decoration: const BoxDecoration(
                          //       image: DecorationImage(
                          //           fit: BoxFit.cover,
                          //           image: AssetImage(
                          //               'assets/images/filter_icon.png'))),
                          )),
                      const SizedBox(
                        width: 30,
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: requestsItems.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return Column(
                            children: [
                              _requestsListItem(context, index),
                              const Divider(
                                thickness: 0.5,
                              )
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
          )
        : Container(
            height: MediaQuery.of(context).size.height - 200,
            child: Center(child: Text("No Requests")));
  }

  Widget _requestsListItem(
    BuildContext context,
    int index,
  ) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                  child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/no_user.png'))),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          requestsItems[index].name,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(12.0, 10.0, 0.0, 0.0),
                        child: Container(
                          width: 270,
                          child: Text(
                            '${requestsItems[index].name} has requested a new booking for package 3',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        width: 60,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Center(
                          child: Text(
                            requestsItems[index].status,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}