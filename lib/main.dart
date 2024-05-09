import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_movie_list/routes/routes.dart';

void main() {
  runApp(RecSysApp());
}

class RecSysApp extends StatelessWidget {
  RecSysApp({Key? key}) : super(key: key);
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp.router(
      title: 'Flutter RecSys Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerDelegate: _router.delegate(),
      routeInformationParser: _router.defaultRouteParser(),
    );
  }
}
