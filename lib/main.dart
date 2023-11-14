import 'package:blog_rest_api_with_provider/data/service/blog_api_service.dart';
import 'package:blog_rest_api_with_provider/provider/get_all_post/get_all_provider.dart';
import 'package:blog_rest_api_with_provider/provider/get_complete_post/get_complete_notifier.dart';
import 'package:blog_rest_api_with_provider/provider/upload_post/upload_post_notifier.dart';
import 'package:blog_rest_api_with_provider/ui/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetAllNotifier()),
        ChangeNotifierProvider(create: (_) => GetCompleteNotifier()),
        ChangeNotifierProvider(create: (_) => UploadPostNotifier())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

