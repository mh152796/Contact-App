import 'package:contact_app/pages/contact_details_page.dart';
import 'package:flutter/material.dart';

import 'pages/contact_form_page.dart';
import 'pages/contact_home_page.dart';

void main() {

  runApp(MyApp());
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
        ContactHomePage.routeName : (context) => ContactHomePage(),
        ContactDetailsPage.routeName : (context) => ContactDetailsPage(),
        ContactFormPage.routeName : (context) => ContactFormPage(),
      },
    );
  }
}
