class BaseResponse {
    BaseResponse({
        this.msg,
    });

    String? msg;

    factory BaseResponse.fromJson(Map<String, dynamic>? json) => BaseResponse(

        msg: json?["msg"],
    );

    Map<String, dynamic> toJson() => {

        "msg": msg,
    };
}
