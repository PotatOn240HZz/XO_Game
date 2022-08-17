import 'package:flutter/material.dart';
import 'package:untitled/pages/Home.dart';
import 'package:untitled/pages/TTT.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        Map arguments = {};
        if (settings.arguments != null) {
          arguments = settings.arguments as Map;
        }
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const Home());
          case '/TTT':
            return MaterialPageRoute(
              builder: (_) => TTT(
                isAI: arguments['isAI'],
              ),
            );
        }
        return null;
      },
    ));
