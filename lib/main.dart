import 'package:fa_dict/bloc/database_builder/database_builder_bloc.dart';
import 'package:fa_dict/ui/color_palette.dart';
import 'package:fa_dict/ui/page/entry_point_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: ColorPalette.wildWatermelon, fontFamily: 'IranSans'),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<DatabaseBuilderBloc>(
            create: (_) => DatabaseBuilderBloc(),
          ),
        ],
        child: Directionality(
            textDirection: TextDirection.rtl, child: EntryPointWidget()),
      ),
    );
  }
}
