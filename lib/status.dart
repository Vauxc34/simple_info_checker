import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';

/* 

 Gdyby czasem nie bylo paczek:

 The issue is due to the missing packages which are being used in the project. Therefore, in order to install the same, navigate to the folder where the project is present -> cmd -> execute the following commands:

-- flutter packages get

-- flutter packages upgrade
 
 */

List<String> users = ["Arnold", "Marcel", "Jozef"];

bool isChecked = false;

class StatusScreen extends StatefulWidget {
  StatusScreen({this.weather});

  // jestesmy w stanie, w kazdym widzecie przekazywac po kolei dane kazdego z obiektu,
  // w momencie, w ktorym konstruktor, posiada zainicjowana zmienna, ktora moze zostac
  // kolejno przekazana w dol - do elementow interfejsu uzytkownika

  final Weather? weather;

  @override
  State<StatefulWidget> createState() {
    return _PageDetails();
  }
}

//https://stackoverflow.com/questions/67855344/flutter-how-to-map-list-of-array-to-widget

class _PageDetails extends State<StatusScreen> {
  var temperature;

  @override
  void initState() {
    temperature = widget.weather!.temperature!.fahrenheit!.floor().toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xD201DD5D),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 5),
            child: Text("John Titor - app",
                style: GoogleFonts.aboreto(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 23,
                        color: Color(0xFF021F3D)))),
          )),
          Container(
              alignment: Alignment.center,
              height: 150,
              width: 150,
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
                color: Color.fromARGB(184, 230, 234, 214),
                boxShadow: [
                  BoxShadow(color: Color(0xFFC4A336), spreadRadius: 2),
                ],
              ),
              child: Text('50',
                  style: GoogleFonts.abel(
                      textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 48,
                    color: Color(0xFF021F3D),
                  )))),
          Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text('Przeczytane ksiazki:'),
          ),
          Container(
            child: Text('Polowa'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 15, 10, 5),
                      child: Text('Ilosc w szt')),
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                      child: Text('100%')),
                ],
              ),
              Container(
                  child: Container(
                height: 55,
                width: 1,
                color: Colors.black,
                margin: EdgeInsets.fromLTRB(10, 15, 10, 5),
              )),
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 15, 10, 5),
                      child: Text('Jakosc w %')),
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                      child: Text('78%')),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 7.5, 5, 0),
            child: Text('Temperatura na zewnatrz',
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Color.fromRGBO(46, 46, 46, 1)))),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 7.5, 5, 0),
            child: Text('$temperature°',
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color: Color.fromRGBO(46, 46, 46, 1)))),
          ),
          // renderowanie warunkowe jestesmy w stanie uzyskac zapisujac bezposrednio komponenty za pomoca
          // warunkow if, else if - zamieszczajac ponizej komponenty (pod warunkiem)
          if (isChecked)
            Container(
              margin: EdgeInsets.fromLTRB(5, 7.5, 5, 0),
              child: Text('Zweryfikowany ✅',
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          color: Color(0xFF06EA02)))),
            )
          else if (isChecked == false)
            Container(
              margin: EdgeInsets.fromLTRB(5, 7.5, 5, 0),
              child: Text('Nie sprawdzony ❌',
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          color: Color(0xFFEA0202)))),
            ),
        ],
      ),
    );
  }
}

// nie wolno uzywac metody void, w miejsce metody zmieniajacej konkretna wartosc w komponencie
 