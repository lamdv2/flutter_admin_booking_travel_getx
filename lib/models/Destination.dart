import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';

class Destination {
  int idDes;
  String nameDes;
  String? imgDes;
  double? starDes;
  bool isFavorite;

  Destination(this.idDes, this.nameDes, this.imgDes, this.starDes, this.isFavorite);

}

List<Destination> destiList = [];
final List<int> listIds = [1, 2, 3, 4, 5, 6];

final List<String> listImgBackgrounds = [
  AssetHelper.des1,
  AssetHelper.des7,
  AssetHelper.des3,
  AssetHelper.des4,
  AssetHelper.des5,
  AssetHelper.des6,
];

List<Destination> addListDestination(List<Destination> addDesList) {
  for (int i = 1; i <= listIds.length; i++) {
    addDesList.add(Destination(i, "nameDes + ${i}", listImgBackgrounds[i-1], 4.5, false));
  }
  return addDesList;
}

