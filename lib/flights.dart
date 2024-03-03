import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Flights extends StatefulWidget {
  const Flights({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PageDetails();
  }
}

List<dynamic> users = ["Arnold", "Marcel", "Jozef"];

//List<dynamic> reponseModel = [];

class Post {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  Post({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  Post.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }
}

Widget buildPosts(List<Post> posts) {
  return ListView.builder(
    itemCount: 3,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      final post = posts[index];
      return Stack(alignment: Alignment.center, children: [
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Column(children: [
            Container(
              height: 80,
              width: 350,
              color: Color(0xFFD6D6D6),
              child: Image.network(post.url!),
            ),
            Container(
              height: 40,
              width: 350,
              color: Color.fromARGB(195, 156, 156, 156),
              padding: EdgeInsets.all(10),
              child: Text(post.title!),
            ),
          ]),
        )
      ]);
    },
  );
}

/*Future<void> FetchAlbum() async {
  var jsonResponse;

  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
  if (response.statusCode == 200) {
    jsonResponse = json.decode(response.body.toString());
    reponseModel.add(jsonResponse);
  } else {
    throw Exception('Failed to load album');
  }
}

void responseCheck() {
  print(reponseModel);
}*/

class _PageDetails extends State<Flights> {
  Future<List<Post>> postsFuture = getPosts();

  static Future<List<Post>> getPosts() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/albums/1/photos");
    final response = await http.get(
      url,
      headers: {
        "Origin": "*",
        "Content-Type": "application/json",
      },
    );
    final List body = json.decode(response.body);
    return body.map((e) => Post.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Stack(fit: StackFit.expand, alignment: Alignment.center, children: [
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 224, 93, 6),
                Color.fromARGB(255, 197, 131, 9),
                Color(0xFF750749)
              ]),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text('Drogeria',
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 32,
                        color: Color.fromARGB(255, 255, 255, 255)))),
          ),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
              decoration: BoxDecoration(
                  color: Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(20)),
              height: 500,
              width: 400,
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 5, top: 5),
                      child: Text("Propozycje na dzis",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 23,
                                  color: Color(0xFF1D252C))))),
                  FutureBuilder<List<Post>>(
                    future: postsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        return buildPosts(snapshot.data!);
                      } else {
                        return const Text("No data available");
                      }
                    },
                  ),
                ],
              )),
        ],
      ),
    ]));
  }
}


//reponseModel