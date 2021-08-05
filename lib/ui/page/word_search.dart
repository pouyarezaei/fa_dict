import 'package:fa_dict/ui/widget/language_dropdown_item.dart';
import 'package:flag/flag.dart';
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
  TextEditingController _textEditingController = TextEditingController();
  TextDirection _textDirection = TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 32, 32, 0),
            child: Text(
              "زبان ها",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton(
                  value: _valueTo,
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
                  onChanged: _dropDownOnchangeTo,
                ),
                Icon(
                  Icons.compare_arrows,
                  color: ColorPalette.buccaneer,
                ),
                DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  underline: Container(),
                  menuMaxHeight: MediaQuery.of(context).size.height / 4,
                  value: _valueFrom,
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
                  onChanged: _dropDownOnchangeFrom,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 32, 32, 0),
            child: Text(
              "ترجمه لغت",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
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
                      splashColor: ColorPalette.wildWatermelon, // Splash color
                      onTap: _onSearchClicked,
                      child: SizedBox(
                          width: 50, height: 50, child: Icon(Icons.search)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            child: Text(
              "اخیرا ترجمه شده",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 1,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    title: Text("کلمه"),
                    leading: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        (index) % 2 == 0
                            ? Icons.favorite_border
                            : Icons.favorite,
                        color: ColorPalette.mandy,
                      ),
                    ),
                    trailing: Text(
                      "Word",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          )
        ],
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
