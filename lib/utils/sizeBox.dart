import 'package:flutter/cupertino.dart';

extension SizesBox on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}
