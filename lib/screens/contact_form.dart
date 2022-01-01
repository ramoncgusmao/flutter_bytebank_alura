import 'package:bytebank2/database/app_database.dart';
import 'package:bytebank2/database/dao/contact_dao.dart';
import 'package:bytebank2/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _accountNumberController = TextEditingController();
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form('Full name',_nameController, false),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Form('Account number',_accountNumberController, true),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: () {
                        final String name = _nameController.text;
                        final int? accountNumber = int.tryParse(_accountNumberController.text);
                        debugPrint('$name - $accountNumber');
                        if(accountNumber != null){
                          final Contact contact = Contact(name, accountNumber,0);
                          _dao.save(contact).then((id) => Navigator.pop(context));

                        }

                      },
                      child: Text('Create'),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Form extends StatefulWidget {

  final String _label;
  final bool _isOnlyNumber;
  final TextEditingController _controller;
  Form(this._label,this._controller, this._isOnlyNumber);

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._controller,
      decoration: InputDecoration(
        labelText: widget._label,
      ),
      style: TextStyle(
        fontSize: 24.0
      ),
      keyboardType: widget._isOnlyNumber ? TextInputType.number : null,
    );
  }
}
