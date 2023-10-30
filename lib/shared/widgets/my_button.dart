import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String textBtn;
  final Color? colorBgr;
  final double? widthSize;
  final double? borderSize;

  const MyButton({
    Key? key,
    required this.onTap,
    required this.textBtn,
    this.colorBgr,
    this.widthSize,
    this.borderSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorBgr ?? ColorConstants.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderSize ?? 16),
        ),
      ),
      child: Container(
        width: widthSize ?? MediaQuery.of(context).size.width / 2.5,
        padding: EdgeInsets.symmetric(
          horizontal: getSize(16),
          vertical: getSize(12),
        ),
        child: Center(
          child: Text(
            textBtn,
            style: TextStyle(
              color: Colors.grey.shade200,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
