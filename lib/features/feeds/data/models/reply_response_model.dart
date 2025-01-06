
import 'package:ezycourse/features/feeds/data/models/comment_response_model.dart';



class ReplyResponse  {
  final int id;
  final int schoolId;
  final int feedId;
  final int userId;
  final int replyCount;
  final int likeCount;
  final String commentTxt;
  final int parrentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int isAuthorAndAnonymous;
  final UserModel userEntity;

  const ReplyResponse({
    required this.id,
    required this.schoolId,
    required this.feedId,
    required this.userId,
    required this.replyCount,
    required this.likeCount,
    required this.commentTxt,
    required this.parrentId,
    required this.createdAt,
    required this.updatedAt,
    required this.isAuthorAndAnonymous,
    required this.userEntity,
  });

  factory ReplyResponse.fromJson(Map<String, dynamic> json) => ReplyResponse(
        id: json["id"],
        schoolId: json["school_id"],
        feedId: json["feed_id"],
        userId: json["user_id"],
        replyCount: json["reply_count"],
        likeCount: json["like_count"],
        commentTxt: json["comment_txt"],
        parrentId: json["parrent_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isAuthorAndAnonymous: json["is_author_and_anonymous"],
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
        "parrent_id": parrentId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_author_and_anonymous": isAuthorAndAnonymous,
      };
}