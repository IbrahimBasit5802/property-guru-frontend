import 'package:flutter/material.dart';
import '/pallete.dart';

class LoginField extends StatelessWidget {
  final String hintText;

   const LoginField({
    Key? key,
    required this.hintText,
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {
    TextEditingController empIDController = TextEditingController();
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: TextFormField(
        controller: empIDController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(27),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Pallete.borderColor,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Pallete.gradient2,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,


        ),
      ),
    );

  }
}
