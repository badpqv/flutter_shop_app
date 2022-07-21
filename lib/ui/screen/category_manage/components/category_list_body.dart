import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/bloc/category/category_bloc.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/screen/category_manage/add_category_screen.dart';
import 'package:flutter_shop_app/ui/screen/category_manage/edit_category_scrren.dart';

class CategoryListBody extends StatefulWidget {
  const CategoryListBody(
      {Key? key, required this.categories, required this.user})
      : super(key: key);
  final List<Category> categories;
  final User user;
  @override
  State<CategoryListBody> createState() => _CategoryListBodyState();
}

class _CategoryListBodyState extends State<CategoryListBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryBloc()
        ..add(
          GetCategoriesList(),
        ),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: ((context, state) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SizeConfig.defaultPadding,
                    ),
                    child: TextButton.icon(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        AddCategoryScreen.routeName,
                        arguments: AddCategoryArguments(
                          user: widget.user,
                        ),
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text(
                        "Thêm danh mục",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        padding:
                            const EdgeInsets.all(SizeConfig.defaultPadding / 3),
                        backgroundColor: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              state is CategoryLoaded
                  ? Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            childAspectRatio: 1.5,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            maxCrossAxisExtent: 300,
                            mainAxisExtent: 200,
                          ),
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            return buildCategoryManageCard(
                                state, index, context);
                          }),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
            ],
          );
        }),
      ),
    );
  }

  Padding buildCategoryManageCard(
      CategoryLoaded state, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SizeConfig.defaultPadding / 2,
        horizontal: SizeConfig.defaultPadding / 2,
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              state.categories[index].icon,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: SizeConfig.defaultPadding / 3,
          ),
          Text(
            state.categories[index].title,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 2,
          ),
          buildActionButtons(context, state, index)
        ],
      ),
    );
  }

  Row buildActionButtons(
      BuildContext context, CategoryLoaded state, int index) {
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
              EditCategoryScreen.routeName,
              arguments: EditCategoryArguments(
                category: state.categories[index],
                user: widget.user,
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
                      context.read<CategoryBloc>().add(
                            DeleteCategory(
                              category: state.categories[index],
                            ),
                          );
                      Navigator.pop(context);
                      state.categories.removeAt(index);
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
