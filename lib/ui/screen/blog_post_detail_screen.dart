import 'package:blog_rest_api_with_provider/data/model/get_one_post_response.dart';
import 'package:blog_rest_api_with_provider/data/service/blog_api_service.dart';
import 'package:blog_rest_api_with_provider/provider/get_complete_post/get_complete_notifier.dart';
import 'package:blog_rest_api_with_provider/provider/get_complete_post/get_complete_post_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogPostDetailScreen extends StatefulWidget {
  const BlogPostDetailScreen({super.key, required this.id});
  final int id;

  @override
  State<BlogPostDetailScreen> createState() => _BlogPostDetailScreenState();
}

class _BlogPostDetailScreenState extends State<BlogPostDetailScreen> {

  @override
  void didChangeDependencies() {
    _getOnePost();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(),
      body: Consumer<GetCompleteNotifier>(
        builder: (_,getCompleteNotifier,__){
          GetCompletePostState getCompletePostState = getCompleteNotifier.getCompletePostState;
          if(getCompletePostState is GetCompletePostSuccess){
            GetOnePostResponse getOnePostResponse = getCompletePostState.getOnePostResponse;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('${getOnePostResponse.body}'),
                    const SizedBox(height: 10,),
                    if(getOnePostResponse.photo != null)
                    Image.network("${BlogApiService.baseUrl}${getOnePostResponse.photo}")
                  ],
                ),
              ),
            );
          }else if(getCompletePostState is GetCompletePostFailed){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("OOPs Something Wrong"),
                  const Divider(),
                  ElevatedButton(onPressed: (){
                    _getOnePost();
                  }, child: const Text('Try Again'))
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _getOnePost(){
    Provider.of<GetCompleteNotifier>(context,listen: false).getOnePost(id: widget.id);
  }
}
