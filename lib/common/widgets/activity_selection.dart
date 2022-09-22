import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/back_button.dart';
import 'package:guided/common/widgets/text_flieds.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/utils/services/static_data_services.dart';

class ActivitySelection extends StatefulWidget {
  final ValueChanged<List<Activity>> onActivity;
  final List<Activity> previousSelection;

  ActivitySelection({
    required this.onActivity,
    required this.previousSelection,
  });

  @override
  State<StatefulWidget> createState() => _ActivitySelectionState();
}

class _ActivitySelectionState extends State<ActivitySelection> {
  Map<String, Activity> selection = <String, Activity>{};
  List<Activity> allActivities = StaticDataService.getActivityList();

  @override
  void initState() {
    super.initState();
    for (final item in widget.previousSelection) {
      selection[item.id] = item;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          children: [
            Row(
              children: [
                const ModalBackButtonWidget(),
                SizedBox(width: 20.w),
                Text(
                  'Select a Badge',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    fontFamily: 'Gilroy',
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            AppTextField(
              name: 'place',
              hintText: 'Search',
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allActivities.length,
                itemBuilder: (context, index) {
                  final item = allActivities[index];
                  return ActivityListItem(
                    item: item,
                    selected: selection[item.id] != null,
                    onTap: () {
                      setState(() {
                        selection[item.id] = item;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(
              width: width,
              height: 60.h,
              child: ElevatedButton(
                onPressed: selection.isEmpty ? null : () {
                  final allSelection = selection.values.toList();
                  widget.onActivity(allSelection);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: AppColors.silver),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  primary: AppColors.primaryGreen,
                  onPrimary: Colors.white,
                ),
                child: Text(
                  'Save',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TODO Finish this
class ActivityListItem extends StatelessWidget {
  final Activity item;
  final VoidCallback onTap;
  final bool selected;

  ActivityListItem({required this.item, required this.onTap, required this.selected,});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.asset(item.featureImage),
      ),
    );
  }
}
