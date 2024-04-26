import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tiinkassa_flutter/Hive/hive_class.dart';
import 'package:tiinkassa_flutter/Hive/hive_instance_class.dart';
import 'package:tiinkassa_flutter/bloc/cardsifatidaq/addptocard_bloc.dart';
import 'package:tiinkassa_flutter/bloc/getData/getdata_bloc.dart';
import 'package:tiinkassa_flutter/bloc/yangi%20qoshuvch/add_product_bloc.dart';
import 'package:tiinkassa_flutter/model/view_model.dart';
import 'package:tiinkassa_flutter/ui/left_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await HiveBoxes.lastSku.put("detectSku", 1000);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) {
        return ProductsViewProvider();
      },
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddProductBloc()),
        BlocProvider(create: (context) => AddptocardBloc()),
        BlocProvider(create: (context) => GetdataBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const MyWidget(),
      ),
    );
  }
}

bool canPlaceFlowers(List<int> flowerbed, int n) {
  List<int> toq = [];
  List<int> juft = [];

  int countT = 0;
  int countJ = 0;

  for (int i = 0; i < flowerbed.length; i++) {
    if (i % 2 == 0) {
      juft.add(flowerbed[i]);
    } else {
      toq.add(flowerbed[i]);
    }
  }

  for (int s = 0; s < juft.length; s++) {
    print(' case 1');
    if (juft[s] == 0) {
      countJ++;
      print(' case 2 $countJ');
    }
    if (toq[s] == 0) {
      countT++;
    }
  }

  if (juft.length == countJ) {
    print(' case 4 ');

    if (countT == n) {
      print(' case 5');
      return true;
    }
  }
  if (toq.length == countT) {
    print(' case 6 ');
    if (countJ == n) {
      return true;
    }
  }
  return false;
}

class Solution {
  bool canPlaceFlowers(List<int> flowerbed, int n) {
    List<int> toq = [];
    List<int> juft = [];
    int countT = 0;
    int countJ = 0;
    for (int i = 0; i < flowerbed.length; i++) {
      if (i % 2 == 0) {
        juft.add(flowerbed[i]);
      } else {
        toq.add(flowerbed[i]);
      }
    }
    for (int s = 0; s < juft.length; s++) {
      if (juft[s] == 0) {
        countJ++;
      }
    }
    for (int e = 0; e < toq.length; e++) {
      if (toq[e] == 0) {
        countT++;
      }
    }

    if (juft.length == countJ && countT >= n) {
      return true;
    }
    if (toq.length == countT && countJ >= n) {
      return true;
    }
    return false;
  }
} 










/// flutter packages pub r$un build_runner build 
/// /// flutter packages pub run build_runner build --delete-conflicting-outputs
/// 