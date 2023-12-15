import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:todo_placeholder/Providers/task_povider.dart';
import 'package:todo_placeholder/Screens/add_task_screen.dart';
import 'package:todo_placeholder/Screens/todo_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const Center(
          child: CircularProgressIndicator(),
        ),
        overlayOpacity: 0.2,
        overlayColor: Colors.transparent,
        overlayWholeScreen: false,
        child: MaterialApp(
          theme: ThemeData(
            primaryColor: const Color.fromRGBO(43, 123, 144, 1),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.white, fontSize: 15),
              bodyLarge: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              bodySmall: TextStyle(
                  color: Color.fromRGBO(199, 158, 0, 1), fontSize: 13),
            ),
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black, foregroundColor: Colors.white),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: const Color.fromRGBO(43, 123, 144, 1),
              onPrimary: const Color.fromRGBO(40, 94, 165, 1),
              secondary: const Color.fromRGBO(199, 158, 0, 1),
            ),
          ),
          title: 'Todo Placeholder',
          initialRoute: '/',
          routes: {
            '/': (context) => const TodoList(),
            '/add': (context) => AddTask(),
          },
        ),
      ),
    );
  }
}
