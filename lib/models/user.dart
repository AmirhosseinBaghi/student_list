class User {
  final String name;
  final String city;
  final String id;

  User({required this.name, required this.city, required this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      city: json['city'] ?? '',
      id: json['id'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'city': city};
  }
}
