import 'package:fa_dict/bloc/wordsearch/word_search_bloc.dart';
import 'package:fa_dict/data/entity/word_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListItem extends StatelessWidget {
  final WordEntity wordEntity;

  const ListItem({Key? key, required this.wordEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        title: Text(
          wordEntity.persianWord,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        leading: IconButton(
          onPressed: () => _onFavButtonClicked(context),
          icon: Icon(
            wordEntity.isFav == 1 ? Icons.favorite : Icons.favorite_border,
            color: Theme.of(context).primaryColor,
          ),
        ),
        trailing: Text(
          wordEntity.englishWord,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }

  void _onFavButtonClicked(BuildContext context) {
    WordSearchBloc wordSearchBloc = BlocProvider.of<WordSearchBloc>(context);
    if (wordEntity.isFav == 1)
      wordSearchBloc.add(RemoveFavoriteWordEvent(word: wordEntity.englishWord));
    if (wordEntity.isFav == 0)
      wordSearchBloc.add(AddFavoriteWordEvent(word: wordEntity.englishWord));
  }
}
