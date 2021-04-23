import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hello_world/database.dart';

class Post {
  String body;
  String author;
  int likes = 0;
  Set userLiked = {};
  DatabaseReference _id;

  Post(this.body, this.author);

  void likePost(FirebaseUser user) {
    if (this.userLiked.contains(user.uid)) {
      this.userLiked.remove(user.uid);
    } else {
      this.userLiked.add(user.uid);
    }
    this.update();
  }

  void update() {
    updatePost(this, this._id);
  }

  void setId(DatabaseReference id) {
    this._id = id;
  }

  DatabaseReference getId() {
    return _id;
  }

  Map<String, dynamic> toJson() {
    return {
      'author': this.author,
      'body': this.body,
      'userLiked': this.userLiked.toList()
    };
  }
}

Post createPost(record) {
  Map<String, dynamic> attribute = {
    'author': '',
    'userLiked': [],
    'body': '',
  };

  record.forEach((key, value) => {attribute[key] = value});

  Post post = new Post(attribute['body'], attribute['author']);
  post.userLiked = new Set.from(attribute['userLiked']);

  return post;
}
