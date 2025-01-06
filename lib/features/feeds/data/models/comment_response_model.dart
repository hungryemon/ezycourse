
class CommentResponse{

   final int id;
  final int schoolId;
  final int feedId;
  final int userId;
  final int replyCount;
  final int likeCount;
  final String commentTxt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel userEntity;
  const CommentResponse({
   required this.id,
      required this.schoolId,
      required this.feedId,
      required this.userId,
      required this.replyCount,
      required this.likeCount,
      required this.commentTxt,
      required this.createdAt,
      required this.updatedAt,
      required this.userEntity
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) => CommentResponse(
        id: json["id"],
        schoolId: json["school_id"],
        feedId: json["feed_id"],
        userId: json["user_id"],
        replyCount: json["reply_count"],
        likeCount: json["like_count"],
        commentTxt: json["comment_txt"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userEntity: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "school_id": schoolId,
        "feed_id": feedId,
        "user_id": userId,
        "reply_count": replyCount,
        "like_count": likeCount,
        "comment_txt": commentTxt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class UserModel  {
   final int id;
  final String fullName;
  final String profilePic;
  final String userType;
  const UserModel({
     required this.id,
    required this.fullName,
    required this.profilePic,
    required this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fullName: json["full_name"],
        profilePic: json["profile_pic"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "profile_pic": profilePic,
        "user_type": userType,
      };
}