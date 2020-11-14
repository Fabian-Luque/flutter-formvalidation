

import 'dart:async';

class Validators {

  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: ( email , sink) {
      
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp   = new RegExp(pattern);

      if ( regExp.hasMatch( email )) {
        sink.add(email);
      } else {
        sink.addError('Email no es correcto');
      }

    }
  );

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: ( passwrd, sink) {
      if ( passwrd.length >= 6) {
        sink.add(passwrd);
      } else {
        sink.addError('Más de 6 caracteres por favor');
      }
    }
  );


}
