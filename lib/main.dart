import 'package:flutter/material.dart';

import 'app/my_app.dart';
import 'core/initializer/init_app.dart';

void main() async{
  await initApp();
  runApp(const WallApp());
}

