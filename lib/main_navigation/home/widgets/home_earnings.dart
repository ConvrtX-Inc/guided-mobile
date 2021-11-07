import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guided/helpers/constant.dart';
import 'package:guided/models/home.dart';
import 'package:guided/utils/home.dart';

/// Widget for home earnings
class HomeEarnings extends StatelessWidget {
  /// Constructor
  HomeEarnings({Key? key}) : super(key: key);

  /// Get customer requests mocked data
  final List<HomeModel> earnings = HomeUtils.getMockEarnings();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 21),
      decoration: BoxDecoration(
        color: ConstantHelpers.porcelain,
        borderRadius: BorderRadius.circular(8),
        // color: ConstantHelpers.platinum,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Center(
                    child: Text('\$${earnings[0].personalBalance}',
                        style: TextStyle(
                            color: ConstantHelpers.aquaGreen,
                            fontWeight: FontWeight.w700,
                            fontSize: 18)),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Personal Balance',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          height: 1.5,
                          color: ConstantHelpers.venus),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Center(
                    child: Text('\$${earnings[0].pendingOrders}',
                        style: TextStyle(
                            color: ConstantHelpers.butterScotch,
                            fontWeight: FontWeight.w700,
                            fontSize: 18)),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Pending Orders',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          height: 1.5,
                          color: ConstantHelpers.venus),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Center(
                    child: Text('\$${earnings[0].totalEarnings}',
                        style: TextStyle(
                            color: ConstantHelpers.pineCone,
                            fontWeight: FontWeight.w700,
                            fontSize: 18)),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Total Earnings',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          height: 1.5,
                          color: ConstantHelpers.venus),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<HomeModel>('earnings', earnings));
  }
}
