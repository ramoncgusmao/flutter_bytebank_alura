import 'package:bytebank2/database/app_database.dart';
import 'package:bytebank2/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {

  static const String tableSql = 'CREATE TABLE $_tableName('
      ' id INTEGER PRIMARY KEY, '
      'name TEXT, '
      'account_number INTEGER)';
  static const String _tableName = 'contacts';

  Future<int> save(Contact contact) async{
    final Database db = await createDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_tableName, contactMap);

    /* return createDatabase().then((db) {
    final Map<String, dynamic> contactMap = Map();
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;

    return db.insert('contacts', contactMap);
  });

  */
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = {};
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async{
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contact> contacts = _toList(result);
    return contacts;

    /* return createDatabase().then((db) {
    return db.query('contacts').then((maps) {
     final List<Contact> contacts = [];
     for(Map<String, dynamic> map in maps){
       final Contact contact = Contact(map['name'], map['account_number'], map['id']);
        contacts.add(contact);
     }
     return contacts;
    });
  });

  */
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
     final List<Contact> contacts = [];
    for(Map<String, dynamic> map in result){
      final Contact contact = Contact(map['name'], map['account_number'], map['id']);
      contacts.add(contact);
    }
    return contacts;
  }
}