import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    String type;
    String token;

    LoginResponse({
        required this.type,
        required this.token,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        type: json["type"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "token": token,
    };
}
