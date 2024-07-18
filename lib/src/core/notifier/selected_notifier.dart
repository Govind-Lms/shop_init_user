import 'package:flutter/foundation.dart';


final ValueNotifier<String> selectedColor = ValueNotifier<String>('');
final ValueNotifier<String> selectedSize = ValueNotifier<String>('white');


final ValueNotifier<bool> uploaded = ValueNotifier<bool>(false);

final ValueNotifier<int> quantity = ValueNotifier<int>(1);