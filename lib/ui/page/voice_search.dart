import 'package:fa_dict/ui/color_palette.dart';
import 'package:fa_dict/ui/widget/language_switch_widget.dart';
import 'package:fa_dict/ui/widget/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class VoiceSearch extends StatefulWidget {
  const VoiceSearch({Key? key}) : super(key: key);

  @override
  _VoiceSearchState createState() => _VoiceSearchState();
}

class _VoiceSearchState extends State<VoiceSearch> {
  int _valueTo = 2;
  int _valueFrom = 1;
  String voicedString =
      "voicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedStringvoicedString";
  TextDirection _textDirection = TextDirection.ltr;
  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      elevation: 1,
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12));
  bool recording = false;

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
              TitleWidget(title: "متن گفته شده"),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                padding: EdgeInsets.all(8.0),
                child: Directionality(
                  textDirection: _textDirection,
                  child: TextField(
                    maxLines: 6,
                    showCursor: true,
                    decoration: InputDecoration(
                        filled: true,
                        contentPadding: const EdgeInsets.all(16.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintTextDirection: TextDirection.rtl,
                        hintText:
                            "متن مورد نظر خود را برای ترجمه وارد کنید ..."),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: style,
                      onPressed: () {},
                      child: const Text('ویرایش متن'),
                    ),
                    ElevatedButton(
                      style: style,
                      onPressed: () {},
                      child: const Text('ترجمه متن'),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                margin: recording ? EdgeInsets.zero : EdgeInsets.only(top: 24),
                alignment: Alignment.center,
                padding: recording ? EdgeInsets.all(24) : EdgeInsets.zero,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: recording ? ColorPalette.wildWatermelon : Colors.white,
                ),
                duration: Duration(milliseconds: 250),
                child: RawMaterialButton(
                  fillColor:
                      recording ? Colors.white : ColorPalette.wildWatermelon,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(30),
                  onPressed: _onSearchClicked,
                  child: Icon(
                    recording ? Icons.mic_off_rounded : Icons.mic_none,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void _onSearchClicked() {
    setState(() {
      recording = !recording;
    });
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
}
