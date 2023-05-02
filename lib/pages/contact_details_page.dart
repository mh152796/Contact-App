import 'dart:io';

import 'package:contact_app/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
          Image.file(File(contact.image), width: double.infinity, height: 250, fit: BoxFit.cover,),
          // Image.asset(
          //   contact.image, width: double.infinity, height: 250, fit: BoxFit.cover,
          // ),
          ListTile(
            title: Text(contact.contactName),
          ),
          ListTile(
            title: Text(contact.mobile),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: _smsContact, icon: Icon(Icons.sms)),
                IconButton(onPressed: _callContact, icon: Icon(Icons.call)),
              ],
            ),
          ),
          ListTile(
            title: Text(contact.email.isEmpty ? 'Not Found' : contact.email),
            trailing: IconButton(onPressed: _emailContact, icon: Icon(Icons.email)),
          ),
          ListTile(
            title: Text(contact.address.isEmpty ? 'Not Found' : contact.address),
            trailing: IconButton(onPressed: _openMap, icon: Icon(Icons.map)),
          ),
          ListTile(
            title: Text(contact.website.isEmpty ? 'Not Found' : contact.website),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.web)),
          ),
        ],
      ),
    );
  }

  void _callContact() async{
    final url = 'tel:${contact.mobile}';
    if(await canLaunchUrlString(url)){

      await launchUrlString(url);
    }
    else{
      showMsg(context, 'Cannot perform this operation');
    }
  }

  void _smsContact() async{
    final url = 'sms:${contact.mobile}';

    if(await canLaunchUrlString(url)){

    await launchUrlString(url);
    }
    else{
    showMsg(context, 'Cannot perform this operation');
    }
  }

  void _emailContact() async{
    if(contact.email.isEmpty) return;

    final url = 'mailto:${contact.email}';

    if(await canLaunchUrlString(url)){

      await launchUrlString(url);
    }
    else{
      showMsg(context, 'Cannot perform this operation');
    }

  }

  void _openMap() async {
    var url = '';
    if(Platform.isAndroid){
 url = 'geo:0,0?q=${contact.address}';
    }
    else if(Platform.isIOS){
      url = 'http://maps.apple.com/?q=${contact.address}';
    }

    if(await canLaunchUrlString(url)){

      await launchUrlString(url);
    }
    else{
      showMsg(context, 'Cannot perform this operation');
    }


  }
}
