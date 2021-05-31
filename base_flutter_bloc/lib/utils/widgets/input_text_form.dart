import 'package:base_flutter_bloc/const/all_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils.dart';

class BuildInputText extends StatefulWidget {
  final IconData iconLeading;

  final String hintText;

  final TextEditingController controller;

  final FocusNode currentNode;

  final FocusNode nextNode;

  final bool obscureText;

  final String isStringEmpty;

  final double borderRadius;

  final TextInputAction iconNextTextInputAction;

  final Function submitFunc;

  final Function onNext;

  final String Function(String) validator;

  /// 0 : LengthLimitingText. Giới hạn ký tự nhập(nếu có)
  /// 1 : digitsOnly. Chỉ nhập số
  /// 2 : TaxCode. Kiểu nhập là mã số thuế
  final int inputFormatters;

  final TextInputType textInputType;

  final int maxLengthInputForm;

  final bool isReadOnly;

  final bool autoFocus;

  BuildInputText({
    @required this.iconLeading,
    @required this.hintText,
    @required this.controller,
    this.currentNode,
    this.submitFunc,
    this.nextNode,
    this.obscureText = false,
    this.isStringEmpty,
    this.iconNextTextInputAction = TextInputAction.next,
    this.onNext,
    this.validator,
    this.inputFormatters = 0,
    this.borderRadius = 10.0,
    this.textInputType = TextInputType.text,
    this.maxLengthInputForm,
    this.isReadOnly = false,
    this.autoFocus = false,
  });

  @override
  _BuildInputTextState createState() => _BuildInputTextState();
}

class _BuildInputTextState extends State<BuildInputText> {
  bool _isShowButtonClear = false;

  List<TextInputFormatter> getFormatters() {
    switch (widget.inputFormatters) {
      case 1:
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(widget.maxLengthInputForm),
        ];
      case 2:
        return [
          TaxCodeFormatter(),
          FilteringTextInputFormatter.allow(RegExp(r"[0-9-]")),
          LengthLimitingTextInputFormatter(14),
        ];
      default:
        return [LengthLimitingTextInputFormatter(widget.maxLengthInputForm)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        inputFormatters: getFormatters(),
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (v) {
          if (!_isShowButtonClear || v.isEmpty) {
            setState(() {
              _isShowButtonClear = v.isNotEmpty;
            });
          }
        },
        onTap: () => setState(() {
          widget.controller.selection = TextSelection.fromPosition(
              TextPosition(offset: widget.controller.text.length));
        }),
        textInputAction: widget.iconNextTextInputAction,
        style: TextStyle(color: AppColors.textColor),
        controller: widget.controller,
        obscureText: widget.obscureText,
        autofocus: widget.autoFocus,
        focusNode: widget.currentNode,
        keyboardType: widget.textInputType,
        readOnly: widget.isReadOnly,
        onFieldSubmitted: (v) {
          if (widget.iconNextTextInputAction.toString() ==
              TextInputAction.next.toString()) {
            FocusScope.of(context).requestFocus(widget.nextNode);
            widget.onNext();
          } else {
            widget.submitFunc();
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.bgInputTextColor,
          hintStyle: TextStyle(
            fontSize: AppDimens.fontMedium,
            color: AppColors.hintTextColor,
          ),
          hintText: widget.hintText,
          errorStyle: TextStyle(color: AppColors.errorTextColor),
          prefixIcon: Icon(
            widget.iconLeading,
            color: AppColors.prefixIconColor,
          ),
          prefixStyle:
              TextStyle(color: Colors.red, backgroundColor: Colors.white),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none),
          contentPadding: EdgeInsets.all(AppDimens.paddingSmall),
          suffixIcon: Visibility(
            visible: _isShowButtonClear,
            child: GestureDetector(
              onTap: () {
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => widget.controller.clear());
                setState(() {
                  _isShowButtonClear = false;
                });
              },
              child: Icon(
                Icons.clear,
                color: AppColors.prefixIconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
