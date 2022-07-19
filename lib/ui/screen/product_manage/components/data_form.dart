import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_shop_app/api_repository/api_repository.dart';
import 'package:flutter_shop_app/bloc/product/product_bloc.dart';
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/models/category_model.dart';
import 'package:flutter_shop_app/models/product_model.dart';
import 'package:flutter_shop_app/models/user_model.dart';
import 'package:flutter_shop_app/ui/components/custom_btn.dart';
import 'package:flutter_shop_app/ui/components/form_errors.dart';
import 'package:flutter_shop_app/ui/components/rounded_icon_btn.dart';
import 'package:flutter_shop_app/ui/screen/details/components/colors_dot.dart';
import 'package:flutter_shop_app/ui/screen/product_manage/product_list.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:image_picker/image_picker.dart';

class ProductDataForm extends StatefulWidget {
  const ProductDataForm({
    Key? key,
    required this.category,
    required this.user,
    required this.mode,
    required this.product,
  }) : super(key: key);
  final Category category;
  final User user;
  final Product product;
  final String mode;

  @override
  State<ProductDataForm> createState() => _ProductDataFormState();
}

class _ProductDataFormState extends State<ProductDataForm> {
  final ApiRepository repository = ApiRepository();
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

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return const Color(0xFF836DB8);
    }
    return const Color(0xFFF6625E);
  }

  String productName = "";
  String description = "";
  String images = "";
  String colors = "";
  double rating = 2.5;
  double price = 0;
  double maxPrice = 0;
  bool isFavourite = false;
  bool isPopular = false;
  List<String> selectColors = [];
  List<String> LNType = [
    "Bản thông thường",
    "Bản đặc biệt",
  ];

  List<File> listImages = [];

  final ImagePicker _picker = ImagePicker();
  List<String> errors = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.mode == "EDIT") {
      productName = widget.product.title;
      description = widget.product.description;
      colors = widget.product.colors;
      selectColors = widget.product.colors.split(",");
      images = widget.product.images;
      rating = widget.product.rating;
      price = widget.product.price;
      maxPrice = widget.product.maxPrice;
      isFavourite = widget.product.isFavourite;
      isPopular = widget.product.isPopular;
    }
  }

  Future pickGalleryImage() async {
    try {
      var images = await _picker.pickMultiImage();
      if (images == null) return;
      setState(() {
        images.forEach((element) async {
          listImages.add(
            File(element.path),
          );
        });
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      return;
    }
  }

  Future pickCameraImage() async {
    try {
      var image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      setState(() {
        listImages.add(File(image.path));
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildProductNameFormField(),
              const SizedBox(
                height: SizeConfig.defaultPadding,
              ),
              buildProductDescriptionFormField(),
              const SizedBox(
                height: SizeConfig.defaultPadding,
              ),
              widget.product.categoryId != "4"
                  ? buildColorSelector()
                  : buildLNTypeSelector(),
              const SizedBox(
                height: SizeConfig.defaultPadding,
              ),
              buildFavouriteAndPopular(),
              const SizedBox(
                height: SizeConfig.defaultPadding,
              ),
              buildProductPriceFormField(),
              const SizedBox(
                height: SizeConfig.defaultPadding,
              ),
              buildRatingSelector(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Chọn ảnh từ: ",
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    width: SizeConfig.defaultPadding / 2,
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      pickGalleryImage();
                    },
                    icon: const Icon(
                      FontAwesome5.images,
                    ),
                    label: const Text(
                      "Thư viện",
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: SizeConfig.defaultPadding / 2,
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      pickCameraImage();
                    },
                    icon: const Icon(
                      FontAwesome5.camera,
                    ),
                    label: const Text(
                      "Camera",
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: SizeConfig.defaultPadding,
              ),
              listImages.isEmpty
                  ? const Center(
                      child: Text("No image"),
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: Center(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: listImages.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(
                                  SizeConfig.defaultPadding / 2),
                              child: Image.file(
                                listImages[index],
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
              const SizedBox(
                height: SizeConfig.defaultPadding,
              ),
              FormErrors(errors: errors),
              const SizedBox(
                height: SizeConfig.defaultPadding / 2,
              ),
              CustomButton(
                text: widget.mode == "ADD"
                    ? "Thêm sản phẩm"
                    : "Cập nhật thông tin sản phẩm",
                press: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.mode == "ADD") {
                      final Product product = Product(
                        id: "0",
                        title: productName,
                        description: description,
                        colors: widget.product.categoryId != "4"
                            ? selectColors.join(",")
                            : LNType.join(","),
                        isFavourite: isFavourite,
                        isPopular: isPopular,
                        rating: rating,
                        price: price,
                        maxPrice: price,
                        categoryId: widget.category.id,
                      );
                      context.read<ProductBloc>().add(
                          AddProduct(product: product, images: listImages));
                      var snackBar = SnackBar(
                        content: const Text("Thêm thành công"),
                        action: SnackBarAction(
                            label: "Về xem",
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                ProductListScreen.routeName,
                                arguments: ProductListArguments(
                                  category: widget.category,
                                  user: widget.user,
                                ),
                              );
                            }),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      final Product product = Product(
                        id: widget.product.id,
                        title: productName,
                        description: description,
                        images: images,
                        colors: widget.product.categoryId != "4"
                            ? selectColors.join(",")
                            : LNType.join(","),
                        isFavourite: isFavourite,
                        isPopular: isPopular,
                        rating: rating,
                        price: price,
                        maxPrice: maxPrice,
                        categoryId: widget.category.id,
                      );
                      context.read<ProductBloc>().add(EditProduct(
                            product: product,
                            images: listImages,
                          ));
                      var snackBar = SnackBar(
                        backgroundColor: AppColors.primaryColor,
                        content: const Text("Sửa thành công"),
                        action: SnackBarAction(
                            label: "Về xem",
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                ProductListScreen.routeName,
                                arguments: ProductListArguments(
                                  category: widget.category,
                                  user: widget.user,
                                ),
                              );
                            }),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildProductPriceFormField() {
    return TextFormField(
      initialValue: price.toString(),
      onSaved: (newValue) => price = double.parse(newValue!),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Mời nhập giá sản phẩm");
          setState(() {
            price = double.parse(value);
          });
        }
      },
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Mời nhập giá sản phẩm");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Đơn giá sản phẩm",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nhập đơn giá phẩm",
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

  Row buildRatingSelector() {
    return Row(
      children: [
        const Text(
          "Rating: ",
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 16,
          ),
        ),
        RatingBar.builder(
          initialRating: rating,
          itemCount: 5,
          allowHalfRating: true,
          updateOnDrag: true,
          direction: Axis.horizontal,
          itemPadding: const EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultPadding / 5),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (double value) {
            setState(() {
              rating = value;
            });
          },
        ),
      ],
    );
  }

  Row buildFavouriteAndPopular() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Favourite: ",
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 16,
          ),
        ),
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isFavourite,
          onChanged: (bool? value) {
            setState(() {
              isFavourite = value!;
            });
          },
        ),
        const Text(
          "Popular: ",
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 16,
          ),
        ),
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isPopular,
          onChanged: (bool? value) {
            setState(() {
              isPopular = value!;
            });
          },
        ),
      ],
    );
  }

  Widget buildLNTypeSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const Text(
            "Màu: ",
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 16,
            ),
          ),
          ...List.generate(
            LNType.length,
            (index) => GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Chip(
                  backgroundColor: Colors.white,
                  avatar: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.check),
                  ),
                  label: Text(LNType[index]),
                ),
              ),
            ),
          ),
          RoundedIconBtn(
            icon: Icons.add,
            onTap: () async {
              final Color newColor = await buildColorPicker(Colors.blue);
              setState(() {
                if (!selectColors.contains("0xFF${newColor.hex}")) {
                  setState(() {
                    selectColors.add("0xFF${newColor.hex}");
                  });
                }
              });
            },
            showShadow: true,
            isEnabled: true,
          ),
        ],
      ),
    );
  }

  Widget buildColorSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const Text(
            "Màu: ",
            style: TextStyle(
              color: AppColors.textColor,
              fontSize: 16,
            ),
          ),
          ...List.generate(
            selectColors.length,
            (index) => GestureDetector(
              onTap: () async {
                final Color newColor = await buildColorPicker(
                  Color(
                    int.parse(selectColors[index]),
                  ),
                );
                setState(() {
                  selectColors[index] = "0xFF${newColor.hex}";
                });
              },
              onLongPress: () => setState(() {
                selectColors.removeAt(index);
              }),
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Color(
                    int.parse(
                      selectColors[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
          RoundedIconBtn(
            icon: Icons.add,
            onTap: () async {
              final Color newColor = await buildColorPicker(Colors.blue);
              setState(() {
                if (!selectColors.contains("0xFF${newColor.hex}")) {
                  setState(() {
                    selectColors.add("0xFF${newColor.hex}");
                  });
                }
              });
            },
            showShadow: true,
            isEnabled: true,
          ),
        ],
      ),
    );
  }

  TextFormField buildProductNameFormField() {
    return TextFormField(
      initialValue: productName,
      onSaved: (newValue) => productName = newValue!,
      onChanged: (value) {
        removeError(error: AppErrors.nullProductNameError);
        if (value.isNotEmpty) {
          setState(() {
            productName = value;
          });
        }
      },
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: AppErrors.nullProductNameError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Tên sản phẩm",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nhập tên sản phẩm",
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

  TextFormField buildProductDescriptionFormField() {
    return TextFormField(
      initialValue: description,
      onSaved: (newValue) => description = newValue!,
      onChanged: (value) {
        setState(() {
          description = value;
        });
      },
      minLines: 1,
      maxLines: 10,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        setState(() {
          description = value!;
        });
      },
      decoration: InputDecoration(
        labelText: "Thông tin sản phẩm",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nhập thông tin sản phẩm",
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
            Icons.info,
            size: 30,
          ),
        ),
      ),
    );
  }

  Future<Color> buildColorPicker(Color color) async {
    return await showColorPickerDialog(
      context,
      color,
      showColorCode: true,
      showColorName: true,
      borderRadius: SizeConfig.defaultBorderRadius * 2,
      colorCodeHasColor: true,
      title: Text('Chọn màu', style: Theme.of(context).textTheme.headline6),
      width: 40,
      height: 40,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: true,
      },
      pickerTypeLabels: const <ColorPickerType, String>{
        ColorPickerType.primary: "Chọn màu",
        ColorPickerType.wheel: "Màu tuỳ chỉnh"
      },
      actionButtons: const ColorPickerActionButtons(
        okButton: true,
        closeButton: true,
        dialogActionButtons: false,
        closeIsLast: true,
      ),
      constraints: const BoxConstraints(
        minHeight: 480,
        minWidth: 320,
        maxWidth: 320,
      ),
    );
  }
}
