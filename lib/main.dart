import 'package:chopperApp/data/post_api_service.dart';
import 'package:chopperApp/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_)=>PostApiService.create(),
      dispose: (_,PostApiService service)=> service.client.dispose(),
          child: MaterialApp(
        title: 'Chopper app',
        home:HomePage()
      ),
    );
  }
}



