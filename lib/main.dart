import 'package:blox/data/di/di.dart';
import 'package:blox/view/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() => initApp();

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Di.setupLocator();
  const Application application = Application();
  runApp(application);
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen()
    );
  }
}
