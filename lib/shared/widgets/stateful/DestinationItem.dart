import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';

import '../../constants/dimension_constants.dart';
import '../stateless/star_widget.dart';

class DestinationItem extends StatelessWidget {
  const DestinationItem({
    super.key,
    required this.size,
    required this.heightSize,
    required this.textDes,
    required this.img,
  });

  final Size size;
  final double heightSize;
  final String textDes;
  final String img;

  @override
  Widget build(BuildContext context) {
    bool isFavor = false;

    return Container(
      height: heightSize,
      margin: const EdgeInsets.only(
        top: 16,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
        borderRadius: kSmallBorderRadius,
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 40, left: kItemPadding),
            child: Text(
              textDes,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(bottom: kTopPadding, left: kItemPadding),
            height: 24,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StarWidget(),
                Text(
                  "4.5",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            child: LikeButton(
              onTap: (isLiked) async {
                // setState(() {
                //   isFavor = !isFavor;
                // });
                return Future.value(!isLiked);
              },
              isLiked: isFavor,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              size: 40,
              circleColor: const CircleColor(
                  start: Color(0xff00ddff), end: Color(0xff0099cc)),
              bubblesColor: const BubblesColor(
                dotPrimaryColor: Color(0xff33b5e5),
                dotSecondaryColor: Color(0xff0099cc),
              ),
              likeBuilder: (bool isLiked) {
                return Icon(
                  FontAwesomeIcons.solidHeart,
                  color: isLiked ? Colors.red : Colors.white,
                  size: 18,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
