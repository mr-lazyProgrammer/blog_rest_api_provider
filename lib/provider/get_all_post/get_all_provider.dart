import 'package:blog_rest_api_with_provider/data/model/get_all_post_response.dart';
import 'package:blog_rest_api_with_provider/data/service/blog_api_service.dart';
import 'package:blog_rest_api_with_provider/provider/get_all_post/get_all_post_state.dart';
import 'package:flutter/material.dart';

class GetAllNotifier extends ChangeNotifier{
  GetAllPostState getAllPostState = GetAllPostLoading();
  BlogApiService blogApiService = BlogApiService();

  Future<void> getAllPosts() async{
    getAllPostState = GetAllPostLoading();
    notifyListeners();
    try {
      final List<GetAllPostResponse> getAllPostList = await blogApiService
          .getAllPost();
      getAllPostState = GetAllPostSuccess(getAllPostList);
      notifyListeners();
    }catch(e){
      getAllPostState = GetAllPostError(e.toString());
      notifyListeners();
    }
  }
}