import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restauran_app/common/color_constants.dart';

class FloatingWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const FloatingWidget({Key key, this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 150,
      child: FloatingActionButton(
        elevation: 5,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(75.0)),
        heroTag: null,
        child: Ink(
          decoration: BoxDecoration(
              color: ColorConstant.kFABBackColor,
              borderRadius: BorderRadius.circular(75.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300, minHeight: 50.0),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: ColorConstant.kWhiteColor,
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSans(
                        color: ColorConstant.kWhiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
