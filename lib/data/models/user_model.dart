class User {
  int? userId;
  String userName;

  User({this.userId, required this.userName});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'],
      userName: map['userName'],
    );
  }
}
