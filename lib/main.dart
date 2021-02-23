import 'package:flor_de_gato/Controllers/ClientController.dart';
import 'package:flor_de_gato/Controllers/ProductController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Controllers/RequestController.dart';
import 'Pages/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ProductController(),
            lazy: false,
          ),
          ChangeNotifierProvider(
            create: (_) => ClientController(),
            lazy: false,
          ),
          ChangeNotifierProvider(
            create: (_) => RequestController(),
            lazy: false,
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Flor de Gato",
          home: HomePage(),
          theme: ThemeData(
            iconTheme: IconThemeData(
              color: Color(0xFF442C2E),
            ),
            primaryColor: Color(0xFF442C2E),
            secondaryHeaderColor: Color(0xFF442C2E),
          ),
        ));
  }
}
