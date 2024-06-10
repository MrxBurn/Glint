enum EGender { MALE, FEMALE, OTHER }

enum ELookingFor { RELATIONSHIP, SOMETHING_CASUAL, DONT_KNOW_YET }

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  DateTime? dob;
  int? height;
  EGender? gender;
  EGender? interestIn;
  String? hobbies;
  ELookingFor? lookingFor;
}
