import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guided/models/home.dart';
import 'package:guided/utils/home.dart';

/// extension for an iterable items with index
extension IndexedIterable<E> on Iterable<E> {
  /// function to call
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    int i = 0;
    return map((E e) => f(e, i++));
  }
}

/// Widget for concat strings
class ConcatStrings extends StatelessWidget {
  ConcatStrings({Key? key}) : super(key: key);


  /// variable for concatenated strings
  String concatStrings = '';

  /// Get customer requests mocked data
  final List<HomeModel> customerRequests = HomeUtils.getMockCustomerRequests();

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < customerRequests.length; i++) {
      concatStrings = '$concatStrings${customerRequests[i].cRFirstName}, ';
    }

    /// remove the last insert comma
    concatStrings = concatStrings.substring(0, concatStrings.length - 2);

    return Expanded(
        child: Text(
      concatStrings,
      style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14
      ),
    ));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(IterableProperty<HomeModel>('customerRequests', customerRequests));
    properties.add(StringProperty('concatStrings', concatStrings));
  }
}
