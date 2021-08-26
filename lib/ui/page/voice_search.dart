import 'package:fa_dict/bloc/wordsearch/word_search_bloc.dart';
import 'package:fa_dict/ui/app_theme.dart';
import 'package:fa_dict/ui/widget/language_switch_widget.dart';
import 'package:fa_dict/ui/widget/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceSearch extends StatefulWidget {
  const VoiceSearch({Key? key}) : super(key: key);

  @override
  _VoiceSearchState createState() => _VoiceSearchState();
}

class _VoiceSearchState extends State<VoiceSearch>
    with SingleTickerProviderStateMixin {
  int _valueTo = 2;
  int _valueFrom = 1;
  TextDirection _textDirection = TextDirection.ltr;
  bool _recording = false;
  bool _editable = false;
  late String voicedString;
  late String translateString = "";
  late stt.SpeechToText _speech;
  late TextEditingController _textEditingController;
  late AnimationController _glowAnimationController;
  late Animation _glowAnimation;

  @override
  void initState() {
    _speech = stt.SpeechToText();
    _textEditingController = TextEditingController();
    _glowAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 900));

    _glowAnimation = Tween(begin: 2.0, end: 15.0)
        .animate(_glowAnimationController)
          ..addListener(() => setState(() {}));

    print("initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: BlocListener<WordSearchBloc, WordSearchState>(
            listener: (context, state) {
              if (state is SentenceSearchResultState) {
                setState(() {
                  translateString = state.sentenceSearchResult;
                });
              }
            },
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
                      controller: _textEditingController,
                      enabled: _editable,
                      maxLines: 6,
                      showCursor: true,
                      decoration: InputDecoration(
                          filled: true,
                          contentPadding: const EdgeInsets.all(16.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintTextDirection: TextDirection.rtl,
                          hintText: "برای ضبط روی دکمه لمس کنید..."),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: AppTheme.buttonStyle,
                        onPressed: _onEditingTextClicked,
                        child: const Text('ویرایش متن'),
                      ),
                      ElevatedButton(
                        style: AppTheme.buttonStyle,
                        onPressed: _onTranslateTextClicked,
                        child: const Text('ترجمه متن'),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: _onSearchClicked,
                    child: Container(
                      margin: EdgeInsets.all(16.0),
                      width: 100,
                      height: 100,
                      child: Icon(
                        _recording ? Icons.mic_off_rounded : Icons.mic_none,
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context).primaryColor,
                                blurRadius: _glowAnimation.value,
                                spreadRadius: _glowAnimation.value),
                          ],
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ),
                ),
                translateString.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleWidget(title: "متن ترجمه شده"),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            child: Text(
                              translateString,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          )
                        ],
                      )
                    : Container()
              ],
            ),
          ),
        ));
  }

  void _onEditingTextClicked() => setState(() => _editable = !_editable);

  void _onTranslateTextClicked() {
    WordSearchBloc wordSearchBloc = BlocProvider.of<WordSearchBloc>(context);
    voicedString = _textEditingController.value.text;
    List<String> split = voicedString.split(RegExp('\\s+'));
    wordSearchBloc.add(SentenceTranslateEvent(words: split));
  }

  void _onSearchClicked() async {
    if (!_recording) {
      _glowAnimationController.repeat(reverse: true);
      bool available = await _speech.initialize(
        onError: (val) => print("onError $val"),
        onStatus: (val) {
          if (val == "done" || val == "notListening") {
            setState(() {
              _recording = false;
              _glowAnimationController.reset();
            });
          }
          print("onStatus $val");
        },
      );

      if (available) {
        setState(() => _recording = true);
        _speech.listen(onResult: (val) {
          voicedString = val.recognizedWords;
          setState(() {
            _textEditingController.text = voicedString;
            if (val.hasConfidenceRating && val.confidence > 0) {
              print(val.confidence);
              print(voicedString);
            }
          });
        });
      }
    } else {
      setState(() {
        _recording = false;
        _glowAnimationController.reset();
      });
      _speech.stop();
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
