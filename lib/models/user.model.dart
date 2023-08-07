class User {
  final int id;
  final String PF;
  final String email;
  final String mobile_number;
  final String location;
  final String deviceID;

  const User({
    required this.id,
    required this.PF,
    required this.email,
    required this.mobile_number,
    required this.location,
    required this.deviceID
  });

  /// Converts the supplied [Map] to an instance of the [User] class.
  static User fromMap(Map<dynamic, dynamic> data) {
    return User(
      id: data['id'],
      PF: data['PF'],
      email: data['email'],
      mobile_number: data['mobile_number'],
      location:  data['location'],
      deviceID: data['deviceID']
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
