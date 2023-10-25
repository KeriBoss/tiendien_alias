import 'package:tiendien_alias/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  const MyRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 5.5.h,
        padding: EdgeInsets.symmetric(
          horizontal: 2.w,
        ),
        child: Row(
          children: [
            _customRadioButton,
            SizedBox(width: 2.w),
            if (title != null) title,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return SvgPicture.asset(
      isSelected ? AppImages.checkedBox : AppImages.unCheckedBox,
    );
  }
}
