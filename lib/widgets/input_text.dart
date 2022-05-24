import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  const InputText(
      {Key? key,
      required this.label,
      required this.onChanged,
      required this.validate, 
      required this.keyboardType, 
      required this.obscureText, 
      })
      : super(key: key);
  final TextInputType keyboardType;
  final bool obscureText;   
  final String label;
  final void Function(String text) onChanged;
  final String Function(String text) validate;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: (String? validate) {
        if (validate!.isEmpty) {
          
          return 'Vacio';
        }else{
          if (label == 'EMAIL') {
            if (!validate.contains("@")) {
              return "Email invalido";
            }
          }
          else if(label == 'CONTRASEÑA'){
            if(validate.trim().length < 8 || validate.trim().length == 0){
              return "Contraseña invalido";
            }
          }else if(label == 'USUARIO'){
            if(validate.trim().length < 5){
              return "Usuario Demaciado Corto";
            }
          }
        }
      },
      decoration: InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }
}
