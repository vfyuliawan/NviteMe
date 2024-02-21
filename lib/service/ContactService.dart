import 'package:contacts_service/contacts_service.dart';

class ContactsHandler {
  Future<List<Contact>> getContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    return contacts.toList();
  }
}
