import 'package:flutter/material.dart';
import 'package:projet/drugDetailScreen.dart';
import 'package:projet/models/api_response.dart';
import 'package:projet/registerScreen.dart';
import 'package:projet/searchScreen.dart';
import 'package:projet/verifyDrugScreen.dart'; // Ajoutez l'importation ici
import 'scannerScreen.dart';
import 'adminScreen.dart';
import 'authScreen.dart';
import 'addDrugScreen.dart';
import 'deleteDrugScreen.dart';
import 'editDrugScreen.dart';
import 'loginScreen.dart';
import 'mainScreen.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAuthenticated = false;
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          labelStyle: TextStyle(color: Colors.black),
          prefixIconColor: Colors.green,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.green,
          showUnselectedLabels: true,
          showSelectedLabels: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => isAuthenticated
            ? MainScreen(isAdmin: isAdmin)
            : AuthScreen(onAuthenticated: (admin) {
          setState(() {
            isAuthenticated = true;
            isAdmin = admin;
          });
          Navigator.pushReplacementNamed(context, '/main');
        }),
        '/login': (context) => LoginScreen(onAuthenticated: (admin) {
          setState(() {
            isAuthenticated = true;
            isAdmin = admin;
          });
          Navigator.pushReplacementNamed(context, '/main');
        }),
        '/register': (context) => RegisterScreen(onAuthenticated: (admin) {
          setState(() {
            isAuthenticated = true;
            isAdmin = admin;
          });
          Navigator.pushReplacementNamed(context, '/main');
        }),
        '/main': (context) => MainScreen(isAdmin: isAdmin),
        '/search': (context) => SearchScreen(),
        '/admin': (context) => isAuthenticated && isAdmin
            ? AdminScreen()
            : AuthScreen(onAuthenticated: (admin) {
          setState(() {
            isAuthenticated = true;
            isAdmin = admin;
          });
          Navigator.pushReplacementNamed(context, '/main');
        }),
        '/addDrug': (context) => AddDrugScreen(),
        '/editDrug': (context) => EditDrugScreen(),
        '/deleteDrug': (context) => DeleteDrugScreen(),
        '/verifieDrug': (context) => VerifyDrugScreen(), // Corrigé ici
        '/drugDetailScreen': (context) => DrugDetailScreen(drugId: ''),
        '/scanner': (context) => ScannerScreen(),
      },
    );
  }
}
