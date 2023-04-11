import 'package:contact_app/db/dbhelper.dart';
import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/pages/contact_details_page.dart';
import 'package:contact_app/pages/contact_form_page.dart';
import 'package:flutter/material.dart';
import '../db/temp_db.dart';

class ContactHomePage extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<ContactHomePage> createState() => _ContactHomePageState();
}

class _ContactHomePageState extends State<ContactHomePage> {
  List<ContactModel> contactList = [];
  late DbHelper dbHelper;
  int selectedIndex = 0;

  @override
  void initState() {
    _getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });

            _getContacts();
          },
          currentIndex: selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          backgroundColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'All',),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites',),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          final contact = contactList[index];

          return ListTile(
              onTap: () {
                Navigator.pushNamed(context, ContactDetailsPage.routeName,
                    arguments: contact);
              },
              title: Text(contact.contactName),
              trailing: IconButton(
                onPressed: () {

                  final value = contact.favorite ? 0 : 1;
                  dbHelper.updateContactField(contact.id, {tblContactColFavorite: value}).then((value)
                  {
                    setState(() {
                      contact.favorite = !contact.favorite;
                      _getContacts();
                    });
                  });


                },
                icon: Icon(
                    contact.favorite ? Icons.favorite : Icons.favorite_border),
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
         final contact = await Navigator.pushNamed(context, ContactFormPage.routeName);
          setState(() {
            if(contact != null){
          contactList.add(contact as ContactModel);
            }
          });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _getContacts() {
    if(selectedIndex==0){
      dbHelper = DbHelper();
      dbHelper.getAllContacts().then((value) {
        setState(() {
          contactList = value;
        });
      });
    }
    else{
      dbHelper = DbHelper();
      dbHelper.getAllFavoriteContacts().then((value) {
        setState(() {
          contactList = value;
        });
      });
    }
  }
}
