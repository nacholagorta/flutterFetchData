import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Post> fetchPost() async {
  final response =
  await http.get('https://opentdb.com/api.php?amount=10');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {

  final int response_code;
  final List<Result> results;
  List<Post> lista = [];
  //final String title;
  //final String body;

  Post({this.response_code, this.results});

  factory Post.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List<dynamic>;

    List<Result> myList = list.map((i) => Result.fromJson(i)).toList();
    print(myList);
    return Post(
      response_code: parsedJson['response_code'],
      results: myList,
    );
  }

  get question => question ;

  get difficulty => difficulty;

}

class Result {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correct_answer;
  final List<dynamic> incorrect_answers;


  Result({this.category, this.type, this.difficulty, this.question, this.correct_answer, this.incorrect_answers});

  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
        category:json['category'],
        type:json['type'],
        difficulty:json['difficulty'],
        question:json['question'],
        correct_answer:json['correct_answer'],
        incorrect_answers:json['incorrect_answers'],
    );
  }
}

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {

  List<Post> _users = [];

  bool _isLoading = true;

  final Future<Post> post;

  MyApp({Key key, this.post}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: ListView.builder(
        itemBuilder: (context, position) {
       ListTile(
      leading: Icon(Icons.account_circle),
      title:
      Text(_users[position].question + _users[position].difficulty),
      // subtitle: Text(_users[position].mail),

      );
      },

        reverse: false,

      ),


      ),
    );
  }


}
