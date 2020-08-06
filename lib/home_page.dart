import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:chopperApp/data/post_api_service.dart';
import 'package:chopperApp/single_post_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chopper blog"),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            final response = await Provider.of<PostApiService>(context)
                .postPost({"key": "value"});
            print(response.body);
          }),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    return FutureBuilder<Response>(
      future: Provider.of<PostApiService>(context).getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final Map posts = json.decode(snapshot.data.bodyString);
          return _buildPost(context, posts);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  ListView _buildPost(BuildContext context, Map posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(posts[index]["title"]),
            subtitle: Text(posts[index]["body"]),
            onTap: () => _navigateToPost(context, posts[index]["id"]),
          ),
        );
      },
    );
  }

  _navigateToPost(BuildContext context, int id) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SinglePostPage(postId: id);
    }));
  }
}
