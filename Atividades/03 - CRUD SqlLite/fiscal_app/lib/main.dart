import 'package:fiscal_app/configs/app_settings.dart';
import 'package:fiscal_app/configs/hive_config.dart';
import 'package:fiscal_app/repositories/conta_repository.dart';
import 'package:fiscal_app/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'meu_aplicativo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.start();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContaRepository()),
        ChangeNotifierProvider(create: (context) => AppSettings()),
        ChangeNotifierProvider(create: (context) => FavoritasRepository()),
      ],
      child: const MeuAplicativo(),
    ),
  );
}
