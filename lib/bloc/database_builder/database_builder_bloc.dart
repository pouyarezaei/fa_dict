import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fa_dict/data/database_builder.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'database_builder_event.dart';

part 'database_builder_state.dart';

class DatabaseBuilderBloc
    extends Bloc<DatabaseBuilderEvent, DatabaseBuilderState> {
  DatabaseBuilderBloc() : super(DatabaseBuilderInitial(true));

  DatabaseBuilderState get initialState => DatabaseBuilderInitial(true);

  @override
  Stream<DatabaseBuilderState> mapEventToState(
    DatabaseBuilderEvent event,
  ) async* {
    if (event == DatabaseBuilderEvent.COPYING) {
      yield DatabaseBuilderLoading(true);

      var databaseBuilderLoaded = DatabaseBuilderLoaded(
          database: await DatabaseBuilder.initializeDatabase(),
          showSplash: false);

      await Future.delayed(Duration(seconds: 3));
      yield databaseBuilderLoaded;
    }
  }
}
