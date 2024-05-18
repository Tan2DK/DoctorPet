import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/utils/app_assets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:doctor_pet/utils/app_constant.dart';
import '../customer/customer_booking/customer_booking_controller.dart';

class MapController extends GetxController {
  // LatLng(10.84427, 106.8375)
  // LatLng(10.844, 106.836)
  StreamSubscription? subscription;
  CameraPosition? position;
  Position? myPos;
  // const CameraPosition(target: LatLng(10.7952, 106.7192), zoom: 18);
  GoogleMapController? mapController;
  CustomerBookingController? customerBookingController;
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Rx<Map<PolylineId, Polyline>> polylines = Rx({});
  Rx<double> distance = Rx(0);
  Rxn<List<Map<String, double>>> distanceCrnLocationToBranches = Rxn();
  Function(Function(LatLng)?, Function(LatLng)?)? moveCameraCallBack;
  Set<Marker> markers = {};
  MapController({
    this.moveCameraCallBack,
    this.myPos,
  });

  void animateCamera() {
    if (customerBookingController?.selectedBranch == null) return;
    final branch = customerBookingController?.selectedBranch.value;
    position =
        CameraPosition(target: branch?.latlng ?? const LatLng(0, 0), zoom: 18);
    mapController?.animateCamera(CameraUpdate.newCameraPosition(position!));
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    moveCameraCallBack?.call(onMoveCamera, drawLine);

    // await getCurrentLocation();
    if (!Get.isRegistered<CustomerBookingController>()) return;
    customerBookingController = Get.find<CustomerBookingController>();
  }

  Future<bool> fetchData() async {
    await Future(
      () async {
        addBranchMarkers();
        await setCurrentLocationMarker();
        try {
          subscription =
              customerBookingController?.selectedBranch.stream.listen(
            (event) {
              animateCamera();
            },
          );
        } catch (_) {
          return false;
        }
      },
    ).then((value) {
      animateCamera();
    });
    return true;
  }

  void addBranchMarkers() {
    if (customerBookingController?.branchList.value.isEmpty ?? true) return;
    markers = customerBookingController!.branchList.value
        .map(
          (branch) => Marker(
            markerId: MarkerId(branch.id),
            position: branch.latlng ?? const LatLng(0, 0),
          ),
        )
        .toSet();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (position == null) return;
    mapController?.animateCamera(CameraUpdate.newCameraPosition(position!));
  }

  void onMoveCamera(LatLng latLng) {
    position = CameraPosition(target: latLng, zoom: 18);
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(position!),
    );
  }

  Future<void> setCurrentLocationMarker() async {
    try {
      if (myPos == null) return;
      Set<Marker> newMarkers = markers;
      Marker myMarker = Marker(
        markerId: const MarkerId('my_marker'),
        position: LatLng(myPos!.latitude, myPos!.longitude),
        icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(32, 32)),
            AppImages.icCurrentLocation),
      );
      newMarkers.add(myMarker);
      markers = newMarkers;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> moveCameraBoundary(LatLng latLng) async {
    if (myPos == null) {
      return;
    }
    double minLat = (latLng.latitude <= myPos!.latitude)
        ? latLng.latitude
        : myPos!.latitude;
    double minLng = (latLng.longitude <= myPos!.longitude)
        ? latLng.longitude
        : myPos!.longitude;
    double maxLat = (latLng.latitude <= myPos!.latitude)
        ? myPos!.latitude
        : latLng.latitude;
    double maxLng = (latLng.longitude <= myPos!.longitude)
        ? myPos!.longitude
        : latLng.longitude;

    await mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(
            maxLat,
            maxLng,
          ),
          southwest: LatLng(
            minLat,
            minLng,
          ),
        ),
        18,
      ),
    );
  }

  Future<void> drawLine(LatLng latLng) async {
    if (myPos?.latitude == null || myPos?.longitude == null) {
      return;
    }
    try {
      polylines.value.clear();
      final res = await polylinePoints.getRouteBetweenCoordinates(
        StringConstant.googleMapKey,
        PointLatLng(myPos!.latitude, myPos!.longitude),
        PointLatLng(latLng.latitude, latLng.longitude),
      );
      if (res.points.isEmpty) return;
      polylineCoordinates = res.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();

      PolylineId id = const PolylineId('polyId');
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        width: 5,
      );
      polylines.value[id] = polyline;
      polylines.refresh();
      moveCameraBoundary(latLng);
    } catch (e) {
      log(e.toString());
    }
  }
}
