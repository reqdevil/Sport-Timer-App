// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:timer_app/Utilities/AppColor.dart';
import 'package:timer_app/Utilities/Helpers.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> dropdownMenuItemList;
  final ValueChanged<T> onChanged;
  final GestureTapCallback? onTap;
  final T value;
  final bool isEnabled;
  final String labelText;
  final String? hintText;
  final String? errorText;
  final Color? labelColor;
  final Color? fillColor;

  CustomDropdown({
    Key? key,
    required this.dropdownMenuItemList,
    required this.onChanged,
    this.onTap,
    required this.value,
    this.isEnabled = true,
    required this.labelText,
    this.hintText,
    this.errorText,
    this.labelColor,
    this.fillColor,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  Color _focusNodeColor = AppColor.white;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _focusNode.addListener(_requestFocusNode);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  void _requestFocusNode() {
    if (_focusNode.hasFocus) {
      setState(() {
        _focusNodeColor = AppColor.primaryColor.withOpacity(0.5);
      });
    } else {
      setState(() {
        _focusNodeColor = AppColor.primaryColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isEnabled,
      child: Stack(
        children: [
          Container(
            width: 315,
            height: 50,
            margin: const EdgeInsets.all(0),
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: parseColor('#878E9F'),
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(-1, 4),
                ),
              ],
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField<dynamic>(
              elevation: 2,
              focusNode: _focusNode,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColor.white,
                size: 16,
              ),
              decoration: InputDecoration(
                isCollapsed: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                alignLabelWithHint: false,
                contentPadding: const EdgeInsets.all(14),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0),
                  borderSide: const BorderSide(
                    color: AppColor.darkPrimaryColor,
                    width: 1.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                isDense: true,
                filled: true,
                fillColor: widget.fillColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0),
                  borderSide: const BorderSide(
                    color: AppColor.primaryColor,
                    width: 1.0,
                  ),
                ),
                labelText: widget.labelText,
                labelStyle: TextStyle(
                  fontFamily: 'Roboto',
                  color: _focusNodeColor,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              validator: (value) {
                if (value == null) {
                  return widget.errorText;
                }
                return null;
              },
              isExpanded: true,
              itemHeight: 50.0,
              dropdownColor: AppColor.primaryColor,
              items: widget.dropdownMenuItemList,
              onChanged: widget.onChanged,
              onTap: widget.onTap,
              value: widget.value,
            ),
          ),
        ],
      ),
    );
  }
}
