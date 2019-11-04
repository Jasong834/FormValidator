
import 'dart:convert';

import 'package:form/src/preferencias_usuario.dart/preferencias_usuario.dart';
import 'package:http/http.dart' as http;


class UsuarioProvider  {

  final String _firebaseToken = 'AIzaSyDp5wv044z0n5u8zizaTjZBgAjEptzOSec';
  final _prefs = new PreferenciasUsuario();

   Future<Map<String,dynamic>> login(String email, String password) async {
     final authData = {
      'email'    : email,
      'password' : password,
      'returnSecureToken' : true
    };

  
    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
      body: json.encode( authData )
    );
  
    Map <String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if ( decodedResp.containsKey('idToken') ) {
      _prefs.token = decodedResp['idToken'];
      return { 'ok': true, 'token': decodedResp['idToken'] };
    } else {
      return { 'ok': false, 'mensaje': decodedResp['error']['message'] };
    }
  }


  
  Future<Map<String, dynamic>> nuevoUsuario( String email, String password ) async {

    final authData = {
      'email'    : email,
      'password' : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=$_firebaseToken',
      body: json.encode( authData )
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    print(decodedResp);

    if ( decodedResp.containsKey('idToken') ) {
      _prefs.token = decodedResp['idToken'];
      return { 'ok': true, 'token': decodedResp['idToken'] };
    } else {
      return { 'ok': false, 'mensaje': decodedResp['error']['message'] };
    }


  }

}
