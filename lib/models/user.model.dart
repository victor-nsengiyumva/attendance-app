class User {
  final String firstname;
  final String lastname;
  final String PF;
  final String mobile_number;
  final String email;

  const User({
    required this.lastname,
    required this.PF,
    required this.mobile_number,
    required this.email,
    required this.firstname,
  });

  static User fromMap(Map<dynamic, dynamic> data) {
    return User(
      firstname: data['firstname'] ,
      lastname: data['lastname'],
      PF: data['PF'],
      mobile_number: data['mobile_number'],
      email: data['email'],

    );
  }


  @override
  String toString() {
    return PF;
  }


/// Converts the [User] instance into a [Map] instance that can be
  /// serialized to JSON.

   Map<String, dynamic> toJson() => {
        
      };
}
