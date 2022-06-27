import 'package:flutter/material.dart';

class MyInputTheme {
  TextStyle _builtTextStyle(Color color, {double size = 16.0}) {
    return TextStyle(
      color: color,
      fontSize: size,
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: color,
        width: 1.0,
      ),
    );
  }

  InputDecorationTheme theme() => InputDecorationTheme(
        contentPadding: EdgeInsets.all(16),
        isDense: true,
        //Muestra el teto sobre los cuadros
        floatingLabelBehavior: FloatingLabelBehavior.always,
        constraints: BoxConstraints(maxWidth: 150),

        //Muestra gris el cuadro cuando no hay error
        enabledBorder: _buildBorder(Colors.grey[600]!),
        //Muestra rojo el cuadro cuando  hay error
        errorBorder: _buildBorder(Colors.red),
        //Muestra rojo el cuadro cuando no hay error y pone el foco en el error
        focusedErrorBorder: _buildBorder(Colors.red),
        //Muestra amarillo el cuadro cuando no se ha puesto nada (NULL)
        border: _buildBorder(Colors.yellow),
        //Muestra azul el cuadro cuando se esta usando un cuadro
        focusedBorder: _buildBorder(Colors.blue),
        disabledBorder: _buildBorder(Colors.grey[400]!),

        //Textos
        suffixStyle: _builtTextStyle(Colors.black),
        counterStyle: _builtTextStyle(Colors.grey, size: 12.0),
        floatingLabelStyle: _builtTextStyle(Colors.black),
        errorStyle: _builtTextStyle(Colors.red, size: 12.0),
        helperStyle: _builtTextStyle(Colors.black, size: 12.0),
        hintStyle: _builtTextStyle(Colors.grey),
        labelStyle: _builtTextStyle(Colors.black),
        prefixStyle: _builtTextStyle(Colors.black),
      );
}
