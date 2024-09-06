import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_ecommerce/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;


  //constructor for usermodel
  UserModel({
  required this.id, 
  required this.username, 
  required this.email,
  required this.firstName,
  required this.lastName,
  required this.phoneNumber,
  required this.profilePicture});

  //Helper Functions to get the full name
  String get fullName => '$firstName $lastName';

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  //static function to split full name into first and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

  //Static functio to generate a username from full anem
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername";
    return usernameWithPrefix;
  }


  //Static function to create an empty user model
  static UserModel empty() => UserModel(id: '', username: '', email: '', firstName: '', lastName: '', phoneNumber: '', profilePicture: '');

  // Convert model to Json structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName' : firstName,
      'LastName' : lastName,
      'Username' : username,
      'Email' : email,
      'PhonNumber' : phoneNumber,
      'ProfilePictute' : profilePicture,
    };
  }


  //Factory Method to create a userModel from a firebase document snapshot
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
  if (document.data() != null) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      username: data['UserName'] ?? '',
      email: data['Email'] ?? '',
      firstName: data['FirstName'] ?? '',
      lastName: data['LastName'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      profilePicture: data['ProfilePicture'] ?? '',
    );
  } 
  return UserModel.empty();
    // Option 2: Throw an exception to signal missing data (if preferred)
    // throw Exception('Document data is missing for UserModel creation.');
  
}
}