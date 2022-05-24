class Session {
  final String token;
  final DateTime createAt;

  Session({
    required this.token,
    required this.createAt,
  });

  static Session fromJson(Map<String, dynamic> json) {
    return Session(
      token: json['token'],
      createAt: DateTime.parse(json['createAt']),
    );
  }
  Map<String, dynamic> toJson(){
    return{
      "token": token,
      "createAt": createAt.toString(),
    };
  }
}
