// ignore_for_file: unused_local_variable, avoid_function_literals_in_foreach_calls, sized_box_for_whitespace, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiinkassa_flutter/Hive/hive_instance_class.dart';
import 'package:tiinkassa_flutter/bloc/addnoproduct/addnoproduct_bloc.dart';
import 'package:tiinkassa_flutter/bloc/cardsifatidaq/addptocard_bloc.dart';

import 'package:tiinkassa_flutter/bloc/yangi%20qoshuvch/add_product_bloc.dart';
import 'package:tiinkassa_flutter/model/category/category_model.dart';
import 'package:tiinkassa_flutter/model/mainbox/mainbox_model.dart';
import 'package:tiinkassa_flutter/model/totalproduct/totalproduct_model.dart';

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
  int qcounter = 0;
  List<TotalProduct> allPrice = [];
  FocusNode myFocusNode = FocusNode();
  CategoryForSale? catModel = CategoryForSale();
  List<CategoryForSale> categoryproduct =
      HiveBoxes.prefsBox.values.toList().cast();
  List<TotalProduct> totalProduct = HiveBoxes.totalPriceBox.values.toList();

  List<MainBoxModel> mainBox = HiveBoxes.mainBox.values.toList();

  @override
  Widget build(BuildContext context) {
    bool isSelected = false;

    return Container(
      height: MediaQuery.of(context).size.height * 0.87,
      width: MediaQuery.of(context).size.width * 0.52,
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
              if (state is AddedProductsState) {
                totalProduct = HiveBoxes.totalPriceBox.values.toList();
                isSelected = true;
              }
            },
            builder: (context, state) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.60,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlocConsumer<AddnoproductBloc, AddnoproductState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: totalProduct.length,
                            itemBuilder: (context, index) {
                              isSelected = true;
                              num tp = totalProduct[index].price! *
                                  totalProduct[index].quantity!;
                              totalProduct.forEach((element) {
                                var a = 1;
                                var b = element.price;

                                totalP = totalP + (a * b!);
                              });

                              return InkWell(
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
                                    quantity: '1',
                                    totalPrice: '$tp'.toString(),
                                  ));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 180,
              color: const Color.fromARGB(255, 17, 30, 63),
              child: Row(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const SizedBox(width: 5),
                          const Text(
                            'Total Price',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.12),
                          Container(
                            width: 200,
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  totalP.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        backgroundColor: Colors.indigo.shade700,
                        minimumSize: const Size(160, 160)),
                    onPressed: () {
                      BlocProvider.of<AddptocardBloc>(context)
                          .add(AddPtoCardEvent());
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
                  )
                ],
              ),
            ),
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
                flex: 11,
                child: Container(
                  color: Colors.red,
                  height: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      sku,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 60,
                child: Container(
                  height: 30,
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
                flex: 40,
                child: Container(
                  height: 30,
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
      ),
    );
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
              flex: 10,
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(
                          color: Color.fromARGB(255, 17, 30, 63),
                          width: 3,
                        ),
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 17, 30, 63), width: 3))),
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
              flex: 60,
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(
                          color: Color.fromARGB(255, 17, 30, 63),
                          width: 3,
                        ),
                        right: BorderSide(
                            color: Color.fromARGB(255, 17, 30, 63), width: 3),
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 17, 30, 63), width: 3))),
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
                            color: Color.fromARGB(255, 17, 30, 63), width: 3),
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 17, 30, 63), width: 3))),
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
                            color: Color.fromARGB(255, 17, 30, 63), width: 3),
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 17, 30, 63), width: 3))),
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
              flex: 40,
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(
                          color: Color.fromARGB(255, 17, 30, 63),
                          width: 3,
                        ),
                        bottom: BorderSide(
                            color: Color.fromARGB(
                              255,
                              17,
                              30,
                              63,
                            ),
                            width: 3))),
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
