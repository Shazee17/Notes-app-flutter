import 'package:flutter/material.dart';
import 'package:notes_app_flutter/pages/splash_screen.dart';
import 'package:notes_app_flutter/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'pages/notes_page.dart';
import 'package:notes_app_flutter/models/note_database.dart';

void main() async {
  // Initialize the database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(
    MultiProvider(
      providers: [
        // Note Database Provider
        ChangeNotifierProvider(create: (context) => NoteDatabase()),

        // Theme Provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Notes App',
          home: const SplashScreen(),
          theme: themeProvider.themeData,
        );
      },
    );
  }
}
