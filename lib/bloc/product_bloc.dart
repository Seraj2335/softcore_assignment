import 'package:assignment/data/models/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../data/repositories/local_product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final LocalProductRepository repository;

  List<Product> products = [];
  int currentPage = 1;
  bool hasReachedMax = false;

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<FetchData>(_onFetchData);
    add(FetchData());
  }

  Future<void> _onFetchData(FetchData event, Emitter<ProductState> emit) async {
    if (hasReachedMax) return;

    // emit(ProductLoading());
    try {
      if (currentPage == 1) {
        emit(ProductLoading());
      } else {
        emit(ProductLoadingMore(products: products));
      }
      final data = await repository.getProduct(currentPage, 10);
      hasReachedMax = data.isEmpty;
      products.addAll(data);
      currentPage++;
      emit(ProductLoaded(data));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}

// Product Events
@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchData extends ProductEvent {}

// Product States
@immutable
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoadingMore extends ProductState {
  final List<Product> products;

  const ProductLoadingMore({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductLoaded extends ProductState {
  final List<Product> product;

  const ProductLoaded(this.product);

  @override
  List<Object> get props => [product];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
