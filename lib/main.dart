
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iran_gpt/core/services/service_locator.dart';
import 'package:iran_gpt/features/mian/domain/entites/save_data_entity.dart';
import 'package:iran_gpt/features/mian/presentation/pages/home_screen.dart';


void main()async{
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();

  ServiceLocator.init();
  Hive.registerAdapter(SaveDataEntityAdapter());
  await Hive.openBox("saveData");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat GPT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // useMaterial3: true,
        // primarySwatch: Colors.blue,
      ),
      home: const HomeScreen()
    );
  }
}

