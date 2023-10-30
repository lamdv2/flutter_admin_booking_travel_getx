import 'package:doan_clean_achitec/shared/widgets/stateful/header_widget.dart';
import 'package:flutter/material.dart';

import '../../shared/constants/assets_helper.dart';
import '../../shared/utils/size_utils.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(
                      AssetHelper.hotel_2,
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(getSize(16)),
                    bottomRight: Radius.circular(getSize(16)),
                  ),
                ),
                height: size.height / 3,
                padding: EdgeInsets.all(
                  getSize(20),
                ),
                child: const HeaderWidget(
                  trailing: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
