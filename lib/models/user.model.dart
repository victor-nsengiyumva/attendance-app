class User {
  final int id;
  final String firstname;
  final String lastname;
  final String PF;
  final String mobile_number;
  final String email;

  const User({
    required this.id,
    required this.lastname,
    required this.PF,
    required this.mobile_number,
    required this.email,
    required this.firstname,
  });

  /// Converts the supplied [Map] to an instance of the [User] class.
  static User fromMap(Map<dynamic, dynamic> data) {
    return User(
      id: data['id'],
      firstname: data['firstname'],
      lastname: data['lastname'],
      PF: data['PF'],
      mobile_number: data['mobile_number'],
      email: data['email'],
    );
  }

// This the default method that is called once you print an instance of an object created using this class
  @override
  String toString() {
    return PF;
  }

  /// Converts the [User] instance into a [Map] instance that can be
  /// serialized to JSON.

  Map<String, dynamic> toJson() => {};
}
