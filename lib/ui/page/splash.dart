import 'package:fa_dict/bloc/database_builder/database_builder_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreenWidget extends StatefulWidget {
  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  @override
  void initState() {
    super.initState();
    this._dispatchEvent(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/square_splash.jpg'),
          Column(
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
                strokeWidth: 2,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "در حال بارگیری ...",
                style: TextStyle(fontSize: 18, fontFamily: 'IranSans'),
              )
            ],
          )
        ],
      ),
    );
  }

  //This method will dispatch the navigateToHomeScreen event.
  void _dispatchEvent(BuildContext context) {
    BlocProvider.of<DatabaseBuilderBloc>(context)
        .add(DatabaseBuilderEvent.COPYING);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
