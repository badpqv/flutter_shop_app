import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/bloc/product/product_bloc.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/category_manage/components/data_form.dart';
import 'package:flutter_shop_app/ui/screen/product_manage/components/data_form.dart';

class EditCategoryBody extends StatefulWidget {
  const EditCategoryBody({
    Key? key,
    required this.user,
    required this.category,
  }) : super(key: key);
  final User user;
  final Category category;
  @override
  State<EditCategoryBody> createState() => _EditCategoryBodyState();
}

class _EditCategoryBodyState extends State<EditCategoryBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(GetProductsList()),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
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
                    CategoryDataForm(
                      user: widget.user,
                      mode: "EDIT",
                      category: widget.category,
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
