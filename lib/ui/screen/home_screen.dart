import 'package:blog_rest_api_with_provider/data/model/get_all_post_response.dart';
import 'package:blog_rest_api_with_provider/provider/get_all_post/get_all_post_state.dart';
import 'package:blog_rest_api_with_provider/provider/get_all_post/get_all_provider.dart';
import 'package:blog_rest_api_with_provider/ui/screen/blog_post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void didChangeDependencies() {
    _getAllPost(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Api'),
        centerTitle: true,
      ),
      body: Consumer<GetAllNotifier>(
        builder: (_,getAllProvider,__){
          GetAllPostState getAllPostState = getAllProvider.getAllPostState;
          if(getAllPostState is GetAllPostSuccess){
            List<GetAllPostResponse> getAllPostResponseList = getAllPostState.getAllPostList;
            return ListView.builder(
                itemCount: getAllPostResponseList.length,
                itemBuilder: (context,position){
                  GetAllPostResponse getAllPostResponse = getAllPostResponseList[position];
                  return InkWell(
                    onTap: (){
                      if(getAllPostResponse.id != null) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => BlogPostDetailScreen(id: getAllPostResponse.id!)));
                      }
                    },
                    child: Card(
                      child: ListTile(
                        title: Text('${getAllPostResponse.title}'),
                      ),
                    ),
                  );
                });
          }else if(getAllPostState is GetAllPostError){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("OOPs Something Wrong"),
                  const Divider(),
                  ElevatedButton(onPressed: (){
                    _getAllPost(context);
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

  void _getAllPost(BuildContext ctx){
    Provider.of<GetAllNotifier>(ctx,listen: false).getAllPosts();
  }
}
