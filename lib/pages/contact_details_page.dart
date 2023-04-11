import 'package:flutter/material.dart';

import '../models/contact_model.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName = '/details';

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  bool isFirst = true;
  late ContactModel contact;

  @override
  void didChangeDependencies() {
    if (isFirst) {
      contact = ModalRoute.of(context)!.settings.arguments as ContactModel;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: ListView(
        children: [
          Image.asset(
            contact.image, width: double.infinity, height: 250, fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(contact.contactName),
          ),
          ListTile(
            title: Text(contact.mobile),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.sms)),
                IconButton(onPressed: () {}, icon: Icon(Icons.call)),
              ],
            ),
          ),
          ListTile(
            title: Text(contact.email.isEmpty ? 'Not Found' : contact.email),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.email)),
          ),
          ListTile(
            title: Text(contact.address.isEmpty ? 'Not Found' : contact.email),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.map)),
          ),
          ListTile(
            title: Text(contact.website.isEmpty ? 'Not Found' : contact.email),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.web)),
          ),
        ],
      ),
    );
  }
}
