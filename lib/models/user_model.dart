class UserModel {
  final String userName;
  final String userID;
  final String profilePicture;
  final String phoneNum;
  final bool isUserOnline;
  final List<String> userGroupID;

  UserModel(
      {required this.userName,
      required this.userID,
      required this.profilePicture,
      required this.phoneNum,
      required this.isUserOnline,
      required this.userGroupID});

  Map<String, dynamic> toJSON() => {
        "userName": userName,
        "userID": userID,
        "profilePicture": profilePicture,
        "phoneNum": phoneNum,
        "isUserOnline": isUserOnline,
        "userGroupID": userGroupID
      };

  factory UserModel.fromJSON(Map<String, dynamic> json) => UserModel(
      userName: json["userName"] ?? "",
      userID: json["userID"] ?? "",
      profilePicture: json["profilePicture"] ?? "",
      phoneNum: json["phoneNum"] ?? "",
      isUserOnline: json["isUserOnline"] ?? false,
      userGroupID: List<String>.from(json["userGroupID"]));
}
