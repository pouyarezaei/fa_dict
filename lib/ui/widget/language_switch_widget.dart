import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';

import '../color_palette.dart';
import 'language_dropdown_item.dart';

class LanguageSwitch extends StatelessWidget {
  final Function(dynamic value) dropDownOnchangeTo;
  final Function(dynamic value) dropDownOnchangeFrom;
  final int valueTo;
  final int valueFrom;

  LanguageSwitch(
      {Key? key,
      required this.dropDownOnchangeTo,
      required this.dropDownOnchangeFrom,
      required this.valueTo,
      required this.valueFrom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton(
          value: valueTo,
          icon: Icon(Icons.keyboard_arrow_down),
          underline: Container(),
          menuMaxHeight: MediaQuery.of(context).size.height / 4,
          items: [
            DropdownMenuItem(
              child: LanguageDropDownItem(
                flag: Flag.fromCode(
                  FlagsCode.US,
                  fit: BoxFit.scaleDown,
                  height: 50,
                  width: 50,
                ),
                country: "انگیلیسی",
              ),
              value: 1,
            ),
            DropdownMenuItem(
              child: LanguageDropDownItem(
                flag: Flag.fromCode(
                  FlagsCode.IR,
                  fit: BoxFit.fitWidth,
                  height: 50,
                  width: 50,
                ),
                country: "فارسی",
              ),
              value: 2,
            )
          ],
          onChanged: dropDownOnchangeTo,
        ),
        Icon(
          Icons.compare_arrows,
          color: ColorPalette.buccaneer,
        ),
        DropdownButton(
          icon: Icon(Icons.keyboard_arrow_down),
          underline: Container(),
          menuMaxHeight: MediaQuery.of(context).size.height / 4,
          value: valueFrom,
          items: [
            DropdownMenuItem(
              child: LanguageDropDownItem(
                flag: Flag.fromCode(
                  FlagsCode.US,
                  fit: BoxFit.scaleDown,
                  height: 50,
                  width: 50,
                ),
                country: "انگیلیسی",
              ),
              value: 1,
            ),
            DropdownMenuItem(
              child: LanguageDropDownItem(
                flag: Flag.fromCode(
                  FlagsCode.IR,
                  fit: BoxFit.fitWidth,
                  height: 50,
                  width: 50,
                ),
                country: "فارسی",
              ),
              value: 2,
            )
          ],
          onChanged: dropDownOnchangeFrom,
        )
      ],
    );
  }
}
