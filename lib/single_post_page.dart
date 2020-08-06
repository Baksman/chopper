import 'dart:convert';

import 'package:chopperApp/data/post_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SinglePostPage extends StatelessWidget {
  final int postId;
  SinglePostPage({this.postId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chopper blog"),
      ),
      body: FutureBuilder(
          future: Provider.of<PostApiService>(context).getPost(postId),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final Map posts = json.decode(snapshot.data.bodyString);
              return _buildPost(posts);
            }
            return Center(
              child: CircularProgressIndicator(),
            ); 
          }),
    );
  }

  Column _buildPost(Map post) {
    return Column(
      children: <Widget>[
        Text(
          post["title"],
          style: TextStyle(
           fontSize: 30,
           fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        Text(post["body"])
      ],
    );
  }
}
