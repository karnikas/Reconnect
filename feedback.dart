import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../widgets/firestore.dart';

class My_feedback extends StatefulWidget {
  My_feedback({Key? key}) : super(key: key);

  @override
  State<My_feedback> createState() => _My_feedbackState();
}

class _My_feedbackState extends State<My_feedback> {
  double ratingValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          title: const Text('Your valuable Feedback here'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 58, 116, 98),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Center(
            child: Text(
              'How much did you like the App? \n \n',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: SmoothStarRating(
                starCount: 5,
                rating: ratingValue,
                size: 35,
                isReadOnly: false,
                color: Colors.amber,
                borderColor: Colors.amber,
                allowHalfRating: true,
                spacing: 0,

                onRated: (Ratingvalue) {
                  Fluttertoast.showToast(msg: 'Rated!');
                  Navigator.pop(context);
                  // Rate = ratingValue;
                  setState(() {
                    RatingGiven(Ratingvalue);
                  });
                },

                //we can save this in database. this prints how many stars someone gave
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    '\n \n Rate us out of 5 :)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                )
              ],
            ),
          ])
        ]));
  }
}
