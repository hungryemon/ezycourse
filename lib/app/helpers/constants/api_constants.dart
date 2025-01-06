class ApiConstants {
  static String baseUrlProdPrimary = "https://ezycourse.com/api/app";
  static String baseUrlProdSecondary = "https://iap.ezycourse.com/api/app";

  static String baseUrlDevPrimary = "https://ezycourse.com/api/app";
  static String baseUrlDevSecondary = "https://iap.ezycourse.com/api/app";
}

class ApiList {
  static String loginUrlWithPrimary = "/student/auth/login";
  static String feedUrlWithSecondary = "/teacher/community/getFeed?status=feed&";
  static String logoutUrlWithSecondary = "/student/auth/logout";
  static String createLikeUrlWithSecondary = "/teacher/community/createLike";
  static String createPostUrlWithSecondary =
      "/teacher/community/createFeedWithUpload";
   static String getCommentsUrlWithSecondary = "/student/comment/getComment/";
  static String getRepliesUrlWithSecondary = "/student/comment/getReply/";
  static String createCommentsUrlWithSecondary = "/student/comment/createComment";
}
