class Contact {
  final String name;
  final int accountNumber;

  final int id;

  Contact(this.name, this.accountNumber,this.id);

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, accountNumber: $accountNumber}';
  }
}