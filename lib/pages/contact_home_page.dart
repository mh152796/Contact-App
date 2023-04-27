import 'package:contact_app/db/dbhelper.dart';
import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/pages/contact_details_page.dart';
import 'package:contact_app/pages/contact_form_page.dart';
import 'package:contact_app/providers/contact_provider.dart';
import 'package:contact_app/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../db/temp_db.dart';

class ContactHomePage extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<ContactHomePage> createState() => _ContactHomePageState();
}

class _ContactHomePageState extends State<ContactHomePage> {
  int selectedIndex = 0;
  bool isFirst = true;

  @override
  void didChangeDependencies() {
    if (isFirst) {
      Provider.of<ContactProvider>(context, listen: false).getAllContacts();
    }
    isFirst = false;
    super.didChangeDependencies();
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
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'All',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
        ),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.contactList.length,
          itemBuilder: (context, index) {
            final contact = provider.contactList[index];

            return Dismissible(
              key: UniqueKey(),
              background: Container(
                padding: EdgeInsets.only(right: 20),
                color: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                alignment: Alignment.centerRight,
              ),
              onDismissed: (_) async{
                await provider.deleteContact(contact.id);
                showMsg(context, 'Deleted');
              },
              confirmDismiss: showConfirmationDialog,
              direction: DismissDirection.endToStart,
              child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, ContactDetailsPage.routeName,
                        arguments: contact);
                  },
                  title: Text(contact.contactName),
                  trailing: IconButton(
                    onPressed: () {
                      final value = contact.favorite ? 0 : 1;
                      provider.updateContactField(
                          contact, value);
                    },
                    icon: Icon(contact.favorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                  )),
            );
          },
        ),
      ),
      floatingActionButton: Consumer<ContactProvider>(
        builder: (context, provider, child) => FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, ContactFormPage.routeName);
          },
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _getContacts() {
    if (selectedIndex == 0) {
      Provider.of<ContactProvider>(context, listen: false).getAllContacts();
    } else {
      Provider.of<ContactProvider>(context, listen: false)
          .getAllFavoriteContacts();
    }
  }

  Future<bool?> showConfirmationDialog(DismissDirection direction) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Contact"),
          content: Text("Are you sure to delete this Contact"),
          actions: [
            OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text("No")),
            OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text("Yes")),
          ],
        );
      },
    );
  }
}
