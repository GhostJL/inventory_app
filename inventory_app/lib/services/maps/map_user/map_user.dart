class UserItem {
  final String name;
  final String password;

  UserItem({
    required this.name,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'password': password,
    };
  }
}
