import 'package:flutter/material.dart';
import 'package:form/src/bloc/provider.dart';
import 'package:form/src/pages/home_page.dart';
import 'package:form/src/pages/login_page.dart';
import 'package:form/src/pages/producto_page.dart';
import 'package:form/src/pages/registro_page.dart';
import 'package:form/src/preferencias_usuario.dart/preferencias_usuario.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  
  runApp(MyApp());
}  
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login'     : (BuildContext context) => LoginPage(),
          'home'      : (BuildContext context) => HomePage(),
          'productos' : (BuildContext context) => ProductoPage(),
          'registro'  : (BuildContext context) => RegistroPage()
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      ),
    );
    
  }
}