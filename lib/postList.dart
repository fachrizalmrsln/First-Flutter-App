import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/post.dart';

class PostList extends StatefulWidget {
  final List<Post> postItems;
  final FirebaseUser user;

  PostList(this.postItems, this.user);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(Function callback) {
    this.setState(() {
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.postItems.length,
      itemBuilder: (context, index) {
        var post = this.widget.postItems[index];
        return Card(
          child: Row(
            children: [
              Expanded(
                  child: ListTile(
                title: Text(post.body),
                subtitle: Text(post.author),
              )),
              Row(
                children: [
                  Container(
                    child: Text(post.userLiked.length.toString(),
                        style: TextStyle(fontSize: 20)),
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  ),
                  IconButton(
                    icon: Icon(Icons.thumb_up),
                    onPressed: () =>
                        this.like(() => post.likePost(widget.user)),
                    color: post.userLiked.contains(widget.user.uid)
                        ? Colors.green
                        : Colors.black,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
