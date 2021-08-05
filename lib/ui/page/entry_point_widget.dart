import 'package:animations/animations.dart';
import 'package:fa_dict/bloc/database_builder/database_builder_bloc.dart';
import 'package:fa_dict/ui/color_palette.dart';
import 'package:fa_dict/ui/page/favorite.dart';
import 'package:fa_dict/ui/page/setting.dart';
import 'package:fa_dict/ui/page/splash.dart';
import 'package:fa_dict/ui/page/voice_search.dart';
import 'package:fa_dict/ui/page/word_search.dart';
import 'package:fa_dict/ui/widget/fade_tween_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntryPointWidget extends StatefulWidget {
  const EntryPointWidget({Key? key}) : super(key: key);

  @override
  _EntryPointWidgetState createState() => _EntryPointWidgetState();
}

class _EntryPointWidgetState extends State<EntryPointWidget> {
  int _selectedIndex = 0;
  final List<Widget> _pages = List.unmodifiable(
      [WordSearch(), VoiceSearch(), FavoriteWords(), Setting()]);
  final List<BottomNavigationBarItem> _items = List.unmodifiable([
    BottomNavigationBarItem(icon: Icon(Icons.search), label: "ترجمه لغت"),
    BottomNavigationBarItem(icon: Icon(Icons.mic), label: "ترجمه صوتی"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "برگزیده ها"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "تنظیمات"),
  ]);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatabaseBuilderBloc, DatabaseBuilderState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: state.showSplash
                ? FadeTopDown(child: SplashScreenWidget())
                : PageTransitionSwitcher(
                    transitionBuilder: (Widget child,
                        Animation<double> primaryAnimation,
                        Animation<double> secondaryAnimation) {
                      return FadeThroughTransition(
                        animation: primaryAnimation,
                        secondaryAnimation: secondaryAnimation,
                        child: child,
                      );
                    },
                    child: _pages[_selectedIndex]),
          ),
          bottomNavigationBar: state.showSplash
              ? null
              : BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  selectedItemColor: ColorPalette.wildWatermelon,
                  onTap: _onItemTapped,
                  unselectedItemColor: ColorPalette.bilobaFlower,
                  items: _items),
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
