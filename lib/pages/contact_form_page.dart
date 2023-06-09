import 'package:contact_app/db/dbhelper.dart';
import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/pages/contact_home_page.dart';
import 'package:contact_app/providers/contact_provider.dart';
import 'package:contact_app/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  late ContactModel contact;

  @override
  void didChangeDependencies() {
    contact = ModalRoute.of(context)!.settings.arguments as ContactModel;
    nameController.text = contact.contactName;
    mobileController.text = contact.mobile;
    emailController.text = contact.email;
    designationController.text = contact.designation;
    companyController.text = contact.company;
    webController.text = contact.website;
    addressController.text = contact.address;
    super.didChangeDependencies();
  }

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
        title: Text('New Contact'),
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
                labelText: 'Designation',
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
      contact.contactName = nameController.text;
      contact.mobile = mobileController.text;
      contact.email = emailController.text;
      contact.designation = designationController.text;
      contact.company = companyController.text;
      contact.website = webController.text;
      contact.address = addressController.text;
      // final contact = ContactModel(
      //   contactName: nameController.text,
      //   mobile: mobileController.text,
      //   address: addressController.text,
      //   company: companyController.text,
      //   designation: designationController.text,
      //   website: webController.text,
      //   email: emailController.text,
      // );
      Provider.of<ContactProvider>(context, listen: false)
          .insert(contact)
          .then((newRowId) {
        if (newRowId > 0) {
          showMsg(context, 'Saved');
          contact.id = newRowId;
          Navigator.popUntil(
              context, ModalRoute.withName(ContactHomePage.routeName));
        }
      }).catchError((error) {
        print(error.toString());
        showMsg(context, 'Failed to save');
      });
    }
  }
}
