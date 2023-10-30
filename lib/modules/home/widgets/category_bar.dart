import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryBar extends StatefulWidget {
  const CategoryBar({
    super.key,
  });

  @override
  State<CategoryBar> createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> menuList = [
      StringConst.all.tr,
      StringConst.popular.tr,
      StringConst.asia.tr,
      StringConst.europe.tr,
      StringConst.american.tr
    ];

    return Container(
      decoration: const BoxDecoration(),
      margin: const EdgeInsets.only(
        top: kDefaultPadding,
        bottom: kMediumPadding,
      ),
      child: SizedBox(
        height: size.height / 20,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: menuList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                width: size.width / 5,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: kDefaultPadding),
                decoration: selectedIndex == index
                    ? const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Gradients.lightBlue1,
                            Gradients.lightBlue2,
                          ],
                        ),
                        borderRadius: kSmallBorderRadius,
                      )
                    : const BoxDecoration(
                        color: ColorConstants.grayTextField,
                        borderRadius: kSmallBorderRadius,
                      ),
                child: Text(
                  menuList[index].toString(),
                  style: TextStyle(
                    fontSize: getSize(16),
                    color: selectedIndex == index
                        ? ColorConstants.white
                        : ColorConstants.black,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
