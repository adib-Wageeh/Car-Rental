import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'application/app/base_app.dart';
import 'application/injection_container.dart';
import 'firebase_options.dart';
import 'package:sizer/sizer.dart';

final getIt = GetIt.instance;

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  init();

  runApp(const BasicApp());
}
