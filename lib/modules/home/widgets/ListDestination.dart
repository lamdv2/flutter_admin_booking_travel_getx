import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/stateful/DestinationItem.dart';

class ListDestination extends StatefulWidget {
  const ListDestination({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<ListDestination> createState() => _ListDestinationState();
}

class _ListDestinationState extends State<ListDestination> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              DestinationItem(
                size: widget.size,
                heightSize: 220,
                textDes: 'Korea',
                img: AssetHelper.des1,
              ),
              DestinationItem(
                size: widget.size,
                heightSize: 220,
                textDes: 'Japan',
                img: AssetHelper.des3,
              ),
              DestinationItem(
                size: widget.size,
                heightSize: 140,
                textDes: 'Turkey',
                img: AssetHelper.des8,
              ),
              DestinationItem(
                size: widget.size,
                heightSize: 220,
                textDes: 'China',
                img: AssetHelper.des7,
              ),
              DestinationItem(
                size: widget.size,
                heightSize: 220,
                textDes: 'Thailand',
                img: AssetHelper.des6,
              ),
            ],
          ),
        ),
        SizedBox(
          width: getSize(16),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              DestinationItem(
                size: widget.size,
                heightSize: 140,
                textDes: 'VietNam',
                img: AssetHelper.des5,
              ),
              DestinationItem(
                size: widget.size,
                heightSize: 220,
                textDes: 'Chicago',
                img: AssetHelper.des4,
              ),
              DestinationItem(
                size: widget.size,
                heightSize: 140,
                textDes: 'Sydney',
                img: AssetHelper.city_5,
              ),
              DestinationItem(
                size: widget.size,
                heightSize: 140,
                textDes: 'Hawaii',
                img: AssetHelper.city_6,
              ),
              DestinationItem(
                size: widget.size,
                heightSize: 220,
                textDes: 'Bangkok',
                img: AssetHelper.city_7,
              ),
              DestinationItem(
                size: widget.size,
                heightSize: 140,
                textDes: 'Dubai',
                img: AssetHelper.city_8,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
