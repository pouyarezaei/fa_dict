import 'package:fa_dict/ui/widget/language_switch_widget.dart';
import 'package:fa_dict/ui/widget/list_item.dart';
import 'package:fa_dict/ui/widget/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../color_palette.dart';

class WordSearch extends StatefulWidget {
  const WordSearch({Key? key}) : super(key: key);

  @override
  _WordSearchState createState() => _WordSearchState();
}

class _WordSearchState extends State<WordSearch> {
  int _valueTo = 2;
  int _valueFrom = 1;
  TextDirection _textDirection = TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(title: "زبان ها"),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: LanguageSwitch(
                  valueTo: _valueTo,
                  valueFrom: _valueFrom,
                  dropDownOnchangeTo: _dropDownOnchangeTo,
                  dropDownOnchangeFrom: _dropDownOnchangeFrom,
                )),
            TitleWidget(title: "ترجمه لغت"),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Directionality(
                      textDirection: _textDirection,
                      child: TextField(
                        showCursor: true,
                        decoration: InputDecoration(
                            filled: true,
                            contentPadding: const EdgeInsets.all(16.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(45),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(45),
                            ),
                            hintTextDirection: TextDirection.rtl,
                            hintText:
                                "کلمه مورد نظر خود را برای ترجمه وارد کنید ..."),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  ClipOval(
                    child: Material(
                      color: ColorPalette.mandy, // Button color
                      child: InkWell(
                        splashColor: ColorPalette.wildWatermelon,
                        // Splash color
                        onTap: _onSearchClicked,
                        child: SizedBox(
                            width: 50, height: 50, child: Icon(Icons.search)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TitleWidget(title: "اخیرا ترجمه شده"),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return ListItem(index: index);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onSearchClicked() {
    showDialog(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text('بیا بخورش'),
          content: Text('هدف این بود ک فقط اینو بزنی کیر شی ...'),
        ),
      ),
    );
  }

  void _dropDownOnchangeTo(dynamic value) {
    setState(() {
      var old = _valueTo;
      _valueTo = value;
      if (_valueTo == _valueFrom) {
        _valueFrom = old;
      }
      _changeDirection();
    });
  }

  void _changeDirection() {
    if (_valueFrom == 1) {
      _textDirection = TextDirection.ltr;
    } else {
      _textDirection = TextDirection.rtl;
    }
  }

  void _dropDownOnchangeFrom(dynamic value) {
    setState(() {
      var old = _valueFrom;
      _valueFrom = value;
      if (_valueTo == _valueFrom) {
        _valueTo = old;
      }
      _changeDirection();
    });
  }
}
