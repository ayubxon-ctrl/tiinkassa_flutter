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
/// flutter packages pub run build_runner build 
/// /// flutter packages pub run build_runner build --delete-conflicting-outputs