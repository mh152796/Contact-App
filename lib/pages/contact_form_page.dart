import 'package:contact_app/db/dbhelper.dart';
import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import '../db/temp_db.dart';

class ContactFormPage extends StatefulWidget {
  static const String routeName = '/contact_form';

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final designationController = TextEditingController();
  final companyController = TextEditingController();
  final webController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    designationController.dispose();
    companyController.dispose();
    webController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Form'),
        actions: [
          IconButton(
            onPressed: _saveContact,
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Your Name(required)',
                filled: true,
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                if (value.length > 20) {
                  return 'Name is too long(max 20)';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Mobile(required)',
                filled: true,
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Mobile is required';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Street Address',
                filled: true,
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: companyController,
              decoration: InputDecoration(
                labelText: 'Company Name',
                filled: true,
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: webController,
              decoration: InputDecoration(
                labelText: 'Website',
                filled: true,
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: designationController,
              decoration: InputDecoration(
                labelText: 'Designature',
                filled: true,
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  _saveContact() {
    if (formKey.currentState!.validate()) {
      final contact = ContactModel(
        contactName: nameController.text,
        mobile: mobileController.text,
        address: addressController.text,
        company: companyController.text,
        designation: designationController.text,
        website: webController.text,
        email: emailController.text,
      );
      //contactList.add(contact);
      DbHelper().insert(contact).then((newRowId){
        if(newRowId > 0)
          {
            showMsg(context, 'Saved');
            contact.id = newRowId;
            Navigator.pop(context, contact);

          }
      }).catchError((onError){
        showMsg(context, 'Failed to save');
        print(onError);
      });
    }
  }
}
