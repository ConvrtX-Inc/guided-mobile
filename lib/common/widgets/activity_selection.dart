import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guided/common/widgets/modal.dart';
import 'package:guided/common/widgets/text_flieds.dart';
import 'package:guided/constants/app_colors.dart';
import 'package:guided/models/activities_model.dart';
import 'package:guided/utils/services/static_data_services.dart';

class ActivitySelection extends StatefulWidget {
  final ValueChanged<List<Activity>> onActivity;
  final List<Activity> previousSelection;
  final bool multiple;

  ActivitySelection({
    required this.onActivity,
    required this.previousSelection,
    this.multiple = false,
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
        padding: EdgeInsets.all(30.w),
        child: Column(
          children: [
            const ModalTitle(title: 'Select a Badge'),
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
                        if (selection.containsKey(item.id)) {
                          selection.remove(item.id);
                        } else {
                          if (!widget.multiple) {
                            selection.clear();
                          }

                          selection[item.id] = item;
                        }
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
                onPressed: selection.isEmpty
                    ? null
                    : () {
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

class ActivityListItem extends StatelessWidget {
  final Activity item;
  final VoidCallback onTap;
  final bool selected;

  ActivityListItem({
    required this.item,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: AssetImage(item.path),
        backgroundColor: Colors.transparent,
      ),
      title: Text(item.name),
      trailing: selected
          ? CircleAvatar(
              child: Image.asset('assets/images/complete.png'),
              backgroundColor: Colors.transparent,
            )
          : null,
    );
  }
}
