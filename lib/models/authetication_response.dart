class AutheticationResponse{
  final String token;


  AutheticationResponse({required this.token});
  
  static AutheticationResponse fromJson(Map<String, dynamic> json ){

    return AutheticationResponse(token: json['token']);
  }
}


