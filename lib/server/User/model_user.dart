class User {
  int uID;
  String uName;
  String uEmail;
  String uImage;
  String uUsername;
  String uPassword;
  String uLocation;
  int uStatus;
  int uUserTell;
  int uShowTell;
  int uClass;
  String uTime;

  User({
    required this.uID,
    required this.uName,
    required this.uEmail,
    required this.uImage,
    required this.uUsername,
    required this.uPassword,
    required this.uLocation,
    required this.uStatus,
    required this.uUserTell,
    required this.uShowTell,
    required this.uClass,
    required this.uTime,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uID: json['U_ID'],
      uName: json['U_Name'],
      uEmail: json['U_Email'],
      uImage: json['U_Image'],
      uUsername: json['U_Username'],
      uPassword: json['U_Password'],
      uLocation: json['U_Location'],
      uStatus: json['U_Status'],
      uUserTell: json['U_User_Tell'],
      uShowTell: json['U_Show_Tell'],
      uClass: json['U_Class'],
      uTime: (json['U_Time']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['U_ID'] = uID;
    data['U_Name'] = uName;
    data['U_Email'] = uEmail;
    data['U_Image'] = uImage;
    data['U_Username'] = uUsername;
    data['U_Password'] = uPassword;
    data['U_Location'] = uLocation;
    data['U_Status'] = uStatus;
    data['U_User_Tell'] = uUserTell;
    data['U_Show_Tell'] = uShowTell;
    data['U_Class'] = uClass;
    data['U_Time'] = uTime;
    return data;
  }
}

class UsersAdd {
  final String uName;
  final String uEmail;
  final String uImage;
  final String uUsername;
  final String uPassword;
  final String uLocation;
  final String uStatus;
  final String uUserTell;
  final String uShowTell;
  final String uClass;

  UsersAdd({
    required this.uName,
    required this.uEmail,
    required this.uImage,
    required this.uUsername,
    required this.uPassword,
    required this.uLocation,
    required this.uStatus,
    required this.uUserTell,
    required this.uShowTell,
    required this.uClass,
  });

  factory UsersAdd.fromJson(Map<String, dynamic> json) {
    return UsersAdd(
      uName: json['U_Name'] as String,
      uEmail: json['U_Email'] as String,
      uImage: json['U_Image'] as String,
      uUsername: json['U_Username'] as String,
      uPassword: json['U_Password'] as String,
      uLocation: json['U_Location'] as String,
      uStatus: json['U_Status'] as String,
      uUserTell: json['U_User_Tell'] as String,
      uShowTell: json['U_Show_Tell'] as String,
      uClass: json['U_Class'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'U_Name': uName,
      'U_Email': uEmail,
      'U_Image': uImage,
      'U_Username': uUsername,
      'U_Password': uPassword,
      'U_Location': uLocation,
      'U_Status': uStatus,
      'U_User_Tell': uUserTell,
      'U_Show_Tell': uShowTell,
      'U_Class': uClass,
    };
  }
}
