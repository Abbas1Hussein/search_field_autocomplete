import 'package:flutter/material.dart';

/// extension to check if a Object is present in List<Object>
extension ListContainsObject<T> on List {
  bool containsObject(T object) {
    for (var item in this) {
      if (object == item) {
        return true;
      }
    }
    return false;
  }
}

/// A list of [BoxShadow] objects representing elevation effects.
final List<BoxShadow> elevations = [
  BoxShadow(
    color: Colors.black.withOpacity(0.8),
    spreadRadius: 0.1,
    blurRadius: 0.1,
    offset: const Offset(0, 0),
  ),
];
