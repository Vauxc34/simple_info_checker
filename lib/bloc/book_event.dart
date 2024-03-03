sealed class BookEvent {}

// zeby akcje, ktore ma wykonac nakladka, zdarzen(eventow) - zostaly zrobione
// w pliku wykonawczym, powinnismy zastosowac sie do uzycia klasy sealed, dla
// klasy wlasciwej, zeby kolejno nizej rozszerzyc za jego pomoca klasy
// nizej

final class BookChangeName extends BookEvent {}

final class BookAddFullNameAuthor extends BookEvent {}
