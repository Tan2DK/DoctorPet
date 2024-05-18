import 'package:doctor_pet/views/map/widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:doctor_pet/views/map/map_controller.dart';

class MapView extends GetView<MapController> {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [
            // InkWell(
            //   onTap: controller.calculateRouteDistance,
            //   child: const Text('Calculate Distance'),
            // ),
            // Obx(() => Text(controller.distance.value.toString())),
            Expanded(
              child: Center(
                child: FutureBuilder(
                    future: controller.fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.data == true) {
                        return
                            //  Wrap(
                            //   children: controller.markers
                            //       .map((e) => Text(e.toString()))
                            //       .toList(),
                            // );
                           Obx(() =>  MapWidget(
                          position: controller.position,
                          onMapCreated: controller.onMapCreated,
                          markers: controller.markers,
                          polylines: controller.polylines.value,
                        ));
                      }
                      return const Center(
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator()));
                    }),
              ),
            ),
            //   // Stack(
            //   //   children: [
            //   // Obx(
            //   //   () => MapWidget(
            //   //     position: controller.position.value,
            //   //     onMapCreated: controller.onMapCreated,
            //   //     markers: controller.markers.value,
            //   //     polylines: controller.polylines.value,
            //   //   ),
            //   // ),
            //   // Positioned(
            //   //   child: ClipOval(
            //   //     child: Material(
            //   //       color: Colors.orange.shade100, // button color
            //   //       child: InkWell(
            //   //         splashColor: Colors.orange, // inkwell color
            //   //         child: const SizedBox(
            //   //           width: 56,
            //   //           height: 56,
            //   //           child: Icon(Icons.my_location),
            //   //         ),
            //   //         onTap: () async {
            //   //           if (controller.myCamPos == null) return;
            //   //           EasyLoading.show();
            //   //           await controller.mapController.animateCamera(
            //   //             CameraUpdate.newCameraPosition(
            //   //               controller.myCamPos!,
            //   //             ),
            //   //           );
            //   //           EasyLoading.dismiss();
            //   //         },
            //   //       ),
            //   //     ),
            //   //   ),
            //   // ),
            //   // Positioned(
            //   //   right: 0,
            //   //   bottom: 0,
            //   //   child: ClipOval(
            //   //     child: Material(
            //   //       color: Colors.orange.shade100, // button color
            //   //       child: InkWell(
            //   //         splashColor: Colors.orange, // inkwell color
            //   //         child: const SizedBox(
            //   //           width: 56,
            //   //           height: 56,
            //   //           child: Icon(Icons.my_location),
            //   //         ),
            //   //         onTap: () async {
            //   //           controller.moveCameraBoundary();
            //   //         },
            //   //       ),
            //   //     ),
            //   //   ),
            //   // ),
            //   // Positioned(
            //   //   left: 0,
            //   //   bottom: 0,
            //   //   child: ClipOval(
            //   //     child: Material(
            //   //       color: Colors.orange.shade100, // button color
            //   //       child: InkWell(
            //   //         splashColor: Colors.orange, // inkwell color
            //   //         child: const SizedBox(
            //   //           width: 56,
            //   //           height: 56,
            //   //           child: Icon(Icons.my_location),
            //   //         ),
            //   //         onTap: () async {
            //   //           EasyLoading.show();
            //   //           controller.drawLine();
            //   //           EasyLoading.dismiss();
            //   //         },
            //   //       ),
            //   //     ),
            //   //   ),
            //   // ),
            //   // ],
            //   // ),
            // ),
          ],
        ),
      ),
    );
  }
}
