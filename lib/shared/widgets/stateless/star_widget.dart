import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/colors.dart';
import '../../constants/dimension_constants.dart';

class StarWidget extends StatelessWidget {
  const StarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: kMinPadding),
      child: FaIcon(
        FontAwesomeIcons.solidStar,
        color: ColorConstants.yellow,
        size: 12,
      ),
    );
  }
}
