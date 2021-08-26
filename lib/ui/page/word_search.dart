import 'package:fa_dict/bloc/wordsearch/word_search_bloc.dart';
import 'package:fa_dict/data/entity/word_entity.dart';
import 'package:fa_dict/ui/widget/language_switch_widget.dart';
import 'package:fa_dict/ui/widget/list_item.dart';
import 'package:fa_dict/ui/widget/search_box_widget.dart';
import 'package:fa_dict/ui/widget/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class WordSearch extends StatefulWidget {
  const WordSearch({Key? key}) : super(key: key);

  @override
  _WordSearchState createState() => _WordSearchState();
}

class _WordSearchState extends State<WordSearch> {
  int _valueTo = 2;
  int _valueFrom = 1;
  TextDirection _textDirection = TextDirection.ltr;
  final TextEditingController _textFieldController = TextEditingController();
  bool search = false;
  late List<WordEntity> wordResult = [];
  late PublishSubject<String> subject;

  @override
  void initState() {
    super.initState();
    WordSearchBloc wordSearchBloc = BlocProvider.of<WordSearchBloc>(context);

    subject = new PublishSubject<String>();
    subject.stream
        .debounceTime(Duration(milliseconds: 500))
        .where((value) => value.toString().length > 2)
        .distinct()
        .listen((query) {
      wordSearchBloc.add(WordLikeSearchEvent(
          word: query,
          wordColumn: (_valueFrom == 1)
              ? WordEntity.EnglishWordColumn
              : WordEntity.PersianWordColumn));
    });
  }

  @override
  void dispose() {
    super.dispose();
    subject.close();
  }

  @override
  Widget build(BuildContext context) {
    WordSearchBloc wordSearchBloc = BlocProvider.of<WordSearchBloc>(context);

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: BlocListener<WordSearchBloc, WordSearchState>(
          listener: (context, state) {
            if (state is WordSearchResultState) {
              setState(() {
                wordResult = state.searchResult;
                search = true;
              });
            }
            if (state is HistorySearchResultState) {
              setState(() {
                wordResult = state.searchResult;
                search = false;
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
              TitleWidget(title: "ترجمه لغت"),
              SearchBox(
                textDirection: _textDirection,
                textFieldcontroller: _textFieldController,
                onSearchClicked: _onSearchClicked,
                onChange: _onSearchChanged,
              ),
              search
                  ? TitleWidget(title: "نتایج جستجو")
                  : TitleWidget(title: "اخیرا ترجمه شده"),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: wordResult.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimatedOpacity(
                    opacity: 1,
                    duration: const Duration(milliseconds: 500),
                    child: ListItem(wordEntity: wordResult[index]),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _onSearchChanged(String query) {
    WordSearchBloc wordSearchBloc = BlocProvider.of<WordSearchBloc>(context);
    if (query.isEmpty) {
      wordSearchBloc.add(HistoryWordEvent());
      print("HistoryWordEvent added");
    } else {
      subject.add(query);
    }
  }

  void _onSearchClicked() {}

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
