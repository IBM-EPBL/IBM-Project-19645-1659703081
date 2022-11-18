import 'package:flutter/material.dart';

const Color dark25 = Color(0xFF7A7E80);
const Color dark50 = Color(0xFF212325);
const Color dark75 = Color(0xFF161719);
const Color dark100 = Color(0xFF0D0E0F);

const Color light20 = Color(0xFF91919F);
const Color light40 = Color(0xFFF6F6F6);
const Color light60 = Color(0xFFF1F1FA);
const Color light80 = Color(0xFFFCFCFC);
const Color light100 = Color(0xFFFFFFFF);

const Color violet20 = Color(0xFFEEE5FF);
const Color violet40 = Color(0xFFD3BDFF);
const Color violet60 = Color(0xFFB18AFF);
const Color violet80 = Color(0xFF8F57FF);
const Color violet100 = Color(0xFF7F3DFF);

const Color red20 = Color(0xFFFDD5D7);
const Color red40 = Color(0xFFFDA2A9);
const Color red60 = Color(0xFFFD6F7A);
const Color red80 = Color(0xFFFD5662);
const Color red100 = Color(0xFFFD3C4A);

const Color green20 = Color(0xFFCFFAEA);
const Color green40 = Color(0xFF93EACA);
const Color green60 = Color(0xFF65D1AA);
const Color green80 = Color(0xFF2AB784);
const Color green100 = Color(0xFF00A86B);

const Color yellow20 = Color(0xFFFCEED4);
const Color yellow40 = Color(0xFFFCDDA1);
const Color yellow60 = Color(0xFFFCCC6F);
const Color yellow80 = Color(0xFFFCBB3C);
const Color yellow100 = Color(0xFFFCAC12);

const Color blue20 = Color(0xFFBDDCFF);
const Color blue40 = Color(0xFF8AC0FF);
const Color blue60 = Color(0xFF57A5FF);
const Color blue80 = Color(0xFF248AFF);
const Color blue100 = Color(0xFF0077FF);

const TextStyle splashLogoTextStyle = TextStyle(
  color: light100,
  fontFamily: 'Inter',
  fontSize: 56,
  fontWeight: FontWeight.bold,
);
const TextStyle titleXTextStyle = TextStyle(
  color: dark75,
  fontFamily: 'Inter',
  fontSize: 64,
  fontWeight: FontWeight.bold,
);
const TextStyle title0TextStyle = TextStyle(
  color: dark75,
  fontFamily: 'Inter',
  fontSize: 40,
  fontWeight: FontWeight.bold,
);
const TextStyle title1TextStyle = TextStyle(
  color: dark75,
  fontFamily: 'Inter',
  fontSize: 32,
  fontWeight: FontWeight.bold,
);
const TextStyle title2TextStyle = TextStyle(
  color: dark75,
  fontFamily: 'Inter',
  fontSize: 24,
  fontWeight: FontWeight.w600,
);
const TextStyle title3TextStyle = TextStyle(
  color: dark75,
  fontFamily: 'Inter',
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

const TextStyle body1TextStyle = TextStyle(
  color: dark75,
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.w500,
);
const TextStyle body2TextStyle = TextStyle(
  color: dark75,
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.w600,
);
const TextStyle body3TextStyle = TextStyle(
  color: dark75,
  fontFamily: 'Inter',
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

const TextStyle smallTextStyle = TextStyle(
  color: light20,
  fontFamily: 'Inter',
  fontSize: 13,
  fontWeight: FontWeight.w500,
);
const TextStyle tinyTextStyle = TextStyle(
  color: dark75,
  fontFamily: 'Inter',
  fontSize: 12,
  fontWeight: FontWeight.w500,
);

const TextStyle body3Light20TextStyle = TextStyle(
  color: light20,
  fontFamily: 'Inter',
  fontSize: 14,
  fontWeight: FontWeight.w500,
);
const TextStyle body3Light80TextStyle = TextStyle(
  color: light80,
  fontFamily: 'Inter',
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

const TextStyle body1Light20TextStyle = TextStyle(
  color: light20,
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.w500,
);
const TextStyle title3dark50TextStyle = TextStyle(
  color: dark50,
  fontFamily: 'Inter',
  fontSize: 18,
  fontWeight: FontWeight.w600,
);
const TextStyle title3dark100TextStyle = TextStyle(
  color: dark100,
  fontFamily: 'Inter',
  fontSize: 18,
  fontWeight: FontWeight.w600,
);
const TextStyle title3Light80TextStyle = TextStyle(
  color: light80,
  fontFamily: 'Inter',
  fontSize: 18,
  fontWeight: FontWeight.w600,
);
const TextStyle selectedYellow100TextStyle = TextStyle(
  color: yellow100,
  fontFamily: 'Inter',
  fontSize: 14,
  fontWeight: FontWeight.bold,
);
const TextStyle title4TextStyle = TextStyle(
  color: Color(0xFF292B2D),
  fontFamily: 'Inter',
  fontSize: 18,
  fontWeight: FontWeight.w600,
);
const TextStyle body2Red100TextStyle = TextStyle(
  color: red100,
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.w600,
);
const TextStyle body2Green100TextStyle = TextStyle(
  color: green100,
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.w600,
);
const TextStyle moneyInputTextStyle = TextStyle(
  color: light80,
  fontFamily: 'Inter',
  fontSize: 64,
  fontWeight: FontWeight.w600,
);
const TextStyle amountTextStyle = TextStyle(
  color: light80,
  fontFamily: 'Inter',
  fontSize: 48,
  fontWeight: FontWeight.bold,
);
const TextStyle body2Dark100TextStyle = TextStyle(
  color: dark100,
  fontFamily: 'Inter',
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

const InputDecoration moneyTextInputDecoration = InputDecoration(
  prefixText: "₹",
  prefixStyle: moneyInputTextStyle,
  isCollapsed: true,
  isDense: true,
  contentPadding: EdgeInsets.zero,
  border: InputBorder.none,
  focusedBorder: InputBorder.none,
  disabledBorder: InputBorder.none,
  enabledBorder: InputBorder.none,
  errorBorder: InputBorder.none,
);
final InputDecoration textInputDecoration = InputDecoration(
  filled: true,
  fillColor: light100,
  hintStyle: const TextStyle(color: light20, fontFamily: 'Inter', fontSize: 16),
  suffixIconConstraints: const BoxConstraints(maxHeight: 32),
  border: OutlineInputBorder(
    borderSide: const BorderSide(color: light60),
    borderRadius: BorderRadius.circular(16),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: light60),
    borderRadius: BorderRadius.circular(16),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: light60),
    borderRadius: BorderRadius.circular(16),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: light60),
    borderRadius: BorderRadius.circular(16),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: red100),
    borderRadius: BorderRadius.circular(16),
  ),
);

final RegExp emailValidator = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
