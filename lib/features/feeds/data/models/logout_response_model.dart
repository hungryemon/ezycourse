class LogoutResponse {
    LogoutResponse({
        this.msg,
    });

    String? msg;

    factory LogoutResponse.fromJson(Map<String, dynamic>? json) => LogoutResponse(

        msg: json?["msg"],
    );

    Map<String, dynamic> toJson() => {

        "msg": msg,
    };
}
