import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_color.dart';
import 'package:lms/core/widgets/custom_text_field.dart';

class DropDownList extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hint;
  final bool isCitySelected;
  final List<SelectedListItem>? dataList;
  final Function(List<SelectedListItem>) onSelectedItems;

  const DropDownList({
    required this.textEditingController,
    required this.hint,
    required this.isCitySelected,
    this.dataList,
    required this.onSelectedItems,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.h),
        CustomTextField(
          controller: textEditingController,
          readOnly: true,
          suffix: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColor.primaryColor,
          ),
          filled: true,
          filledColor: AppColor.whiteColor,
          hint: textEditingController.text.isEmpty
              ? hint
              : textEditingController.text,
          onTap: isCitySelected
              ? () {
                  FocusScope.of(context).unfocus();
                  DropDownState(
                    heightOfBottomSheet: 600.h,
                    DropDown(
                      dropDownBackgroundColor: AppColor.whiteColor,
                      isDismissible: true,
                      data: dataList ?? [],
                      searchHintText: 'Search'.tr,
                      selectedItems: (List<dynamic> selectedList) {
                        List<SelectedListItem> list = [];
                        for (var item in selectedList) {
                          if (item is SelectedListItem) {
                            list.add(item);
                            textEditingController.text = item.name;
                          }
                        }
                        onSelectedItems(list);
                      },
                    ),
                  ).showModal(context);
                }
              : null,
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }
}
