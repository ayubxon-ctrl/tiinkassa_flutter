import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tiinkassa_flutter/service/ordering_products.dart';

part 'addnoproduct_event.dart';
part 'addnoproduct_state.dart';

class AddnoproductBloc extends Bloc<AddnoproductEvent, AddnoproductState> {
  AddnoproductBloc() : super(AddnoproductInitial()) {
    on<AddtoHiveEvent>(addnoProduct);
  }
  Future<void> addnoProduct(
    AddtoHiveEvent event,
    Emitter<AddnoproductState> emit,
  ) async {
    bool isClosed = false;
    isClosed = OrderedSingelton.addNoProduct(
        barcode: event.barcode,
        productPrice: event.productPrice,
        productName: event.name,
        counter: event.counter,
        qcounter: event.qcounter);
    if (isClosed == true) {
      emit(AddtoHiveState());
    }
  }
}
