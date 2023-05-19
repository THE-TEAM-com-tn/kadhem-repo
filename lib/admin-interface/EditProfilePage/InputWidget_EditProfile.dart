// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../../../utils/mycolors.dart';


// class InputWidgetEditProfile extends StatefulWidget {
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;
//   final String text;
//   final bool enabled;
//   final String initialValue;
//   final int maxLines;
//   final ValueChanged<String>? onChanged;
//   final bool obscure;
//   final String? labelText;

//   final textAlign;

//   const InputWidgetEditProfile({
//     Key? key,
//     this.controller,
//     this.validator,
//     required this.text,
//     required this.labelText,
//     required this.enabled,
//     required this.initialValue,
//     required this.maxLines,
//     this.onChanged,
//     required this.obscure,
//     this.textAlign,
//   }) : super(key: key);

//   @override
//   State<InputWidgetEditProfile> createState() => _InputWidgetState();
// }

// class _InputWidgetState extends State<InputWidgetEditProfile> {
//   late final TextEditingController _controller;
//   bool _passwordVisible = true;
//   late bool _obscure;
//   late String _labelText;

//   @override
//   void initState() {
//     if (widget.controller != null) {
//       _controller = widget.controller!;
//       _controller.text = widget.initialValue;
//     } else {
//       _controller = TextEditingController(text: widget.initialValue);
//     }

//     _obscure = widget.obscure;
//     _labelText = widget.labelText! ?? '';
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {



//     return

//       TextFormField(
//         controller: _controller,
//         maxLines: widget.maxLines,
//         validator: widget.validator ?? (value) {},
//         onChanged: widget.onChanged,
//         enabled: widget.enabled,
//         obscureText: _obscure ? _passwordVisible : false,

//         decoration: InputDecoration(

//           labelText: _labelText,

//             labelStyle :
//             GoogleFonts.poppins(
//               //color: Colors.black,
//              color: MyColors.primary,
//               fontWeight: FontWeight.w500,
//               fontSize: 12.0,
//             ),

//           enabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Color(0xFFF1F4F8), // primaryBackground
//               width: 2.0,
//             ),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Color(0x00000000),
//               width: 2.0,
//             ),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Color(0x00000000),
//               width: 2.0,
//             ),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               color: Color(0x00000000),
//               width: 2.0,
//             ),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           filled: true,
//           fillColor: const Color(0xFFFFFFFF),
//           contentPadding: const EdgeInsetsDirectional.fromSTEB(
//               20.0, 24.0, 0.0, 24.0),

//           suffixIcon: _obscure
//               ? IconButton(
//             icon: Icon(
//               !_passwordVisible ? Icons.visibility : Icons.visibility_off,
//             ),
//             onPressed: () {
//               setState(() {
//                 _passwordVisible = !_passwordVisible;
//               });
//             },
//           )
//               : null,
//         ),
//       );
//   }
// }