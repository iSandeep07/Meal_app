import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/screens/tabs.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed( brightness : Brightness.dark , seedColor: Color.fromARGB(
      255, 140, 60, 2),),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main(){
  runApp(ProviderScope(child: App()));
}

class App extends StatelessWidget{
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: TabsScreen(),

    );
  }

}