class CreatePostResponse {
    CreatePostResponse({
        this.msg,
    });

    String? msg;

    factory CreatePostResponse.fromJson(Map<String, dynamic>? json) => CreatePostResponse(

        msg: json?["msg"],
    );

    Map<String, dynamic> toJson() => {

        "msg": msg,
    };
}
