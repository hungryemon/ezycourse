import 'dart:convert';

ReactionResponse reactionResponseFromJson(String str) => ReactionResponse.fromJson(json.decode(str));

String reactionResponseToJson(ReactionResponse data) => json.encode(data.toJson());

class ReactionResponse {
    final int? totalReactions;
    final List<LikeType>? likeType;

    ReactionResponse({
        this.totalReactions,
        this.likeType,
    });

    factory ReactionResponse.fromJson(Map<String, dynamic> json) => ReactionResponse(
        totalReactions: json["total_reactions"],
        likeType: json["likeType"] == null ? [] : List<LikeType>.from(json["likeType"]!.map((x) => LikeType.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total_reactions": totalReactions,
        "likeType": likeType == null ? [] : List<dynamic>.from(likeType!.map((x) => x.toJson())),
    };
}

class LikeType {
    final String? reactionType;
    final Meta? meta;

    LikeType({
        this.reactionType,
        this.meta,
    });

    factory LikeType.fromJson(Map<String, dynamic> json) => LikeType(
        reactionType: json["reaction_type"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "reaction_type": reactionType,
        "meta": meta?.toJson(),
    };
}

class Meta {
    Meta();

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    );

    Map<String, dynamic> toJson() => {
    };
}