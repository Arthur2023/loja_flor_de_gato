import 'package:flor_de_gato/Controllers/client_controller.dart';
import 'package:flor_de_gato/Controllers/movement_controller.dart';
import 'package:flor_de_gato/Controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Controllers/config_controller.dart';
import 'Controllers/request_controller.dart';
import 'Pages/base_screen.dart';
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
            create: (_) => ConfigsController(),
            lazy: false,
          ),
          ChangeNotifierProvider(
            create: (_) => MovementController(),
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
