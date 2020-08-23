import 'package:flutter/material.dart';

getColor(double percent) {
  if (percent >= 0.5) {
    return Colors.green;
  } else if (percent >= 0.25) {
    return Colors.deepOrangeAccent;
  } else {
    return Colors.red;
  }
}
