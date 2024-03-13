import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiinkassa_flutter/service/ordering_products.dart';
part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(AddProductInitial()) {
    on<SaveProductEvent>(_refreshData);
  }
  Future<void> _refreshData(
    SaveProductEvent event,
    Emitter<AddProductState> emit,
  ) async {
    bool isNext = false;

    isNext = await OrderedSingelton.addProduct(
      name: event.name,
      qcounter: event.qcounter,
      barcode: event.barcode,
      productPrice: event.productPrice,
      sku: 0,
    );

    if (isNext == true) {
      emit(AddedProductsSuccesState());
    } else {
      emit(ErrorProductsState());
    }
  }
}
