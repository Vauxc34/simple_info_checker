import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersomeapp/bloc/book_bloc.dart';
import 'package:fluttersomeapp/flights.dart';
import 'package:fluttersomeapp/listbooks.dart';
import 'package:fluttersomeapp/main.dart';
import 'package:fluttersomeapp/status.dart';
import 'package:weather/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/* 

 Gdyby czasem nie bylo paczek:

 The issue is due to the missing packages which are being used in the project. Therefore, in order to install the same, navigate to the folder where the project is present -> cmd -> execute the following commands:

-- flutter packages get

-- flutter packages upgrade
 
 */

List<String> users = ["Arnold", "Marcel", "Jozef"];

class Home extends StatefulWidget {
  Home({this.weather, this.air});
  final QualityOfAir? air;
  final Weather? weather;

  @override
  State<StatefulWidget> createState() {
    return _PageDetails();
  }
}

Widget _PendingCardDonor(String name) {
  return InkWell(
    onTap: () {},
    child: Container(
        height: 200, width: 200, color: Colors.amber, child: Text("$name")),
  );
}

//https://stackoverflow.com/questions/67855344/flutter-how-to-map-list-of-array-to-widget

class _PageDetails extends State<Home> {
  int index__ = 0;

  var pages;

  @override
  void initState() {
    pages = [
      StatusScreen(weather: widget.weather),
      BlocProvider(create: (context) => BookBloc(), child: const ListBooks()),
      Flights()
    ];
    super.initState();
  }

  // dzieki wykorzystaniu provider'a wyzej - jestesmy w stanie korzystac, ze stanu
// bloc, w kazdym miejscu naszej aplikacji, gdyz wszystko jest przekazywane
// przez nas w kontekscie wyzej

  /* 
  
  IndexedStack(
    index: index__,
    children: pages
  ) - powyzsza metoda odnosi sie bezposrednio do elementow strony i
  ich pogrupowania wedlug indexu okresolnego przez uzytkownika
  ta metoda, jest po to, zeby stan aplikacji - jako stack zostal zachowany 
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 206, 177, 89),
        body: IndexedStack(index: index__, children: pages),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index__,
          onTap: (index) => {
            setState(() => index__ = index),
          },
          selectedItemColor: Color(0xFFFFFFFF),
          unselectedItemColor: Color(0xFF000000),
          backgroundColor: Colors.deepOrangeAccent,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                // do wartosci navigation bottom bar, jestesmy w stanie dodac index, ktory umozliwi nam
                // odpowiednie zaznaczenie elementu na pasku nizej
                icon: Icon(Icons.home_max_outlined),
                label: 'Glowna'),
            BottomNavigationBarItem(
                icon: Icon(Icons.cloud_circle_outlined), label: 'Detale'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shop_2_outlined), label: 'Sklep'),
          ],
        ));
  }
}


/* 


Jezeli jeden provider nam nie wystarczy, to mozemy je spiac, w jeden fragment znany jako

MultiBlocProvider(
  providers: [
    ...Providery
  ]
)


jestesmy w stanie wywolac w strukturze, naszego widoku
obiekt, odpowiedzialny za nasluchiwanie zdarzen 
zwany jako BlocListener - zeby przebudowac komponent, powinno sie uzywac 
metody child, na koncu bloku, w ktorej mozemy kolejno umiescic jakikolwiek element

BlocListener<NazwaBloc, NazwaState> (
  listenWhen: (prevState, currentState) => false/true
  listener: (context, state) {
    if(warunek) {
      wywolanie jakiejkolwiek funkcji
    }
  }
)

BlocConsumer<NazwaBloc, NazwaState> (
  listenWhen: element funkcji wyzej
  listener: (context, state) {
    if(warunek) {
      wywolanie jakiejkolwiek funkcji
    }
  }
)
builder: ...elementy interfejsu

*/