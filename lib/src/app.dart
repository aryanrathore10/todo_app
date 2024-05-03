import 'package:flutter/material.dart';
import 'package:todo_app/src/screens/add_task_screen.dart';
import 'package:todo_app/src/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo',
      initialRoute: '/',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.green.shade400,
          onPrimary: Colors.white,
          secondary: Colors.grey.shade400,
          onSecondary: Colors.black,
          error: Colors.red.shade400,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
          background: Colors.grey.shade100,
          onBackground: Colors.black
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade400,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
            )
          )
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none
          )
        )
      ),
      routes: {
        '/': (context) => const HomeScreen(),
        'add/':(context) => const AddTaskScreen()
      },
    );
  }
}
