import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/constants/app_list.dart';
import 'package:guided/helpers/hexColor.dart';
import 'package:guided/models/available_date_model.dart';
import 'package:guided/screens/widgets/reusable_widgets/easy_scroll_to_index.dart';

/// Month Selector Widget
class MonthSelector extends StatefulWidget {
  ///Constructor
  const MonthSelector(
      {required this.onMonthSelected, required this.selectedDate, Key? key})
      : super(key: key);

  final DateTime selectedDate;

  final Function onMonthSelected;

  @override
  _MonthSelectorState createState() => _MonthSelectorState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<DateTime>('selectedDate', selectedDate))
      ..add(DiagnosticsProperty<Function>('onMonthSelected', onMonthSelected));
  }
}

class _MonthSelectorState extends State<MonthSelector> {
  List<AvailableDateModel> dates = AppListConstants().availableDates;

  final int currentMonth = DateTime.now().month;

  final ScrollToIndexController scrollController = ScrollToIndexController();

  int currentMonthScrollIndex = 1;

  @override
  void initState() {
    super.initState();

    // currentMonthScrollIndex = currentMonth - 1;

    // dates = dates
    dates = dates.where((element) => element.month >= currentMonth).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          onPressed: () {
            debugPrint('currentMonth scroll index $currentMonthScrollIndex');
            if (currentMonthScrollIndex > 0) {
              setState(() {
                currentMonthScrollIndex = currentMonthScrollIndex -= 2;
              });

              scrollController.easyScrollToIndex(
                  index: currentMonthScrollIndex);
            }
          },
          icon: Icon(
            Icons.chevron_left,
            color: HexColor('#898A8D'),
          ),
        ),
     Expanded(child:    Container(
         color: Colors.transparent,
         height: 80.h,
         width: MediaQuery.of(context).size.width * 0.7,
         child: EasyScrollToIndex(
           controller: scrollController,
           scrollDirection: Axis.horizontal,
           itemCount: dates.length,
           itemWidth: 95,
           itemHeight: 70,
           itemBuilder: (BuildContext context, int index) {
             return dates[index].month >= currentMonth
                 ? InkWell(
               onTap: () {
                 // updateState(() {
                 //   selectedDate =
                 //       DateTime(selectedDate.year, dates[index].month);
                 // });

                 // debugPrint('Select Month ${selectedDate.toString()}');

                 widget.onMonthSelected(DateTime(
                     widget.selectedDate.year, dates[index].month));
               },
               child: Stack(
                 children: <Widget>[
                   Align(
                     alignment: Alignment.center,
                     child: Container(
                       margin: EdgeInsets.fromLTRB(
                           index == 0 ? 0.w : 0.w, 0.h, 10.w, 0.h),
                       width: 89,
                       height: 45,
                       decoration: BoxDecoration(
                           borderRadius: const BorderRadius.all(
                             Radius.circular(10),
                           ),
                           border: Border.all(
                               color: dates[index].month ==
                                   widget.selectedDate.month
                                   ? HexColor('#FFC74A')
                                   : HexColor('#C4C4C4'),
                               width: 1),
                           color: dates[index].month ==
                               widget.selectedDate.month
                               ? HexColor('#FFC74A')
                               : Colors.white),
                       child:
                       Center(child: Text(dates[index].monthName)),
                     ),
                   ),
                 ],
               ),
             )
                 : Container();
           },
         )),),
        IconButton(
          onPressed: () {
            debugPrint('currentMonth scroll index $currentMonthScrollIndex');
            if (currentMonthScrollIndex < dates.length - 1) {
              setState(() {
                currentMonthScrollIndex += 2;
              });
              scrollController.easyScrollToIndex(
                  index: currentMonthScrollIndex);
            }
          },
          icon: Icon(
            Icons.chevron_right,
            color: HexColor('#898A8D'),
          ),
        )
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('currentMonth', currentMonth))
      ..add(IterableProperty<AvailableDateModel>('dates', dates))
      ..add(IntProperty('currentMonthScrollIndex', currentMonthScrollIndex))
      ..add(DiagnosticsProperty<ScrollToIndexController>(
          'scrollController', scrollController));
  }
}
