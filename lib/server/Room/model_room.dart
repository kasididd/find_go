class Room {
  final int rID;
  final String rDescription;
  final String images;
  final int rOwner;
  final String rName;
  final int rStatus;
  final int rType;
  final int mute;
  final int visible;
  final int rTell;
  final String rDetail;
  final String province;
  final String time;

  Room({
    required this.rID,
    required this.rDescription,
    required this.images,
    required this.rOwner,
    required this.rName,
    required this.rStatus,
    required this.rType,
    required this.mute,
    required this.visible,
    required this.rTell,
    required this.rDetail,
    required this.province,
    required this.time,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      rID: json['R_ID'] as int,
      rDescription: json['R_Description'] as String,
      images: json['Images'] as String,
      rOwner: json['R_Owner'] as int,
      rName: json['R_Name'] as String,
      rStatus: json['R_Status'] as int,
      rType: json['R_Type'] as int,
      mute: json['Mute'] as int,
      visible: json['Visible'] as int,
      rTell: json['R_Tell'] as int,
      rDetail: json['R_Detail'] as String,
      province: json['Province'] as String,
      time: json['Time'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'R_ID': rID,
      'R_Description': rDescription,
      'Images': images,
      'R_Owner': rOwner,
      'R_Name': rName,
      'R_Status': rStatus,
      'R_Type': rType,
      'Mute': mute,
      'Visible': visible,
      'R_Tell': rTell,
      'R_Detail': rDetail,
      'Province': province,
      'Time': time,
    };
  }
}

class RoomMember {
  int rmId;
  int rId;
  int userMember;
  int rClass;
  int status;
  int roomBlackList;

  RoomMember({
    required this.rmId,
    required this.rId,
    required this.userMember,
    required this.rClass,
    required this.status,
    required this.roomBlackList,
  });

  factory RoomMember.fromJson(Map<String, dynamic> json) => RoomMember(
        rmId: json['RM_ID'],
        rId: json['R_ID'],
        userMember: json['User_Member'],
        rClass: json['R_Class'],
        status: json['Status'],
        roomBlackList: json['Room_BlackList'],
      );

  Map<String, dynamic> toJson() => {
        'RM_ID': rmId,
        'R_ID': rId,
        'User_Member': userMember,
        'R_Class': rClass,
        'Status': status,
        'Room_BlackList': roomBlackList,
      };
}
