// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiinkassa_flutter/Hive/hive_instance_class.dart';
import 'package:tiinkassa_flutter/bloc/getData/getdata_bloc.dart';
import 'package:tiinkassa_flutter/bloc/yangi%20qoshuvch/add_product_bloc.dart';
import 'package:tiinkassa_flutter/bloc/cardsifatidaq/addptocard_bloc.dart';

import 'package:tiinkassa_flutter/model/mainbox/mainbox_model.dart';
import 'package:tiinkassa_flutter/model/category/category_model.dart';
import 'package:tiinkassa_flutter/model/totalproduct/totalproduct_model.dart';
import 'package:tiinkassa_flutter/service/excel_cretate.dart';
import 'package:tiinkassa_flutter/service/ordering_products.dart';
import 'package:tiinkassa_flutter/ui/right_page.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  TextEditingController barcode = TextEditingController();
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  int counter = 0;
  num totalP = 0;
  List<TotalProduct> allPrice = [];
  List<MainBoxModel> boxM = [];
  FocusNode myFocusNode = FocusNode();
  CategoryForSale? catModel = CategoryForSale();
  List<CategoryForSale> categoryproduct =
      HiveBoxes.prefsBox.values.toList().cast();
  List<TotalProduct> totalProduct = HiveBoxes.totalPriceBox.values.toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 11, 18, 35),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.058,
                decoration: const BoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            onTap: () {
                              OrderedSingelton.getAllProducts();

                              myFocusNode.requestFocus();
                            },
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Container(
                                  child: Center(
                                      child: Image.asset(
                                'assets/invan_logo.png',
                                width: 170,
                                height: 45,
                              ))),
                            )))),
                    const SizedBox(width: 700),
                    BlocConsumer<GetdataBloc, GetdataState>(
                        listener: (context, state) {
                      if (state is GetSuccesState) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("Loading Succesfually finished"),
                        ));
                      }
                      if (state is GetFailureState) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text("Loading Failure !!!"),
                        ));
                      }
                    }, builder: (context, state) {
                      return state is GetProccestate
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : IconButton(
                              onPressed: () async {
                                BlocProvider.of<GetdataBloc>(context)
                                    .add(GetDownloadEvent());
                                myFocusNode.requestFocus();
                              },
                              icon: const Icon(
                                Icons.download,
                                color: Colors.white,
                              ),
                              iconSize: 25,
                            );
                    }),
                    IconButton(
                        onPressed: () {
                          HiveBoxes.mainBox.clear();
                          HiveBoxes.totalPriceBox.clear();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text("Clear All Data"),
                          ));
                          myFocusNode.requestFocus();
                          setState(() {});
                        },
                        iconSize: 25,
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {
                          ExcelService().extractFile(boxM);
                          myFocusNode.requestFocus();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text("Your All Data Saved Excel File"),
                          ));
                          setState(() {});
                        },
                        iconSize: 25,
                        icon: const Icon(
                          Icons.file_copy_outlined,
                          color: Colors.white,
                        )),
                    const SizedBox(width: 1),
                  ],
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              color: const Color.fromARGB(255, 17, 30, 63),
            ),
            Row(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.47,
                    height: MediaQuery.of(context).size.height * 0.927,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 18, bottom: 11, top: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6)),
                              child: SizedBox(
                                height: 50,
                                child: TextField(
                                  autofocus: true,
                                  focusNode: myFocusNode,
                                  cursorColor:
                                      const Color.fromARGB(255, 11, 18, 35),
                                  decoration: const InputDecoration(
                                    floatingLabelStyle:
                                        TextStyle(color: Colors.red),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedBorder: OutlineInputBorder(),
                                    hintText: "Enter barcode",
                                  ),
                                  controller: barcode,
                                  onSubmitted: (value) {
                                    catModel = HiveBoxes.prefsBox.get(
                                      barcode.text,
                                    );

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
                                                      controller: productName,
                                                      keyboardType:
                                                          TextInputType.name,
                                                      readOnly:
                                                          catModel?.name == null
                                                              ? false
                                                              : true,
                                                      autofocus:
                                                          catModel?.name == null
                                                              ? true
                                                              : false,
                                                      decoration: InputDecoration(
                                                          hintText: catModel
                                                                  ?.name ??
                                                              'product name',
                                                          border:
                                                              const OutlineInputBorder()),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            7.0),
                                                    child: TextField(
                                                      autofocus: catModel
                                                                  ?.barcode
                                                                  .toString() ==
                                                              barcode.text
                                                          ? true
                                                          : false,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller: productPrice,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  'Product price',
                                                              border:
                                                                  OutlineInputBorder()),
                                                      onSubmitted: (value) {
                                                        if (catModel != null) {
                                                          BlocProvider.of<
                                                                      AddProductBloc>(
                                                                  context)
                                                              .add(
                                                                  SaveProductEvent(
                                                            category:
                                                                'No Categoy',
                                                            type: 'each',
                                                            name: catModel?.name
                                                                    .toString() ??
                                                                '',
                                                            qcounter: 1,
                                                            barcode:
                                                                barcode.text,
                                                            productPrice:
                                                                num.parse(
                                                                    productPrice
                                                                        .text),
                                                            sku: 0,
                                                          ));
                                                        } else {
                                                          BlocProvider.of<
                                                                      AddProductBloc>(
                                                                  context)
                                                              .add(
                                                                  SaveProductEvent(
                                                            category:
                                                                "No Category",
                                                            type: "each",
                                                            name: productName
                                                                .text,
                                                            qcounter: 1,
                                                            barcode:
                                                                barcode.text,
                                                            productPrice:
                                                                num.parse(
                                                                    productPrice
                                                                        .text),
                                                            sku: 0,
                                                          ));
                                                        }
                                                        BlocProvider.of<
                                                                    AddptocardBloc>(
                                                                context)
                                                            .add(
                                                                AddPtoCardEvent());

                                                        barcode.clear();

                                                        productName.text = '';
                                                        productPrice.text = '';

                                                        myFocusNode
                                                            .requestFocus();

                                                        Navigator.pop(context);

                                                        setState(() {});
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
                                ),
                              ),
                            ),
                          ),
                          BlocConsumer<AddptocardBloc, AddptocardState>(
                              listener: (context, state) {
                            if (state is AddtoHivedState) {
                              boxM = HiveBoxes.mainBox.values.toList();
                            }
                          }, builder: (context, state) {
                            return Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.804,
                                        width: 568,
                                        child: GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                1.4),
                                                    crossAxisCount: 4,
                                                    crossAxisSpacing: 12,
                                                    mainAxisExtent: 150,
                                                    mainAxisSpacing: 12),
                                            itemCount: boxM.length,
                                            itemBuilder: (context, index) {
                                              if (boxM[index].name != null) {
                                                return InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  onTap: () {
                                                    BlocProvider.of<
                                                                AddProductBloc>(
                                                            context)
                                                        .add(SaveProductEvent(
                                                      category: 'No Category',
                                                      type: "each",
                                                      barcode: boxM[index]
                                                          .barcode
                                                          .toString(),
                                                      sku: boxM[index].sku!,
                                                      productPrice:
                                                          boxM[index].price ??
                                                              0,
                                                      qcounter: boxM[index]
                                                              .quantity ??
                                                          0,
                                                      name: boxM[index].name ??
                                                          "",
                                                    ));
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 110),
                                                      child: Container(
                                                        decoration: const BoxDecoration(
                                                            color: Color
                                                                .fromARGB(
                                                                    205,
                                                                    122,
                                                                    185,
                                                                    237),
                                                            borderRadius: BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10))),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 5,
                                                                  top: 2),
                                                          child: Text(
                                                            boxM[index]
                                                                .name
                                                                .toString(),
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return null;
                                              }
                                            }))));
                          })
                        ])),
                ///////Right Page////////////////////
                Container(
                  width: 2,
                  height: MediaQuery.of(context).size.height * 0.93,
                  color: const Color.fromARGB(255, 17, 30, 63),
                ),
                const RightPage()
              ],
            ),
          ],
        ));
  }
}
