import 'package:flutter/material.dart';

final hours = [2, 3, 4, 5, 6, 7, 8].map((i) => '$i Hours');
final days = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13].map((i) => '$i Days');
final weeks = [1, 2].map((i) => '$i Weeks');

class DurationModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: hours
                  .map((e) => TextButton(
                      onPressed: () => _onChoose(context, e), child: Text(e)))
                  .toList(),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: days
                  .map((e) => TextButton(
                      onPressed: () => _onChoose(context, e), child: Text(e)))
                  .toList(),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: weeks
                  .map((e) => TextButton(
                      onPressed: () => _onChoose(context, e), child: Text(e)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _onChoose(BuildContext context, String text) {
    Navigator.of(context).pop(text);
  }
}
