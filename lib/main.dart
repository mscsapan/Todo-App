import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/controller.dart';

import 'screens/home.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChangeNotifierProvider<StateController>(
          create: (_) => StateController(),
          child: const Home(),
        ),
      ),
    );
