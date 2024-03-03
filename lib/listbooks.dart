import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

/* 

 Gdyby czasem nie bylo paczek:

 The issue is due to the missing packages which are being used in the project. Therefore, in order to install the same, navigate to the folder where the project is present -> cmd -> execute the following commands:

-- flutter packages get

-- flutter packages upgrade
 
 */

class ListBooks extends StatefulWidget {
  const ListBooks({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PageDetails();
  }
}

List<String> users = ["Harry Potter - Jk Rowling", "LOTR - TOLKIEN", "Lalka"];

Widget _Book(String name) {
  return InkWell(
    onTap: () {},
    child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 200,
        padding: EdgeInsets.fromLTRB(10, 5, 0, 15),
        margin: EdgeInsets.only(bottom: 5, top: 5),
        color: Colors.amber,
        child: Text("$name")),
  );
}

//https://stackoverflow.com/questions/67855344/flutter-how-to-map-list-of-array-to-widget

class _PageDetails extends State<ListBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 206, 177, 89),
        body: Stack(alignment: Alignment.center, children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFFF39600),
                    Color.fromARGB(255, 210, 4, 128)
                  ]),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: Text('Twoja biblioteka',
                    style: GoogleFonts.anton(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 45,
                            color: Color(0xE8FFFFFF)))),
              ),
              Column(children: users.map((e) => _Book(e)).toList())
            ],
          )
        ]));
  }
}


// za pomoca google font's jestesmy w stanie efektywnie stylowac interfejsy

/*

GoogleFonts.anton(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 23,
                    color: Color(0x000B73E1)))

 */