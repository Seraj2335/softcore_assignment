import 'package:assignment/bloc/product_bloc_provider.dart';
import 'package:assignment/presentation/product_page.dart';
import 'package:flutter/material.dart';
import 'data/repositories/local_product_repository.dart';

void main() {
  runApp(ListBlocProvider(
      repository: LocalProductRepository(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ListViewPage());
    // home: BlocProvider(
    //     create: (context) => ListViewBloc(), child: ListPage()));
  }
}
