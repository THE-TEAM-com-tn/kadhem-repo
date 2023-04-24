import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
   void Function(String)? onchanged = (value) {}  ; 

   MyTextField({
    Key? key,
    this.onchanged,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.validator,
    this.keyboardType = TextInputType.text, // Set the default value here
  }) : super(key: key);
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}
bool _passwordVisible = true;
class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        onChanged:  widget.onchanged ,
        controller: widget.controller,
        obscureText: widget.obscureText ? _passwordVisible : false,
        keyboardType: widget.keyboardType, // Add this line
        decoration: InputDecoration(
          suffixIcon: widget.obscureText? IconButton(
              icon:  Icon(
                !_passwordVisible ? Icons.visibility : Icons.visibility_off,
              ) ,
              onPressed: () {
                setState(() {
                _passwordVisible = !_passwordVisible;  
                });
                
              }) : null ,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
        validator: widget.validator,
      ),
    );
  }
}
