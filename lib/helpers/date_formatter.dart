import 'package:flutter/services.dart';

class DateFormatter extends TextInputFormatter {
  final String mask = 'xx/xx/xxxx';
  final String separator = '/';

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 0) {
      if (newValue.text.length > oldValue.text.length) {
        String lastEnteredChar = newValue.text.substring(newValue.text.length - 1);
        if (!_isNumeric(lastEnteredChar)) return oldValue;

        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length && mask[newValue.text.length - 1] == separator) {
          String value = _validateValue(oldValue.text);

          return TextEditingValue(
            text: '$value$separator$lastEnteredChar',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }

        if (newValue.text.length == mask.length) {
          return TextEditingValue(
            text: '${_validateValue(newValue.text)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end,
            ),
          );
        }
      }
    }
    return newValue;
  }

  bool _isNumeric(String s) {
    if (s == null) return false;
    return double.tryParse(s) != null;
  }

  String _validateValue(String s) {
    String result = s;

    if (s.length < 4) {
      int num = int.parse(s.substring(s.length - 2));
      String raw = s.substring(0, s.length - 2);
      if (num == 0) {
        result = raw + '01';
      } else if (num > 31) {
        result = raw + '31';
      } else {
        result = s;
      }
    } else if (s.length < 7) {
      int num = int.parse(s.substring(s.length - 2));
      String raw = s.substring(0, s.length - 2);
      if (num == 0) {
        result = raw + '01';
      } else if (num > 12) {
        result = raw + '12';
      } else {
        result = s;
      }
    } else {
      int num = int.parse(s.substring(s.length - 4));
      String raw = s.substring(0, s.length - 4);
      if (num < 1800) {
        result = raw + '1800';
      } else if (num > DateTime.now().year) {
        result = raw + DateTime.now().year.toString();
      } else {
        result = s;
      }
    }

    print(result);
    return result;
  }
}
