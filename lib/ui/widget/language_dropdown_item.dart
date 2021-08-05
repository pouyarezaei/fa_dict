import 'package:flutter/material.dart';

class LanguageDropDownItem extends StatelessWidget {
  final Widget flag;
  final String country;

  const LanguageDropDownItem(
      {Key? key, required this.flag, required this.country})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: flag),
          Text(country)
        ],
      ),
    );
  }
}
