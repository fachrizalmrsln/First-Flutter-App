import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/database.dart';
import 'package:hello_world/post.dart';
import 'package:hello_world/postList.dart';
import 'package:hello_world/textInputWidget.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;

  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> mPostData = [];

  void newPost(String newPost) {
    var post = new Post(newPost, widget.user.displayName);
    post.setId(savePost(post));
    setState(() {
      mPostData.add(post);
    });
  }

  void updateMessages() {
    getAllMessages().then((value) => {
          this.setState(() {
            this.mPostData = value;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updateMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Demo App")),
      body: Column(
        children: [
          Expanded(child: PostList(this.mPostData, widget.user)),
          TextInputWidget(this.newPost),
        ],
      ),
    );
  }
}
