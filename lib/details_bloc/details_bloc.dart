import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersomeapp/details_bloc/details_event.dart';
import 'package:fluttersomeapp/details_bloc/details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsState(isVisible: false)) {
    on<DetailSet>((event, emit) => emit(DetailsState(isVisible: true)));
    on<DetailsNotSet>((event, emit) => emit(DetailsState(isVisible: false)));
  }
}
