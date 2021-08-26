import 'package:fa_dict/bloc/wordsearch/word_search_bloc.dart';
import 'package:fa_dict/ui/widget/list_item.dart';
import 'package:fa_dict/ui/widget/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteWords extends StatefulWidget {
  const FavoriteWords({Key? key}) : super(key: key);

  @override
  _FavoriteWordsState createState() => _FavoriteWordsState();
}

class _FavoriteWordsState extends State<FavoriteWords> {

  @override
  void initState() {
    WordSearchBloc wordSearchBloc = BlocProvider.of<WordSearchBloc>(context);
    wordSearchBloc.add(FavoriteWordEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(title: "برگزیده ها"),
          BlocBuilder<WordSearchBloc, WordSearchState>(
            builder: (BuildContext context, WordSearchState state) {
              if (state is EmptyWordSearchState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              }
              if (state is WordSearchResultState) {
                return state.searchResult.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.searchResult.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListItem(
                            wordEntity: state.searchResult[index],
                          );
                        },
                      )
                    : Center(
                        child: Text(
                        "داده ایی برای نمایش وجود ندارد.",
                        style: Theme.of(context).textTheme.bodyText2,
                      ));
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
