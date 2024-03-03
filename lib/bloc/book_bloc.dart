import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersomeapp/bloc/book_event.dart';
import 'package:fluttersomeapp/bloc/book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BookState(title: 'Wesele')) {
    // akcje, po odniesieniu sie albo do pojedynczego elementu, albo zbioru eventow opisanego
    // wyzej, definiujemy za pomoca metod nizej:

    on<BookChangeName>((event, emit) => emit(BookState(title: 'Wesele')));

    on<BookAddFullNameAuthor>(
        (event, emit) => emit(BookState(title: 'Wesele - Wyspianski')));
  }
}
