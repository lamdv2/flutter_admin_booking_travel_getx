import 'package:doan_clean_achitec/models/Destination.dart';
import 'package:doan_clean_achitec/shared/widgets/stateless/star_half_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/stateless/star_widget.dart';
import 'package:flutter/cupertino.dart';

import '../../constants/app_style.dart';

class ListStarWidget extends StatelessWidget {
  const ListStarWidget({Key? key, required this.desti}) : super(key: key);

  final Destination desti;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (desti.starDes != null && desti.starDes! >= 4)
          ...List.generate(4, (index) => const StarWidget()),
        if (desti.starDes != null && desti.starDes! > 4 && desti.starDes! < 5)
          const StarHalfWidget(),
        if (desti.starDes != null && desti.starDes! == 5)
          ...List.generate(5, (index) => const StarWidget()),
        if (desti.starDes != null && desti.starDes! < 4)
          ...List.generate(3, (index) => const StarWidget()),
        if (desti.starDes != null && desti.starDes! > 3 && desti.starDes! < 4)
          const StarHalfWidget(),
        Text(
          ' (${desti.starDes})',
          style: AppStyles.white000Size13FfMont,
        ),
      ],
    );
  }
}
