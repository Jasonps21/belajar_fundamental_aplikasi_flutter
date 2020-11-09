import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final IconData iconImg;
  final Color iconColor;
  final Color conBackColor;
  final Key keyText;
  final Function() onBtnTap;

  const MenuWidget(
      {this.keyText,
      @required this.iconImg,
      @required this.iconColor,
      this.conBackColor,
      @required this.onBtnTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: keyText,
      onTap: () {
        onBtnTap();
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: conBackColor,
            border: Border.all(color: Colors.grey[200]),
            borderRadius: BorderRadius.circular(20.0)),
        child: Icon(
          iconImg,
          color: iconColor,
        ),
      ),
    );
  }
}
