// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timer_app/Utilities/AppColor.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final bool? isEnabled;
  final bool? passwordVisible;
  final VoidCallback? onPressed;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final bool? isExpandable;
  final bool? isDate;
  final VoidCallback? dateFunction;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;
  Brightness keyboardAppearence;

  CustomTextFormField({
    Key? key,
    this.controller,
    this.hintText,
    this.validator,
    this.onSaved,
    this.isEnabled = true,
    this.inputFormatters,
    this.textInputType,
    this.isDate = false,
    this.isExpandable = false,
    this.dateFunction,
    this.onChanged,
    required this.labelText,
    this.passwordVisible,
    this.onPressed,
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
    this.keyboardAppearence = Brightness.light,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isDarkMode = false;
  bool isEmpty = true;
  @override
  void initState() {
    widget.controller?.addListener(() {
      if (!mounted) return;
      setState(() {
        isEmpty = widget.controller!.text.isNotEmpty ? false : true;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        keyboardAppearance: widget.keyboardAppearence,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          labelStyle: const TextStyle(
            color: AppColor.primaryColor,
            fontSize: 17.0,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 13,
          ),
          suffixIcon: widget.passwordVisible != null
              ? isEmpty
                  ? null
                  : IconButton(
                      icon: Icon(
                        widget.passwordVisible!
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColor.primaryColor,
                        size: 20,
                      ),
                      onPressed: widget.onPressed,
                    )
              : widget.isDate!
                  ? IconButton(
                      onPressed: widget.dateFunction,
                      icon: const Icon(Icons.date_range),
                    )
                  : widget.isEnabled!
                      ? !isEmpty
                          ? IconButton(
                              onPressed: widget.controller!.clear,
                              color: AppColor.primaryColor,
                              icon: const Icon(
                                Icons.clear,
                              ),
                            )
                          : null
                      : null,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: AppColor.primaryColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: AppColor.primaryColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: AppColor.primaryColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.0,
              color: AppColor.primaryColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          filled: true,
          fillColor: AppColor.transparent,
        ),
        style: const TextStyle(color: AppColor.black),
        minLines: 1,
        maxLines: widget.isExpandable! ? null : 1,
        controller: widget.controller,
        enabled: widget.isEnabled,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.textInputType,
        validator: widget.validator ??
            (value) {
              if (value!.isEmpty) {
                return "Required";
              }
            },
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        obscureText:
            widget.passwordVisible != null ? widget.passwordVisible! : false,
      ),
    );
  }
}
