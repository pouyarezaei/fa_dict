part of 'database_builder_bloc.dart';

@immutable
abstract class DatabaseBuilderState {
  late bool showSplash;

  DatabaseBuilderState(this.showSplash);
}

class DatabaseBuilderInitial extends DatabaseBuilderState {
  DatabaseBuilderInitial(showSplash) : super(showSplash);
}

class DatabaseBuilderLoading extends DatabaseBuilderState {
  DatabaseBuilderLoading(showSplash) : super(showSplash);
}

class DatabaseBuilderLoaded extends DatabaseBuilderState {
  final Database database;

  DatabaseBuilderLoaded({required this.database, showSplash})
      : super(showSplash);
}
