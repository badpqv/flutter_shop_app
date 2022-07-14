import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_shop_app/api_repository/api_repository.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiRepository repository = ApiRepository();
  ProductBloc() : super(ProductInitial()) {
    on<GetProductsList>((event, emit) async {
      emit(ProductLoading());
      var products = await repository.fetchProductsList();
      emit(
        ProductLoaded(
          products: products,
          categories: await repository.fetchCategoriesList(),
        ),
      );
    });
    on<GetFilteredProductsList>((event, emit) async {
      emit(ProductLoading());
      var products = await repository.fetchProductsList();
      emit(
        ProductLoaded(
          products: products
              .where((element) => element.categoryId == event.category.id)
              .toList(),
          categories: await repository.fetchCategoriesList(),
        ),
      );
    });
    on<AddProduct>(
      (event, emit) async {
        List<String> imageNames = [];
        if (state is ProductLoaded) {
          try {
            for (int i = 0; i < event.images.length; i++) {
              await repository.saveImage(
                  "${event.product.title}_${i + 1}", event.images[i]);
              imageNames.add(
                  "http://192.168.1.5:5000/images/${event.product.title}_${i + 1}.${event.images[i].path.split("/").last.split(".").last}");
            }
            var product = Product(
              id: event.product.id,
              images: imageNames.join(","),
              colors: event.product.colors,
              rating: event.product.rating,
              price: event.product.price,
              title: event.product.title,
              description: event.product.description,
              isFavourite: event.product.isFavourite,
              isPopular: event.product.isPopular,
              categoryId: event.product.categoryId,
            );
            await repository.postProduct(product);

            var productsAfterPost = await repository.fetchProductsList();
            var categories = await repository.fetchCategoriesList();
            var categoryId = categories
                .firstWhere((element) => element.id == event.product.categoryId)
                .id;
            emit(
              ProductLoaded(
                products: productsAfterPost
                    .where((element) => element.categoryId == categoryId)
                    .toList(),
                categories: categories,
              ),
            );
          } on NetworkError {
            emit(
              const ProductLoaded(
                products: [],
                categories: [],
              ),
            );
          }
        }
      },
    );
    on<EditProduct>(
      (event, emit) async {
        List<String> imageNames = [];

        if (state is ProductLoaded) {
          try {
            for (int i = 0; i < event.images.length; i++) {
              await repository.saveImage(
                  "${event.product.title}_${i + 1}", event.images[i]);
              imageNames.add(
                  "http://192.168.1.5:5000/images/${event.product.title}_${i + 1}.${event.images[i].path.split("/").last.split(".").last}");
            }
            var product = Product(
              id: event.product.id,
              images: imageNames.join(","),
              colors: event.product.colors,
              rating: event.product.rating,
              price: event.product.price,
              title: event.product.title,
              description: event.product.description,
              isFavourite: event.product.isFavourite,
              isPopular: event.product.isPopular,
              categoryId: event.product.categoryId,
            );
            await repository.editProduct(product, int.parse(event.product.id));
            emit(
              ProductLoaded(
                products: await repository.fetchProductsList(),
                categories: await repository.fetchCategoriesList(),
              ),
            );
          } on NetworkError {
            emit(
              const ProductLoaded(
                products: [],
                categories: [],
              ),
            );
          }
        }
      },
    );
    on<DeleteProduct>((event, emit) async {
      emit(ProductDeleting());
      var productsAfterDelete = await repository.deleteProduct(
        int.parse(event.product.id),
      );
      var categories = await repository.fetchCategoriesList();
      var categoryId = categories
          .firstWhere((element) => element.id == event.product.categoryId)
          .id;

      emit(
        ProductLoaded(
          products: productsAfterDelete
              .where((element) => element.categoryId == categoryId)
              .toList(),
          categories: categories,
        ),
      );
    });
  }
}
