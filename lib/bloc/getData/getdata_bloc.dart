// ignore_for_file: unused_element

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiinkassa_flutter/Hive/hive_instance_class.dart';
import 'package:tiinkassa_flutter/model/category/category_model.dart';
import 'package:tiinkassa_flutter/model/view_model.dart';
part 'getdata_event.dart';
part 'getdata_state.dart';

class GetdataBloc extends Bloc<GetdataEvent, GetdataState> {
  GetdataBloc() : super(GetdataInitial()) {
    on<GetDownloadEvent>(downLoadata);
  }
  Future<void> downLoadata(
    GetDownloadEvent event,
    Emitter<GetdataState> emit,
  ) async {
    emit(GetProccestate());

    List<CategoryForSale> allProducts =
        await ProductsViewProvider().getAllProducts();
    for (var iteam in allProducts) {
      if (iteam.barcode.toString() != '') {
        HiveBoxes.prefsBox.put(iteam.barcode.toString(), iteam);
      }
    }
    if (allProducts.isNotEmpty) {
      emit(GetSuccesState());
    } else {
      emit(GetFailureState());
    }
  }
}
