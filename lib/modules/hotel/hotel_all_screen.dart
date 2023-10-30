import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/widgets/stateful/header_widget.dart';
import '../../shared/widgets/stateful/hotel_item_vertical.dart';

class HotelAllScreen extends StatefulWidget {
  const HotelAllScreen({super.key});

  @override
  State<HotelAllScreen> createState() => _HotelAllScreenState();
}

class _HotelAllScreenState extends State<HotelAllScreen> {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(getSize(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getSize(statusBarHeight),
              ),
              HeaderWidget(
                titleHeader: StringConst.allHotel.tr,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (BuildContext context, int rowIndex) {
                  return Row(
                    children: [
                      if (rowIndex > 0)
                        SizedBox(
                          height: getSize(16),
                        ),
                      Expanded(
                        child: HotelItemVerticalWidget(),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
