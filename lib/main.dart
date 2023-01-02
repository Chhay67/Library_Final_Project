import 'package:flutter/material.dart';
import 'package:library_final_project/data/network/network_service.dart';
import 'package:library_final_project/view_models/author_view_model.dart';
import 'package:library_final_project/view_models/book_view_model.dart';
import 'package:library_final_project/view_models/image_view_model.dart';
import 'package:library_final_project/views/home_screen/home_screen.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
          ChangeNotifierProvider(create: (_) => BookViewModel()),
          ChangeNotifierProvider(create: (_) => AuthorViewModel()),
          ChangeNotifierProvider(create: (_) => ImageViewModel()),
          StreamProvider(create: (context) => NetworkService().controller.stream, initialData: NetworkStatus.online)
        ],
      child: MaterialApp(
        title: 'Book Library',
        theme: ThemeData(
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
