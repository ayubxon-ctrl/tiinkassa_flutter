import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tiinkassa_flutter/Hive/hive_instance_class.dart';
import 'package:tiinkassa_flutter/bloc/cardsifatidaq/addptocard_bloc.dart';
import 'package:tiinkassa_flutter/bloc/yangi%20qoshuvch/add_product_bloc.dart';
import 'package:tiinkassa_flutter/model/totalproduct/totalproduct_model.dart';
import '../model/category/category_model.dart';
import '../model/mainbox/mainbox_model.dart';
import '../model/view_model.dart';

class RightPage extends StatefulWidget {
  const RightPage({super.key});
  @override
  State<RightPage> createState() => _RightPageState();
}

class _RightPageState extends State<RightPage> {
  TextEditingController barcode = TextEditingController();
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  int counter = 1000;
  num totalP = 0;
  int qcounter = 1;
  List<TotalProduct> allPrice = [];
  FocusNode myFocusNode = FocusNode();
  CategoryForSale? catModel = CategoryForSale();
  List<CategoryForSale> categoryproduct =
      HiveBoxes.prefsBox.values.toList().cast();
  List<TotalProduct> totalProduct = HiveBoxes.totalPriceBox.values.toList();
  List<MainBoxModel> mainBox = HiveBoxes.mainBox.values.toList();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.927,
      width: MediaQuery.of(context).size.width * 0.527,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Productable(
              sku: 'Sku',
              name: 'Name',
              price: 'Price',
              quantity: 'Quantity',
              totalPrice: 'TotalPrice'),
          BlocConsumer<AddProductBloc, AddProductState>(
              listener: (context, state) {
            if (state is AddedProductsSuccesState) {
              totalProduct = HiveBoxes.totalPriceBox.values.toList();
            }
          }, builder: (context, state) {
            return Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.383,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: totalProduct.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  customBorder: Border.all(color: Colors.red),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          actions: [
                                            SizedBox(
                                              child: Column(
                                                children: [
                                                  const SizedBox(height: 20),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: TextField(
                                                      keyboardType:
                                                          TextInputType.name,
                                                      readOnly: true,
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              totalProduct[
                                                                      index]
                                                                  .name,
                                                          border:
                                                              const OutlineInputBorder()),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: TextField(
                                                      autofocus: true,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller: productPrice,
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              '${totalProduct[index].price}',
                                                          border:
                                                              const OutlineInputBorder()),
                                                      onSubmitted: (value) {
                                                        totalProduct[index]
                                                                .price =
                                                            int.parse(
                                                                productPrice
                                                                    .text);
                                                        BlocProvider.of<
                                                                    AddptocardBloc>(
                                                                context)
                                                            .add(
                                                                AddPtoCardEvent());
                                                        BlocProvider.of<AddProductBloc>(context).add(SaveProductEvent(
                                                            category:
                                                                "No Category",
                                                            type: "each",
                                                            qcounter: qcounter,
                                                            barcode: totalProduct[
                                                                        index]
                                                                    .barcode ??
                                                                "",
                                                            productPrice:
                                                                totalProduct[
                                                                            index]
                                                                        .price ??
                                                                    0,
                                                            sku: totalProduct[
                                                                        index]
                                                                    .sku ??
                                                                0,
                                                            name: totalProduct[
                                                                        index]
                                                                    .name ??
                                                                ''));
                                                        totalProduct[index]
                                                                .quantity =
                                                            (totalProduct[index]
                                                                    .quantity! -
                                                                1);
                                                        productPrice.text = '';
                                                        barcode.clear();

                                                        myFocusNode
                                                            .requestFocus();
                                                        setState(() {});
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: table(
                                    sku: totalProduct[index].sku.toString(),
                                    name: totalProduct[index].name.toString(),
                                    price: totalProduct[index].price.toString(),
                                    quantity:
                                        totalProduct[index].quantity.toString(),
                                    totalPrice:
                                        '${(totalProduct[index].price ?? 0) * (totalProduct[index].quantity ?? 0)}',
                                  ));
                            })
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
          BlocConsumer<AddProductBloc, AddProductState>(
            listener: (context, state) {
              if (state is AddedProductsSuccesState) {
                totalP = 0;
                for (var element in totalProduct) {
                  totalP =
                      totalP + ((element.quantity ?? 0) * (element.price ?? 0));
                }
              }
            },
            builder: (context, state) {
              return Consumer<ProductsViewProvider>(
                builder: (context, value, child) {
                  if (ProductsViewProvider().chechIsnotEmpty.isNotEmpty) {
                    return totalP != 0
                        ? Padding(
                            padding: const EdgeInsets.only(right: 0, left: 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1,
                              height: 165,
                              color: const Color.fromARGB(255, 17, 30, 63),
                              child: Column(
                                children: [
                                  Row(children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 8),
                                      child: Text(
                                        'Total Price',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 355),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0, top: 8),
                                        child: SizedBox(
                                            width: 200,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "${totalP.toString()} sum",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  )
                                                ])))
                                  ]),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 13),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          backgroundColor:
                                              Colors.indigo.shade700,
                                          minimumSize: const Size(900, 110)),
                                      onPressed: () {
                                        myFocusNode.requestFocus();
                                        totalP = 0;
                                        totalProduct = [];
                                        HiveBoxes.totalPriceBox.clear();
                                        setState(() {});
                                      },
                                      child: const Text(
                                        'Sell',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : const Text('');
                  } else {
                    return const Text('');
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget table(
      {required String sku,
      required String name,
      required String price,
      required String quantity,
      required String totalPrice}) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 12,
                      child: SizedBox(
                          height: 30,
                          child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                sku,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              )))),
                  Expanded(
                      flex: 68,
                      child: SizedBox(
                          height: 38,
                          child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              )))),
                  Expanded(
                      flex: 25,
                      child: SizedBox(
                          height: 30,
                          child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                price.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              )))),
                  Expanded(
                      flex: 25,
                      child: SizedBox(
                          height: 30,
                          child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(quantity.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500))))),
                  Expanded(
                      flex: 32,
                      child: SizedBox(
                          height: 30,
                          child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                totalPrice.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ))))
                ]),
            const Divider(
              thickness: 2,
              color: Color.fromARGB(255, 17, 30, 63),
            )
          ],
        ));
  }

  Widget Productable(
      {required String name,
      required String price,
      required String quantity,
      required String totalPrice,
      required String sku}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 12,
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 17, 30, 63), width: 2))),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    sku.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 68,
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(
                          color: Color.fromARGB(255, 17, 30, 63),
                          width: 2,
                        ),
                        right: BorderSide(
                            color: Color.fromARGB(255, 17, 30, 63), width: 2),
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 17, 30, 63), width: 2))),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 25,
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            color: Color.fromARGB(255, 17, 30, 63), width: 2),
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 17, 30, 63), width: 2))),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    price.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 25,
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            color: Color.fromARGB(255, 17, 30, 63), width: 2),
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 17, 30, 63), width: 2))),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    quantity.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 32,
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(
                          color: Color.fromARGB(255, 17, 30, 63),
                          width: 2,
                        ),
                        bottom: BorderSide(
                            color: Color.fromARGB(
                              255,
                              17,
                              30,
                              63,
                            ),
                            width: 2))),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    totalPrice.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Solution {
  // int countSegments(String s) {
  //   if (s != "") {
  //     List<String> a = s.split(" ");
  //     List f = a.where((element) => element == "").toList();

  //     if (f.length == a.length) {
  //       return 0;
  //     }
  //     return a.length;
  //   } else {
  //     return 0;
  //   }
  // }
  int countSegments(String s) {
    s.split("");
    print(s.split("").length);
    int k = 0;
    List acsiiTable = s.split("");
    for (int i = 0; i < acsiiTable.length; i++) {
      if (acsiiTable[i].chargdzmb == "" && acsiiTable[i - 1] != acsiiTable[i] && i != 0) {
        k++;
      }
    }
    return k;
  }
}
