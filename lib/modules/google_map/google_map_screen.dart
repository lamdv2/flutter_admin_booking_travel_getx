import 'dart:async';

import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geolocator;

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  MapType currentMapType = MapType.normal;

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  geolocator.Position? currentPosition;

  BitmapDescriptor? customIcon;
  BitmapDescriptor? customIconLocation;

  @override
  void initState() {
    super.initState();
    getCurrentPossition();
    getPolyline('16.05786987902542', '108.21159745424494');
    loadImageMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: ((GoogleMapController controller) =>
                mapController.complete(controller)),
            initialCameraPosition: CameraPosition(
              target: currentPosition != null
                  ? LatLng(
                      currentPosition!.latitude,
                      currentPosition!.longitude,
                    )
                  : const LatLng(16.0321926, 108.2198714),
              zoom: 12,
            ),
            markers: {
              Marker(
                markerId: const MarkerId("_currentLocation"),
                // icon: BitmapDescriptor.defaultMarker,
                icon: customIcon ??
                    BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                position: currentPosition != null
                    ? LatLng(
                        currentPosition?.latitude ?? 0,
                        currentPosition?.longitude ?? 0,
                      )
                    : const LatLng(
                        16.0321926,
                        108.2298714,
                      ),
                draggable: true,
                onDragEnd: (value) {},
              ),
              Marker(
                markerId: const MarkerId("_location_one"),
                icon: customIconLocation ??
                    BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen),
                position: const LatLng(16.0321926, 108.2198714),
              ),
              Marker(
                markerId: const MarkerId("_location_two"),
                icon: customIconLocation ??
                    BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueMagenta),
                position: const LatLng(16.0421926, 108.2098714),
              ),
              Marker(
                markerId: const MarkerId("_location_three"),
                icon: customIconLocation ??
                    BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueCyan),
                position: const LatLng(16.05786987902542, 108.21159745424494),
              ),
              Marker(
                markerId: const MarkerId("_location_four"),
                icon: customIconLocation ??
                    BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueOrange),
                position: const LatLng(16.0311715, 108.2099274),
              ),
            },
            polylines: Set<Polyline>.of(polylines.values),
            mapType: currentMapType,
          ),
          Container(
            padding: EdgeInsets.only(
              top: getSize(36),
              right: getSize(24),
            ),
            alignment: Alignment.topRight,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "btn1",
                  backgroundColor: ColorConstants.green,
                  onPressed: () {
                    changeMapType();
                  },
                  child: const Icon(
                    Icons.map,
                    size: 20,
                  ),
                ),
                SizedBox(
                  height: getSize(12),
                ),
                FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: () {
                    changeMapType01();
                  },
                  child: const Icon(
                    Icons.maps_ugc,
                    size: 20,
                  ),
                ),
                SizedBox(
                  height: getSize(12),
                ),
                FloatingActionButton(
                  heroTag: "btn3",
                  backgroundColor: ColorConstants.secondColor,
                  onPressed: () {
                    changeMapType02();
                  },
                  child: const Icon(
                    Icons.maps_home_work,
                    size: 20,
                  ),
                ),
                SizedBox(
                  height: getSize(12),
                ),
                FloatingActionButton(
                  heroTag: "btn4",
                  backgroundColor: ColorConstants.flights,
                  onPressed: () {
                    changeMapType03();
                  },
                  child: const Icon(
                    Icons.home,
                    size: 20,
                  ),
                ),
                SizedBox(
                  height: getSize(64),
                ),
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorConstants.accent2.withOpacity(.2),
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: ColorConstants.darkGray,
                          offset: Offset(0, 4),
                          blurRadius: 8,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () => loadImageMarker(),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: ColorConstants.white,
                        child: Image.asset(
                          'assets/icons/ic_current_location.png',
                          color: ColorConstants.primaryButton,
                          height: getSize(32),
                          width: getSize(32),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getPolyline(String destLatitude, String destLongitude) async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      currentPosition = await geolocator.Geolocator.getCurrentPosition(
        desiredAccuracy: geolocator.LocationAccuracy.best,
      );
      final result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyB-Lyksir7H6TAkkMk4PxNUkOz3KyuV9y4',
        // AIzaSyBD6fP1hIB0vbwy9s8AixLhVhYTLaSLw8Y
        PointLatLng(currentPosition?.latitude ?? 16.05786987902542,
            currentPosition?.longitude ?? 108.21159745424494),
        PointLatLng(
          double.parse(destLatitude),
          double.parse(destLongitude),
        ),
        travelMode: TravelMode.transit,
      );

      polylineCoordinates.clear();

      if (result.points.isNotEmpty) {
        for (final point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      }
      _addPolyLine();
    } else if (status.isDenied) {
      Get.snackbar('Error!!!', 'Error permission!');
    }
  }

  Future<void> getCurrentPossition() async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      currentPosition = await geolocator.Geolocator.getCurrentPosition(
        desiredAccuracy: geolocator.LocationAccuracy.best,
      );
      polylineCoordinates.clear();
    } else if (status.isDenied) {
      Get.snackbar('Error!!!', 'Error permission!');
    }
  }

  void _addPolyLine() {
    setState(
      () {
        const id = PolylineId('poly');
        final polyline = Polyline(
          polylineId: id,
          color: Colors.blue,
          points: polylineCoordinates,
          width: 4,
        );
        polylines[id] = polyline;
      },
    );
  }

  void loadImageMarker() async {
    final customCurrentMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
        size: Size(12, 12),
      ),
      'assets/icons/ic_current_marker.png',
    );

    final customIconMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(
        size: Size(12, 12),
      ),
      'assets/icons/ic_marker_map.png',
    );

    setState(() {
      customIcon = customCurrentMarker;
      customIconLocation = customIconMarker;
    });
  }

  void changeMapType() {
    setState(() {
      currentMapType = MapType.hybrid;
    });
  }

  void changeMapType01() {
    setState(() {
      currentMapType = MapType.satellite;
    });
  }

  void changeMapType02() {
    setState(() {
      currentMapType = MapType.terrain;
    });
  }

  void changeMapType03() {
    setState(() {
      currentMapType = MapType.normal;
    });
  }
}
