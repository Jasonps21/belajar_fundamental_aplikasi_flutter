import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restauran_app/common/color_constants.dart';

class FilterWidget extends StatelessWidget {
  final String filterTxt;

  const FilterWidget({Key key, this.filterTxt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            color: ColorConstant.kFilterBackColor,
            borderRadius: BorderRadius.circular(40.0)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(filterTxt,
                style: GoogleFonts.notoSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.kBlackColor)),
          ),
        ),
      ),
    );
  }
}
