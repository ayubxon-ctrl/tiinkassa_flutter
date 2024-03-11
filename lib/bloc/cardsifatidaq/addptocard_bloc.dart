import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiinkassa_flutter/service/ordering_products.dart';

part 'addptocard_event.dart';
part 'addptocard_state.dart';

class AddptocardBloc extends Bloc<AddptocardEvent, AddptocardState> {
  AddptocardBloc() : super(AddptocardInitial()) {
    on<AddPtoCardEvent>(addHive);
  }
  Future<void> addHive(
    AddPtoCardEvent event,
    Emitter<AddptocardState> emit,
  ) async {
    bool isAdded = false;
    isAdded = OrderedSingelton.addmyBox();
    if (isAdded == true) {
      emit(AddtoHivedState());
    } else {}
  }
}
