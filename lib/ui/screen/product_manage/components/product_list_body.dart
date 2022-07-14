import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/bloc/product/product_bloc.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/product_manage/add_product.dart';
import 'package:flutter_shop_app/ui/screen/product_manage/product_list.dart';
import 'package:intl/intl.dart';

import '../edit_product.dart';

class ProductListBody extends StatefulWidget {
  const ProductListBody(
      {Key? key,
      required this.category,
      required this.user,
      required this.callBack})
      : super(key: key);
  final Category category;
  final User user;
  final Function callBack;
  @override
  State<ProductListBody> createState() => _ProductListBodyState();
}

class _ProductListBodyState extends State<ProductListBody> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc()
            ..add(
              GetFilteredProductsList(category: widget.category),
            ),
        ),
      ],
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return Column(
            children: [
              Text(
                widget.category.title,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                    ),
                    child: TextButton.icon(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        AddProductScreen.routeName,
                        arguments: AddProductArguments(
                          category: widget.category,
                          user: widget.user,
                          callBack: widget.callBack,
                        ),
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text(
                        "Thêm sản phẩm",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        padding: const EdgeInsets.all(defaultPadding / 3),
                        backgroundColor: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              state is ProductLoaded
                  ? Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            childAspectRatio: 1.5,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            maxCrossAxisExtent: 300,
                            mainAxisExtent: 250,
                          ),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            return buildProductManageCard(
                                state, index, context);
                          }),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  Padding buildProductManageCard(
      ProductLoaded state, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: defaultPadding / 2,
        horizontal: defaultPadding / 2,
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              state.products[index].images.split(",")[0],
            ),
          ),
          const SizedBox(
            height: defaultPadding / 3,
          ),
          Text(
            state.products[index].title,
            style: const TextStyle(
              color: primaryColor,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 2,
          ),
          Text(
            NumberFormat.simpleCurrency(locale: "vi", decimalDigits: 0).format(
              state.products[index].price,
            ),
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          buildActionButtons(context, state, index)
        ],
      ),
    );
  }

  Row buildActionButtons(BuildContext context, ProductLoaded state, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          icon: const Icon(Icons.update),
          label: const Text(
            "Chỉnh sửa",
            maxLines: 1,
            style: TextStyle(
              fontSize: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: const Color(0xFFAFE1AF),
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              EditProductScreen.routeName,
              arguments: EditProductArguments(
                product: state.products[index],
                category: widget.category,
                user: widget.user,
                callBack: widget.callBack,
              ),
            );
          },
        ),
        TextButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (alertContext) => AlertDialog(
                title: const Text("Thông báo"),
                content: const Text("Bạn có chắc muốn xoá sản phẩm này không?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Huỷ",
                      style: TextStyle(color: Colors.red[200]),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<ProductBloc>().add(
                            DeleteProduct(product: state.products[index]),
                          );
                      state.products.removeAt(index);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(color: Colors.blue[200]),
                    ),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.remove),
          label: const Text(
            "Xoá",
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
          ),
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: const Color(0xFFFF4433),
          ),
        ),
      ],
    );
  }
}
