class UserClass {
  final String id;
  final String gender;
  final List<String> hobbies;
  final String interestIn;
  final String lookingFor;
  final String dob;
  final int height;
  final int minAge;
  final int maxAge;

  UserClass({
    required this.id,
    required this.minAge,
    required this.maxAge,
    required this.gender,
    required this.hobbies,
    required this.interestIn,
    required this.lookingFor,
    required this.dob,
    required this.height,
  });

  factory UserClass.fromMap(Map<String, dynamic> data) {
    return UserClass(
      id: data['id'],
      gender: data['gender'] as String,
      hobbies: List<String>.from(data['hobbies']),
      interestIn: data['interest_in'] as String,
      lookingFor: data['looking_for'] as String,
      dob: data['dob'] as String,
      height: data['height'],
      minAge: data['min_age'],
      maxAge: data['max_age'],
    );
  }
  factory UserClass.defaultUser(Map<String, dynamic> data) {
    return UserClass(
      id: '0',
      gender: 'Male',
      hobbies: [],
      interestIn: '',
      lookingFor: '',
      dob: '',
      height: 0,
      minAge: 0,
      maxAge: 0,
    );
  }
}
