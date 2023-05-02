import 'package:contact_app/pages/contact_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/contact_form_page.dart';
import 'pages/contact_home_page.dart';
import 'pages/scan_page.dart';
import 'providers/contact_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ContactProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ContactHomePage.routeName,
      routes: {
        ContactHomePage.routeName: (context) => ContactHomePage(),
        ContactDetailsPage.routeName: (context) => ContactDetailsPage(),
        ContactFormPage.routeName: (context) => ContactFormPage(),
        ScanPage.routeName : (context) => ScanPage(),
      },
    );
  }
}
