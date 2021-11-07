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

/// Widget for overlapping profile picture
class OverlappingAvatars extends StatelessWidget {
  /// Constructor
  OverlappingAvatars({Key? key}) : super(key: key);

  /// Get customer requests mocked data
  final List<HomeModel> customerRequests = HomeUtils.getMockCustomerRequests();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          ...customerRequests.mapIndexed(
            (dynamic e, int index) => Align(
              alignment: index == 0
                  ? Alignment.centerRight
                  : (index == 1 ? Alignment.center : Alignment.centerLeft),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 3)
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.red,
                    backgroundImage:
                        NetworkImage(customerRequests[index].cRProfilePic),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(IterableProperty<HomeModel>('customerRequests', customerRequests));
  }
}
