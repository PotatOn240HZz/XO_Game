import 'package:flutter/material.dart';
import 'package:untitled/pages/Home.dart';
import 'package:untitled/pages/TTT.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/TTT': (context) => const TTT(),
      },
    ));