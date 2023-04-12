class UserModel {
  String name;
  String uname;
  String pass;

  UserModel({required this.name, required this.uname, required this.pass});

  Map<String, dynamic> toMap() => {
        "name": name,
        "uname": uname,
        "pass": pass,
      };
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(name: 'name', uname: 'uname', pass: 'pass');
  }
}
