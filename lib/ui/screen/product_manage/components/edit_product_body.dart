import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/bloc/product/product_bloc.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/product_manage/components/data_form.dart';

class EditProdductBody extends StatefulWidget {
  const EditProdductBody({
    Key? key,
    required this.user,
    required this.category,
    required this.product,
  }) : super(key: key);
  final User user;
  final Category category;
  final Product product;

  @override
  State<EditProdductBody> createState() => _EditProdductBodyState();
}

class _EditProdductBodyState extends State<EditProdductBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(GetProductsList()),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SizeConfig.defaultPadding / 2,
                horizontal: SizeConfig.defaultPadding,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: SizeConfig.defaultPadding / 2,
                    ),
                    ProductDataForm(
                      product: widget.product,
                      category: widget.category,
                      user: widget.user,
                      mode: "EDIT",
                    ),
                    const SizedBox(
                      height: SizeConfig.defaultPadding / 2,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
