import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_app/api_repository/api_repository.dart';
import 'package:flutter_shop_app/bloc/category/category_bloc.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/components/custom_btn.dart';
import 'package:flutter_shop_app/ui/components/form_errors.dart';
import 'package:flutter_shop_app/ui/screen/category_manage/category_list.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_windows/image_picker_windows.dart';

class CategoryDataForm extends StatefulWidget {
  const CategoryDataForm(
      {Key? key,
      required this.user,
      required this.mode,
      required this.category})
      : super(key: key);
  final User user;
  final String mode;
  final Category category;
  @override
  State<CategoryDataForm> createState() => _CategoryDataFormState();
}

class _CategoryDataFormState extends State<CategoryDataForm> {
  final ApiRepository repository = ApiRepository();
  final ImagePicker _picker = ImagePicker();
  final ImagePickerWindows _pickerWindows = ImagePickerWindows();

  List<String> errors = [];

  String categoryName = "";
  String categoryIcon = "";
  final _formKey = GlobalKey<FormState>();
  File? image;
  addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error!);
      });
    }
  }

  Future pickGalleryImage() async {
    try {
      var pickedImage = !Platform.isWindows
          ? await _picker.pickImage(source: ImageSource.gallery)
          : await _pickerWindows.getImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      setState(() {
        image = File(pickedImage.path);
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      return;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.mode == "EDIT") {
      categoryIcon = widget.category.icon;
      categoryName = widget.category.title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc()..add(GetCategoriesList()),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: SizeConfig.defaultPadding / 2,
                ),
                buildCategoryNameFormField(),
                const SizedBox(
                  height: SizeConfig.defaultPadding / 2,
                ),
                TextButton.icon(
                  onPressed: () async {
                    pickGalleryImage();
                  },
                  icon: const Icon(
                    FontAwesome5.image,
                  ),
                  label: const Text(
                    "Chọn biểu tượng danh mục",
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(
                  height: SizeConfig.defaultPadding / 2,
                ),
                image == null
                    ? const Center(
                        child: Text("No image"),
                      )
                    : Image.file(
                        image!,
                        width: 150,
                      ),
                const SizedBox(
                  height: SizeConfig.defaultPadding / 2,
                ),
                FormErrors(errors: errors),
                CustomButton(
                  text: widget.mode == "ADD"
                      ? "Thêm danh mục"
                      : "Cập nhật thông tin danh mục",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (widget.mode == "ADD") {
                        final Category category = Category(
                          id: widget.category.id,
                          icon: categoryIcon,
                          title: categoryName,
                        );
                        context.read<CategoryBloc>().add(
                              AddCategory(category: category, image: image!),
                            );
                        var snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: AppColors.primaryColor,
                          content: const Text("Thêm thành công"),
                          action: SnackBarAction(
                              label: "Về xem",
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  CategoryListScreen.routeName,
                                  arguments: CategoryListArguments(
                                    categories: state is CategoryLoaded
                                        ? state.categories
                                        : [],
                                    user: widget.user,
                                  ),
                                );
                              }),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {}
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  TextFormField buildCategoryNameFormField() {
    return TextFormField(
      initialValue: categoryName,
      onSaved: (newValue) => categoryName = newValue!,
      onChanged: (value) {
        removeError(error: "Mời nhập tên danh mục");
        if (value.isNotEmpty) {
          setState(() {
            categoryName = value;
          });
        }
      },
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Mời nhập tên danh mục");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Tên danh mục",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nhập tên danh mục",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultPadding * 2,
          vertical: SizeConfig.defaultPadding * 1.5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: SizeConfig.defaultPadding,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeConfig.defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: SizeConfig.defaultPadding,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.all(SizeConfig.defaultPadding),
          child: Icon(
            Icons.abc_outlined,
            size: 30,
          ),
        ),
      ),
    );
  }
}
