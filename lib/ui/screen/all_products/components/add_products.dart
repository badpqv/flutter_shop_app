import "package:flutter/material.dart";
import 'package:flutter_shop_app/constant_value.dart';
import 'package:flutter_shop_app/ui/screen/details/components/colors_dot.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static String routeName = "/add_product";
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Thêm sản phẩm mới",
          style: TextStyle(
            color: primaryColor,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding,
        ),
        child: Center(
          child: AddProductForm(),
        ),
      ),
    );
  }
}

class AddProductForm extends StatefulWidget {
  const AddProductForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  late String productTitle;
  final List<String> errors = [];
  final List<String> colors = [
    "0xFFF6625E",
    "0xFF836DB8",
  ];
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          productTitleFormField(),
          const SizedBox(
            height: defaultPadding,
          ),
          descriptionFormField(),
          const SizedBox(
            height: defaultPadding,
          ),
          priceFormField(),
          const SizedBox(
            height: defaultPadding,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
            ),
            child: Row(
              children: [
                const Text(
                  "Màu: ",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
                ...List.generate(
                  colors.length,
                  (index) => ColorDot(
                      color: Color(int.parse(colors[index])),
                      isSelected: false),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  TextFormField priceFormField() {
    return TextFormField(
      onSaved: ((newValue) => productTitle = newValue!),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(
            error: "Chưa nhập giá sản phẩm",
          );
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(
            error: "Chưa nhập giá sản phẩm",
          );
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Giá sản phẩm",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nhập giá sản phẩm",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 2,
          vertical: defaultPadding * 1.5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: defaultPadding,
        ),
      ),
    );
  }

  TextFormField descriptionFormField() {
    return TextFormField(
      onSaved: ((newValue) => productTitle = newValue!),
      keyboardType: TextInputType.multiline,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(
            error: "Chưa nhập Mô tả sản phẩm",
          );
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(
            error: "Chưa nhập Mô tả sản phẩm",
          );
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Mô tả sản phẩm",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nhập mô tả sản phẩm",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 2,
          vertical: defaultPadding * 1.5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: defaultPadding,
        ),
      ),
    );
  }

  TextFormField productTitleFormField() {
    return TextFormField(
      onSaved: ((newValue) => productTitle = newValue!),
      keyboardType: TextInputType.text,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(
            error: "Chưa nhập tên sản phẩm",
          );
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(
            error: "Chưa nhập tên sản phẩm",
          );
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Tên sản phẩm",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Nhập tên sản phẩm",
        contentPadding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 2,
          vertical: defaultPadding * 1.5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide: const BorderSide(color: Colors.grey),
          gapPadding: defaultPadding,
        ),
      ),
    );
  }
}
