import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_books/domain/usecases/firestore/get_all_books_usecase.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final GetAllBooksUseCase getAllBooksUseCase;

  StoreBloc({
    required this.getAllBooksUseCase,
  }) : super(StoreInitial()) {
    on<StoreEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
