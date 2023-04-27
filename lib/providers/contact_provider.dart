import 'package:contact_app/db/dbhelper.dart';
import 'package:flutter/cupertino.dart';

import '../models/contact_model.dart';

class ContactProvider extends ChangeNotifier {
  final DbHelper helper = DbHelper();
  List<ContactModel> contactList = [];

  Future<int> insert(ContactModel contactModel) async {
    final rowId = await helper.insert(contactModel);
    contactModel.id = rowId;
    contactList.add(contactModel);
    notifyListeners();
    return rowId;
  }

  Future<void> getAllContacts() async {
    contactList = await helper.getAllContacts();
    notifyListeners();
  }

  Future<void> getAllFavoriteContacts() async {
    contactList = await helper.getAllFavoriteContacts();
    notifyListeners();
  }

  Future<void> updateContactField(ContactModel contactModel, int value) async{
    await helper.updateContactField(contactModel.id, {tblContactColFavorite : value});
    final index = contactList.indexOf(contactModel);
    contactList[index].favorite =! contactList[index].favorite;
    notifyListeners();
  }
  Future<void> deleteContact(int id) async{
    await helper.deleteContact(id);
  }
}
