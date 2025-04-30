import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/local_product_repository.dart';

import '../data/repositories/product_repository.dart';
import 'product_bloc.dart';

class ListBlocProvider extends StatelessWidget {
  final Widget child;
  final LocalProductRepository repository;

  const ListBlocProvider({
    super.key,
    required this.child,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(repository: repository),
      child: child,
    );
  }
}
