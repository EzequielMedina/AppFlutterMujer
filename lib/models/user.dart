
class InfoUser {
    InfoUser({

        required this.user,
    });


    final User user;

    factory InfoUser.fromJson(Map<String, dynamic> json) => InfoUser(

        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
    };
}

class User {
    User({
        required this.id,
        required this.usuario,
        required this.email,
        required this.avatar,
    });

    final String id;
    final String usuario;
    final String email;
    final String avatar;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["user"]["id"],
        usuario: json["user"]["usuario"],
        email: json["user"]["email"],
        avatar: json["user"]["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "usuario": usuario,
        "email": email,
        "avatar": avatar,
    };
}
