class MyUser {
  static String collectionName = 'users';

  String? id;

  String? name;
  String? email;

  MyUser({required this.id, required this.name, required this.email});

  Map<String, dynamic> toFireStore() {
    return {'ID': id, 'Name': name, 'Email': email};
  }

  MyUser.fromFireStore(Map<String, dynamic>? data)
      : this(
            id: data?['ID'] as String?,
            name: data?['Name'] as String?,
            email: data?['Email'] as String?);
}
