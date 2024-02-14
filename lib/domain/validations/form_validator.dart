// import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef FunctionValidation = String? Function(String?);

class Validator {
  final String? inputValue;

  Validator(this.inputValue);

  String? runValue(String? value, Function validations) {
    try {
      validations();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  void isNullOrEmpty([String? message]) {
    if (inputValue == null || inputValue!.isEmpty) {
      throw message ?? 'Este es un campo obligatorio.';
    }
  }

  void isAPin([String? message]) {
    final pinRegExp = RegExp(r'^\d{4}$');

    if (inputValue == null || !pinRegExp.hasMatch(inputValue!)) {
      throw message ?? 'El PIN debe contener 4 dígitos numéricos.';
    }
  }

  void areStringsDifferent(String? secondValue, [String? message]) {
    if (inputValue != secondValue) {
      throw message ?? 'Los campos deben ser iguales.';
    }
  }
}
