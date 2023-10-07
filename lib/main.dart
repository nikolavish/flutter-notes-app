import 'package:flutter/material.dart';
import 'package:notesapp/screens/NoteScreen.dart';
import 'package:notesapp/screens/NotesScreen.dart';
import 'AppTheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes app',
      theme: appTheme,
      routes: {
        NotesScreen.route: (context) => const NotesScreen(),
        NoteScreen.route: (context) => const NoteScreen()
      },
      initialRoute: NotesScreen.route,
    );
  }
}
