import 'package:contact_app/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DbHelper {
  final String _createTableContact = '''create table $tableContact(
  $tblContactColId integer primary key autoincrement,
  $tblContactColName text,
  $tblContactColMobile text,    
  $tblContactColeEmail text,
  $tblContactColAddress text,
  $tblContactColCompany text,
  $tblContactColDesignation text,
  $tblContactColWebsite text,
  $tblContactColFavorite integer,
  $tblContactColImage text)''';

  Future<Database> _open() async {
    final root = await getDatabasesPath();
    final dbPath = p.join(root, 'contact.db');

    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(_createTableContact);
      },
    );
  }

  Future<int> insert(ContactModel contactModel) async {
    final db = await _open();
    return db.insert(tableContact, contactModel.toMap());
  }

  Future<List<ContactModel>> getAllContacts() async {
    final db = await _open();
    final mapList = await db.query(tableContact);
    return List.generate(
        mapList.length, (index) => ContactModel.formMap(mapList[index]));
  }

  Future<List<ContactModel>> getAllFavoriteContacts() async {
    final db = await _open();
    final mapList = await db.query(tableContact, where: '$tblContactColFavorite = ?', whereArgs: [1]);
    return List.generate(
        mapList.length, (index) => ContactModel.formMap(mapList[index]));
  }

  Future<ContactModel> getContactById(int id) async {
    final db = await _open();
    final mapList = await db.query(tableContact,
        where: '$tblContactColId = ? and $tblContactColCompany = ?',
        whereArgs: [id]);
    return ContactModel.formMap(mapList.first);
  }

  Future<int> updateContactField(int id, Map<String, dynamic> map) async {
    final db = await _open();
    final update = db.update(tableContact, map,
        where: '$tblContactColId = ?', whereArgs: [id]);
    return update;
  }
}
