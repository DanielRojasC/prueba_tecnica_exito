import 'package:flutter/material.dart';

const Color primaryColor = Color(0xffffe707);
const Color secondaryColor = Color(0xff000000);
const Color backgroundColor = Color(0xfffefffe);

double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

class SearchInputDecorator {
  static const _borderColor = Color.fromARGB(255, 217, 195, 0);
  static const _borderRadius = BorderRadius.all(Radius.circular(50));
  static const _normalBorder = BorderSide(color: _borderColor, width: 1);
  static const _focusedBorder = BorderSide(color: _borderColor, width: 2);
  static const _fillColor = Color(0xffffffbf);
  static const _icon = Icon(
    Icons.search_rounded,
    color: secondaryColor,
    size: 30,
  );
  static const _hintStyle = TextStyle(
    color: Color(0xff4d4823),
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static InputDecoration build({required String hint}) => InputDecoration(
    border: _buildInputBorder(_normalBorder),
    focusedBorder: _buildInputBorder(_focusedBorder),
    enabledBorder: _buildInputBorder(_normalBorder),
    fillColor: _fillColor,
    focusColor: _fillColor,
    filled: true,
    prefixIcon: const Padding(
      padding: EdgeInsets.only(left: 10),
      child: _icon,
    ),
    prefixIconConstraints: const BoxConstraints(minWidth: 0),
    hintText: hint,
    hintStyle: _hintStyle,
    contentPadding: EdgeInsets.zero,
  );

  static OutlineInputBorder _buildInputBorder(BorderSide borderSide) =>
      OutlineInputBorder(
        borderSide: borderSide,
        borderRadius: _borderRadius,
      );
}
