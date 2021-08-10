import 'package:fa_dict/bloc/theme/theme_bloc.dart';
import 'package:fa_dict/ui/color_palette.dart';
import 'package:fa_dict/ui/widget/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(title: "مود"),
            ListTile(
              title: const Text('سیستم'),
              leading: Radio<ThemeMode>(
                  activeColor: ColorPalette.wildWatermelon,
                  value: ThemeMode.system,
                  groupValue: state.themeMode,
                  onChanged: _onThemeChanged),
            ),
            ListTile(
              title: const Text('تاریک'),
              leading: Radio<ThemeMode>(
                  activeColor: ColorPalette.wildWatermelon,
                  value: ThemeMode.dark,
                  groupValue: state.themeMode,
                  onChanged: _onThemeChanged),
            ),
            ListTile(
              title: const Text('روشن'),
              leading: Radio<ThemeMode>(
                  activeColor: ColorPalette.wildWatermelon,
                  value: ThemeMode.light,
                  groupValue: state.themeMode,
                  onChanged: _onThemeChanged),
            ),
          ],
        ),
      ),
    );
  }

  _onThemeChanged(ThemeMode? value) {
    BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(value));
  }
}
