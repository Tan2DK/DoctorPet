import 'package:doctor_pet/core/data/argument/customer_booking_argument.dart';
import 'package:doctor_pet/views/customer/customer_booking/widgets/branch_list_widget.dart';
import 'package:doctor_pet/views/schedule/schedule_controller.dart';
import 'package:doctor_pet/views/schedule/schedule_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../map/map_controller.dart';
import '../../map/map_view.dart';
import 'customer_booking_controller.dart';
import 'widgets/custom_steps_progress_bar_widget.dart';

class CustomerBookingView extends GetView<CustomerBookingController> {
  const CustomerBookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 300,
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Branches near you',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ).paddingSymmetric(horizontal: 10),
                  Expanded(
                    child: BranchListWidget(
                      branchList: controller.branchList.value,
                      selectedBranch: controller.selectedBranch.value,
                      onChanged: controller.onChanged,
                      onViewMap: controller.showMap,
                      onDrawLine: controller.showDrawLine,
                    ).paddingSymmetric(horizontal: 9),
                  ),
                ],
              ),
            ),
          ),
          const VerticalDivider(width: 0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Booking Processing',
                  style: Theme.of(context).textTheme.titleLarge,
                ).paddingSymmetric(horizontal: 10, vertical: 12),
                SizedBox(
                  child: Obx(
                    () => CustomStepsProgressBarWidget(
                      taskSize: 70,
                      lineLength: 80,
                      // ignore: invalid_use_of_protected_member
                      taskList: controller.taskList.value,
                    ),
                  ),
                ).paddingSymmetric(horizontal: 10, vertical: 12),
                const Divider(),
                Expanded(
                  child: Obx(
                    () => IndexedStack(
                      index: controller.index.value,
                      children: [
                        FutureBuilder(
                          future: controller.call,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.data == true) {
                              return GetBuilder(
                                builder: (controller) => const ScheduleView(),
                                init: ScheduleController(
                                  argument: CustomerBookingArgument(
                                    onSelectedSlot: controller.onSelectedSlot,
                                    availableSlots: controller.doctorSlot.value,
                                    onRefreshDoctorSlot: (function) =>
                                        controller.refreshDoctorSlot = function,
                                  ),
                                ),
                              ).paddingSymmetric(horizontal: 8);
                            }
                            return const Center(
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                        Center(
                          child: TextButton(
                              onPressed: () => controller.showMap(0, null),
                              child: const Text('Mappppp')),
                        ),
                        // FutureBuilder(
                        //   future: controller.call,
                        //   builder: (context, snapshot) {
                        //     if (snapshot.connectionState ==
                        //             ConnectionState.done &&
                        //         snapshot.data == true) {
                        //       return Stack(
                        //         children: [
                        //           GetBuilder(
                        //             builder: (controller) => const MapView(),
                        //             init: MapController(
                        //               myPos: controller.myPos,
                        //               moveCameraCallBack:
                        //                   (moveCamera, drawLine) {
                        //                 controller.onMoveCamera = moveCamera;
                        //                 controller.onDrawLine = drawLine;
                        //               },
                        //             ),
                        //           ),
                        //           Positioned(
                        //             right: 4,
                        //             top: 4,
                        //             child: IconButton(
                        //               onPressed: () =>
                        //                   controller.showMap(0, null),
                        //               icon: const Icon(Icons.close_rounded),
                        //             ),
                        //           ),
                        //         ],
                        //       );
                        //     }
                        //     return const SizedBox();
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    FilledButton(
                      onPressed: controller.onRegisterPet,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                        minimumSize: const Size(120, 56),
                      ),
                      child: const Text('Register Pet'),
                    ).paddingSymmetric(horizontal: 24, vertical: 24),
                    Obx(
                      () => FilledButton(
                        onPressed: !controller.taskList[1].isComplete ||
                                !controller.taskList[2].isComplete ||
                                controller.selectedSlot.value == null
                            ? null
                            : controller.onSubmit,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          minimumSize: const Size(120, 56),
                        ),
                        child: const Text('Submit'),
                      ).paddingSymmetric(horizontal: 24, vertical: 24),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
