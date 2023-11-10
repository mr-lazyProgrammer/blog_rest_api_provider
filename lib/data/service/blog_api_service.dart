import 'package:blog_rest_api_with_provider/data/model/get_all_post_response.dart';
import 'package:dio/dio.dart';

import '../model/blog_upload_response.dart';
import '../model/get_one_post_response.dart';

class BlogApiService{

  static const String baseUrl = "http://rubylearner.com:5000/";
  late Dio dio;

  BlogApiService(){
    dio = Dio();
  }

  Future<List<GetAllPostResponse>> getAllPost()async{
    final allPostList = await dio.get("${baseUrl}posts");
    final allPost = (allPostList.data as List).map((e){
      return GetAllPostResponse.fromJson(e);
    }).toList();
    return allPost;
  }

  Future<GetOnePostResponse> getOnePost(int id)async{
    final onePost = await dio.get("${baseUrl}post?id=$id");
    final postList = onePost.data as List;
    final post = GetOnePostResponse.fromJson(postList[0]);
    return post;
  }

  Future<BlogUploadResponse> blogPostUpload({required String title,required String body,required FormData data})async{
    final blogUploadResponse = await dio.post("${baseUrl}post?title=$title&$body",data: data);
    return BlogUploadResponse.fromJson(blogUploadResponse.data);
  }
}