import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restauran_app/common/color_constants.dart';

class CardMenu extends StatelessWidget {
  final String menu;
  final String category;
  const CardMenu({Key key, this.menu, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: AssetImage(category == 'food'
                    ? 'assets/images/fast-food.png'
                    : 'assets/images/drink.png'),
                width: 80,
                height: 80,
              ),
            ),
            Text(
              menu,
              style: GoogleFonts.notoSans(
                fontSize: 12,
                color: ColorConstant.kBlackColor,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
