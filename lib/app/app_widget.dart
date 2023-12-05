import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'VR Software',
      theme: ThemeData(useMaterial3: true),
      routerConfig: Modular.routerConfig,
      // routerDelegate: Modular.routerDelegate,
      // routeInformationParser: Modular.routeInformationParser,
    );
  }
}
