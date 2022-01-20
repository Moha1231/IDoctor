class UserModel {
  UserModel({this.displayName, this.photoUrl});
  String? displayName;
  String? photoUrl;

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
        displayName: jsonData['displayName'], photoUrl: jsonData['photoUrl']);
  }
}
