import 'package:fa_dict/bloc/theme/theme_bloc.dart';
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
        builder: (context, state) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(title: "مود"),
              ListTile(
                title: Text(
                  'سیستم',
                  style: Theme.of(context).textTheme.headline5,
                ),
                leading: Radio<ThemeMode>(
                    activeColor: Theme.of(context).primaryColor,
                    value: ThemeMode.system,
                    groupValue: state.themeMode,
                    onChanged: _onThemeChanged),
              ),
              ListTile(
                title: Text(
                  'تاریک',
                  style: Theme.of(context).textTheme.headline5,
                ),
                leading: Radio<ThemeMode>(
                    activeColor: Theme.of(context).primaryColor,
                    value: ThemeMode.dark,
                    groupValue: state.themeMode,
                    onChanged: _onThemeChanged),
              ),
              ListTile(
                title: Text(
                  'روشن',
                  style: Theme.of(context).textTheme.headline5,
                ),
                leading: Radio<ThemeMode>(
                    activeColor: Theme.of(context).primaryColor,
                    value: ThemeMode.light,
                    groupValue: state.themeMode,
                    onChanged: _onThemeChanged),
              ),
              Divider(),
              TitleWidget(title: "درباره برنامه"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                child: Text(
                  "این برنامه توسط پویا رضایی زیر نظر مهندس فرشادی از شرکت فناوری برتر تندرستی جهت گزراندن دوره کاراموزی در دوره کرونا توسعه داده شده است",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              TitleWidget(title: "قابلیت های برنامه"),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ListTile(
                      title: Text(
                        "ترجمه کلمه",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    ListTile(
                      subtitle: Text(
                        "کلمه به کلمه",
                        style: TextStyle(fontSize: 12),
                      ),
                      title: Text(
                        "ترجمه جمله",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "تبدیل صدا به متن",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "ذخیره کلمات مورد علاقه",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "ذخیره تاریخچه کلمات",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    ListTile(
                      subtitle: Text(
                        "با قابلیت ذخیره سازی",
                        style: TextStyle(fontSize: 12),
                      ),
                      title: Text(
                        "داشتن چند تم",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "واکنش گرا",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onThemeChanged(ThemeMode? value) {
    BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(value));
  }
}
