abstract class SocialStates{}
class SocialInitialState extends SocialStates{

}
class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
   final String error;
  SocialGetUserErrorState(this.error);
}
class SocialChangeBottomNavState extends SocialStates{}

class SocialNewPostState extends SocialStates{}

class SocialProfileImageSuccessState extends SocialStates{}
class SocialProfileImageErrorState extends SocialStates{}

class SocialCoverImageSuccessState extends SocialStates{}
class SocialCoverImageErrorState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUpdateUserSuccessState extends SocialStates{}
class SocialUpdateUserErrorState extends SocialStates{}

class SocialUpdateImageLoadingState extends SocialStates{}
class SocialUpdateCoverLoadingState extends SocialStates{}
class SocialHideBtUpdateProfileState extends SocialStates{}
class SocialHideBtUpdateCoverState extends SocialStates{}


//posts
class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostErrorState extends SocialStates{}

class SocialPostPickImageSuccessState extends SocialStates{}
class SocialPostPickImageErrorState extends SocialStates{}
//remove
class SocialPostRemoveImageSuccessState extends SocialStates{}

class SocialGetPostLoadingState extends SocialStates{}
class SocialGetPostSuccessState extends SocialStates{}
class SocialGetPostErrorState extends SocialStates{
  final String error;
  SocialGetPostErrorState(this.error);
}
//likes
class SocialPostLikeSuccessState extends SocialStates{}
class SocialPostLikeErrorState extends SocialStates{
  final String error;
  SocialPostLikeErrorState(this.error);
}
//dislike
class SocialPostDisLikeSuccessState extends SocialStates{}
class SocialPostDisLikeErrorState extends SocialStates{
  final String error;
  SocialPostDisLikeErrorState(this.error);
}
//comment
class SocialPostCreateCommentSuccessState extends SocialStates{}
class SocialCreateCommentErrorState extends SocialStates{
  final String error;
  SocialCreateCommentErrorState(this.error);
}
//getlike
class SocialGetPostLikeSuccessState extends SocialStates{}
class SocialGetPostLikeErrorState extends SocialStates{
  final String error;
  SocialGetPostLikeErrorState(this.error);

}
//chat
class SocialGetAllUserLoadingState extends SocialStates{}
class SocialGetAllUserSuccessState extends SocialStates{}
class SocialGetAllUserErrorState extends SocialStates {
  final String error;

  SocialGetAllUserErrorState(this.error);
}

class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates {
  final String error;

  SocialSendMessageErrorState(this.error);
}
class SocialGetMessageSuccessState extends SocialStates{}
