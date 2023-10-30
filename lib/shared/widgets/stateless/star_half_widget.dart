import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/dimension_constants.dart';

class StarHalfWidget extends StatelessWidget {
  const StarHalfWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: kMinPadding),
      child: FaIcon(
        FontAwesomeIcons.starHalfStroke,
        color: ColorConstants.yellow,
        size: 12,
      ),
    );
  }
}
