import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restauran_app/data/model/detail_restaurant.dart';

class ReviewWidget extends StatelessWidget {
  final ConsumerReview review;

  const ReviewWidget({Key key, this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  review.name,
                  style: GoogleFonts.notoSans(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  review.date,
                  style: GoogleFonts.notoSans(fontSize: 10),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                review.review,
                style: GoogleFonts.notoSans(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
