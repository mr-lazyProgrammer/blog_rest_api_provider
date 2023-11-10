import 'package:blog_rest_api_with_provider/data/model/blog_upload_response.dart';
import 'package:blog_rest_api_with_provider/data/service/blog_api_service.dart';
import 'package:blog_rest_api_with_provider/provider/upload_post/upload_ui_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UploadPostNotifier extends ChangeNotifier{
  UploadUiState uploadUiState = UploadUiLoading(0);
  BlogApiService blogApiService = BlogApiService();

  Future<void> uploadPost({required String title,required String body,required int progress,required FormData data}) async{
    uploadUiState = UploadUiLoading(progress);
    notifyListeners();
    
    try{
      final BlogUploadResponse blogUploadResponse = await blogApiService.blogPostUpload(title: title, body: body, data: data);
      uploadUiState = UploadUiSuccess(blogUploadResponse);
    }catch(e){
      uploadUiState = UploadUiFailed("Something Wrong");
    }
  }
}