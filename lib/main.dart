import 'package:fennec_desktop/models/squad_notifier.dart';
import 'package:fennec_desktop/pages/login/login_page.dart';
import 'package:fennec_desktop/pages/main_page.dart';
import 'package:fennec_desktop/pages/menu/workspace/workspace_screen.dart';
import 'package:fennec_desktop/utils/global_variables.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
var name;
var tell;

void main() async {
  prefs = await SharedPreferences.getInstance();
  name = prefs.getString('name');
  tell = prefs.getString('phone');
  getTeam();

  runApp(
    ChangeNotifierProvider(
      create: (context) => SquadNotifier(false),
      child: const MyApp(),
    ),
  );
}

// não mostra o scrollBar na aplicação inteira
class NoThumbScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      ),
      initialRoute: tell == null ? '/loginPage' : '/mainPage',
      routes: {
        '/workspace': (context) => const WorkspaceScreen(),
        '/loginPage': (context) => const LoginPage(),
        '/mainPage': (context) => const MainPage(),
      },
    );
  }
}
