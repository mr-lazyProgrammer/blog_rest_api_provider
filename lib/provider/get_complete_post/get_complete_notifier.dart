import 'package:blog_rest_api_with_provider/data/model/get_one_post_response.dart';
import 'package:blog_rest_api_with_provider/data/service/blog_api_service.dart';
import 'package:blog_rest_api_with_provider/provider/get_complete_post/get_complete_post_state.dart';
import 'package:flutter/foundation.dart';

class GetCompleteNotifier extends ChangeNotifier{
  GetCompletePostState getCompletePostState = GetCompletePostLoading();
  BlogApiService blogApiService = BlogApiService();

  Future<void> getOnePost({required int id})async{
    getCompletePostState = GetCompletePostLoading();
    notifyListeners();

    try {
      final GetOnePostResponse getOnePostResponse = await blogApiService
          .getOnePost(id);
      getCompletePostState = GetCompletePostSuccess(getOnePostResponse);
      notifyListeners();
    }catch(_){
      getCompletePostState = GetCompletePostFailed("Something Wrong");
    }
  }
}