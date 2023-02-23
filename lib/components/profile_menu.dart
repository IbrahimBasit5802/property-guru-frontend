import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ProfileMenu extends StatelessWidget {
   ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
    this.color,
     required this.arrow
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;
  Color? color;
  bool arrow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: color,
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: Colors.black,
              width: 22,
            ),
            SizedBox(width: 20),
            Expanded(child: Text(text)),
            arrow ? Icon(Icons.arrow_forward_ios) : Container()
          ],
        ),
      ),
    );
  }
}
