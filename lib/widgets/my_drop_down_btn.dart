import 'package:tiendien_alias/constants/color_constants.dart';
import 'package:tiendien_alias/constants/font_constants.dart';
import 'package:tiendien_alias/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyDropDownBtn extends StatelessWidget {
  const MyDropDownBtn({Key? key, required this.hintText}) : super(key: key);
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 92.w,
      //height: 7.5.h,
      margin: EdgeInsets.only(
        bottom: 2.5.h,
      ),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                bottom: 1.h,
                left: 5.w,
                right: 2.w,
              ),
              label: Text('Select $hintText'),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                //value: _currentSelectedValue,
                hint: Text(
                  hintText,
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    color: ColorConstants.lightGray,
                    fontFamily: FontConstants.comfortaaSemiBold,
                  ),
                ),
                isDense: true,
                iconSize: 4.h,
                onChanged: (newValue) {},
                items: categoryItems.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 11.5.sp,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
