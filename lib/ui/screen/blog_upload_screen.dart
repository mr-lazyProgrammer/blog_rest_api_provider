import 'dart:io';

import 'package:blog_rest_api_with_provider/provider/upload_post/upload_post_notifier.dart';
import 'package:blog_rest_api_with_provider/provider/upload_post/upload_ui_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BlogUploadScreen extends StatefulWidget {
  const BlogUploadScreen({super.key});

  @override
  State<BlogUploadScreen> createState() => _BlogUploadScreenState();
}

class _BlogUploadScreenState extends State<BlogUploadScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  File? _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Upload'),
        centerTitle: true,
      ),
      body: Consumer<UploadPostNotifier>(
        builder: (_,uploadPostNotifier,__){
          UploadUiState uploadUiState = uploadPostNotifier.uploadUiState;
          if(uploadUiState is UploadUiLoading){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Uploading Please Wait.. ${uploadUiState.progress} %"),
                  const SizedBox(height: 20,),
                  LinearProgressIndicator(
                    value: uploadUiState.progress.toDouble(),
                  )
                ],
              ),
            );
          }
          else if(uploadUiState is UploadUiSuccess){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(uploadUiState.blogUploadResponse.result ?? ''),
                  const SizedBox(height: 20,),
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context,"success");
                    uploadPostNotifier.uploadUiState = UploadFormState();
                  }, child:const Text('Ok'))
                ],
              ),
            );
          }
          else if(uploadUiState is UploadUiFailed){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(uploadUiState.errorMessage),
                  const SizedBox(height: 20,),
                  ElevatedButton(onPressed: (){
                    uploadPostNotifier.tryAgain();
                  }, child:const Text('Try Again'))
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: "Enter Your Blog Title",
                      border: OutlineInputBorder()
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    maxLines: 5,
                    minLines: 3,
                    controller: _bodyController,
                    decoration: const InputDecoration(
                      labelText: "Enter Your Blog Content",
                      border: OutlineInputBorder()
                    ),
                  ),
                  const SizedBox(height: 20,),
                  FilledButton(onPressed: ()async{
                   XFile? file = await _imagePicker.pickImage(source: ImageSource.gallery);
                   if(file != null) {
                     setState(() {
                       _image = File(file.path);
                   });
                   }
                  }, child: const Text('Select Image')),
                  const SizedBox(height: 20,),
                  if(_image != null)
                  Image.file(_image!,height: 200,),
                  const SizedBox(height: 20,),
                  ElevatedButton(onPressed: ()async {
                    if(_titleController.text.isNotEmpty && _bodyController.text.isNotEmpty){
                      String title = _titleController.text;
                      String body = _bodyController.text;
                      FormData? data;
                      if(_image != null) {
                        data = FormData.fromMap({
                        "photo" : await MultipartFile.fromFile(_image!.path),
                      });
                      }
                      if(mounted) {
                        Provider.of<UploadPostNotifier>(context,listen: false).uploadPost(title: title, body: body, data: data);
                      }
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please Enter Title And Content')));
                    }
                  }, child: const Text('Upload'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
