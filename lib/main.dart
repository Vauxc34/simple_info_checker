import 'dart:convert';

import "package:flutter/material.dart";
import "package:fluttersomeapp/home.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:toastify/toastify.dart';
import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  runApp(Temp());
  await dotenv.load(fileName: ".env");
}

class Temp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: "Scizos", home: new Loading());
  }
}

/* 

// flutter run -d chrome - komenda pozwalajaca nam na odpalenie aplikacji za pomoca google chrome'a
bez koniecznosci debugowania


new Future.delayed(
  const Duration(seconds: liczba_sekund) - owa funkcja odnosie sie do przyszlosci i w tej sytuacji
  // przyszlego dzialania, w zwiazku z opisanym wyzej stanem, i odniesiem tego dzialania
  // do czasu, po jakim ma sie wykonac operacja 
)

 Gdyby czasem nie bylo paczek:

 The issue is due to the missing packages which are being used in the project. Therefore, in order to install the same, navigate to the folder where the project is present -> cmd -> execute the following commands:

-- flutter packages get

-- flutter packages upgrade
 
 1. Jezeli nie doczytuja sie zdjecia, to warto dodac pare warunkow, do plikow konfiguracyjnych MacOs - 

 Image.network('https://static.thenounproject.com/png/1356002-200.png'))

 macOS needs you to request a specific entitlement in order to access the network. To do that open macos/Runner/DebugProfile.entitlements and add the following key-value pair.

<key>com.apple.security.network.client</key>
<true/>

2. Zdjecia odczytane lokalnie najpierw musza znajdowac sie w pliku pubspec.yaml, tylko po to

assets:
  - nazwa_katalogu/smile.jpg

zeby kolejno, one same mogly zostac zaczytane komendami: flutter pub get, flutter pub upgrade

---------------

// Kolumny i elementy odpowiedzialne za ulozenie interfejsu aplikacji

-- Stack, ktory normalnie ma ograniczenie od 20 do 250 szerokosci, a potem od 50 do 100 wysokosci 
bedzie przydzielal, niewypozycjonowanym "dzieciom" maksymalne wartosci (szerokosc, wysokosc) wewnatrz - podane wyzej wartosci

 */

class QualityOfAir {
  bool isGood = false;
  bool isBad = false;
  String quality = '';
  String advice = '';
  int aqi = 0;
  int pm25 = 0;
  int pm10 = 0;
  String station = '';

  QualityOfAir(Map<String, dynamic> jsonBody) {
    aqi = int.tryParse(jsonBody['data']['aqi'].toString()) ?? -1;
    pm25 = int.tryParse(jsonBody['data']['pm25'].toString()) ?? -1;
    pm10 = int.tryParse(jsonBody['data']['pm10'].toString()) ?? -1;

    // kazdy typ danych int powinien zostac odpowiednio przeszktalcony na typ String, jak zostalo to ukazane wyzej

    // powinnismy za kazdym razem zwracac uwage na "rozgalezienie" obiektow w tablicy, w zaleznosci od pobieranych
    // danych przez nas do api

    station = jsonBody['data']['city']['name'].toString();
    setupLevel(aqi);
  }

  // kazda klasa moze posiadac indywidualnie przypisane funkcje
  //

  void setupLevel(int aqi) {
    if (aqi <= 100) {
      quality = "Jest dobrze";
      advice = "Ciesz sie tu i teraz";
      isGood = true;
    } else if (aqi <= 150) {
      quality = "Jest ok";
      advice = "Nie jest zle";
      isBad = true;
    } else {
      quality = "Jest beznadziejnie";
      advice = "Zmien miejsce";
    }
  }
}

class Loading extends StatefulWidget {
  final String? title;
  const Loading({Key? key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PageDetails();
  }
}

class _PageDetails extends State<Loading> {
  var weather;
  var aq;

  void executeOnceAfterBuild() async {
    WeatherFactory wf = new WeatherFactory('08fc858069758856d5903c3446ca7fd4',
        language: Language.POLISH);
    Weather w = await wf.currentWeatherByCityName('Krakow');
    weather = w;
  }

  void additionalInfo() async {
    var lat = 51.236686;
    var lon = 22.544199;
    var keyword = 'geo:$lat;$lon';
    var key = 'b22116cb5adfd1b09edee67a3eda55a24587f23d';

    String? _endpoint = 'https://api.waqi.info/feed';

    String url = '$_endpoint/$keyword/?token=$key';

    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> jsonBody = json.decode(response.body);
    QualityOfAir aq = new QualityOfAir(jsonBody);
  }

  void backToPage() {
    Navigator.pop(context);
  }

  void goToPage() {
    showToast(
      context,
      Toast(
        title: 'Czesc uzytkowniku!',
        description: 'Milo cie widziec',
      ),
    );

    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new Home(weather: weather)));
  }

  @override
  void initState() {
    super.initState();
    executeOnceAfterBuild();
    additionalInfo();
  } // - metoda odpowiedzialna za rozpoczecie inicjalizacji jakiegos stanu zwiazanego z funkcja

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: [
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              colors: [Color(0xFFD3C202), Colors.blue]),
        ),
      ),
      Container(
          alignment: Alignment.center,
          height: 170,
          width: 170,
          margin: EdgeInsets.fromLTRB(10, 0, 10, 70),
          decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0)),
          child: Image.asset(
            'images/hello_.png',
            height: 250,
            width: 250,
            scale: 1.25,
          )),
      Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(10, 140, 10, 0),
        child: Text('Witaj uzytkowniku!' + BasicData.userName,
            style: GoogleFonts.anton(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 23,
                    color: Color(0x000B73E1)))),
      ),
      Positioned(
        left: 0,
        right: 0,
        bottom: 25,
        child: Container(
          alignment: Alignment.center,
          child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
                backgroundColor: Color(0xFFC4A336),
              ),
              onPressed: () => {goToPage()},
              child: Text(
                "Przejdz na glowna",
              )),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      )
    ]));
  }
}

class BasicData {
  static const String userName = "Jozef";
}
