import 'package:fa_dict/bloc/database_builder/database_builder_bloc.dart';
import 'package:fa_dict/bloc/theme/theme_bloc.dart';
import 'package:fa_dict/bloc/wordsearch/word_search_bloc.dart';
import 'package:fa_dict/ui/app_theme.dart';
import 'package:fa_dict/ui/page/entry_point_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int themeIndex = prefs.getInt(AppTheme.themeKey) ?? 0;
  runApp(BlocProvider(
    create: (_) => ThemeBloc(ThemeMode.values[themeIndex]),
    child: App(),
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DatabaseBuilderBloc>(
          create: (_) => DatabaseBuilderBloc(),
        ),
        BlocProvider<WordSearchBloc>(
          create: (_) => WordSearchBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) => MaterialApp(
                debugShowCheckedModeBanner: false,
                themeMode: state.themeMode,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                home: Directionality(
                    textDirection: TextDirection.rtl,
                    child: EntryPointWidget()),
              )),
    );
  }
}
