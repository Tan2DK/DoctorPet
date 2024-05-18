import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/data/request/prescription_medicine_request.dart';
import 'package:doctor_pet/core/data/response/appointment_response.dart';
import 'package:doctor_pet/core/data/response/medicine_response.dart';
import 'package:doctor_pet/core/repos/medicine_repo.dart';
import 'package:doctor_pet/utils/app_helper.dart';

import '../../../../common_widget/data_title_widget.dart';
import '../../../../core/data/data_title_model.dart';
import '../../../../core/data/response/medicine_category_response.dart';

class CreateBillingDialog extends StatefulWidget {
  const CreateBillingDialog({
    Key? key,
    required this.categories,
    required this.medicineRepo,
    required this.appointment,
    this.createBilling,
  }) : super(key: key);
  final List<MedicineCategoryResponse> categories;
  final MedicineRepo? medicineRepo;
  final AppointmentResponse appointment;
  final Function(AppointmentResponse, String, String,
      List<PrescriptionMedicineRequest>)? createBilling;

  @override
  State<CreateBillingDialog> createState() => _CreateBillingDialogState();
}

class _CreateBillingDialogState extends State<CreateBillingDialog> {
  List<(int, PrescriptionMedicineRequest?)> list = [];
  List<MedicineResponse> medicineList = [];
  MedicineCategoryResponse? medicineCategory;
  Timer? _debounce;

  final medicineController = TextEditingController();
  final reasonController = TextEditingController();
  final diagnosisController = TextEditingController();
  final dropdownController = TextEditingController();

  void onSearchChanged() {
    if (widget.appointment.clinic?.clinicId?.isEmpty ?? true) return;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final response = await widget.medicineRepo?.searchMedicine(
        limit: 10,
        offset: 0,
        clinicId: widget.appointment.clinic?.clinicId ?? '',
        medicineCategoryId: medicineCategory?.id ?? '',
        keyword: medicineController.text,
      );
      response?.fold(
        (l) => AppHelper.showErrorMessage('Get Medicine', l),
        (r) => setState(() {
          medicineList = r?.medicines ?? [];
        }),
      );
    });
  }

  bool checkIsAdded(MedicineResponse medicine) {
    bool isAdded = false;
    for (var element in list) {
      if (element.$2?.medicineId == medicine.medicineId) {
        isAdded = true;
        return isAdded;
      }
    }
    return isAdded;
  }

  void addListMedicine(MedicineResponse medicine) {
    if (checkIsAdded(medicine) == true) return;
    setState(() {
      list.add(
        (
          medicine.inventory ?? 0,
          PrescriptionMedicineRequest(
            medicineId: medicine.medicineId,
            name: medicine.medicineName,
            quantity: 1,
          ),
        ),
      );
    });
  }

  void removeListMedicine(MedicineResponse medicine) {
    setState(() {
      list.removeWhere(
        (element) => element.$2?.medicineId == medicine.medicineId,
      );
    });
  }

  void increaseQuantity(int index) {
    if (list[index].$2?.quantity == list[index].$1) return;
    setState(() {
      list[index] = (
        list[index].$1,
        list[index].$2?.copyWith(quantity: (list[index].$2?.quantity ?? 0) + 1)
      );
    });
  }

  void decreaseQuantity(int index) {
    if (list[index].$2?.quantity == 1) return;
    setState(() {
      list[index] = (
        list[index].$1,
        list[index].$2?.copyWith(quantity: (list[index].$2?.quantity ?? 0) - 1)
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(32),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 700, maxWidth: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(
              'Create billing',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 44,
                    child: DropdownMenu(
                      controller: dropdownController,
                      dropdownMenuEntries: widget.categories
                          .map((e) =>
                              DropdownMenuEntry(value: e, label: e.name ?? ''))
                          .toList(),
                      enableFilter: true,
                      enableSearch: true,
                      label: const Text('Medicine Categories'),
                      onSelected: (value) => setState(() {
                        medicineCategory = value;
                        onSearchChanged();
                      }),
                      trailingIcon: medicineCategory != null
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  dropdownController.clear();
                                  medicineCategory = null;
                                  onSearchChanged();
                                }),
                                child: const Icon(Icons.clear),
                              ),
                            )
                          : null,
                      menuHeight: 200,
                      expandedInsets: EdgeInsets.zero,
                    ).paddingSymmetric(horizontal: 16),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 44,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Medicine',
                      ),
                      controller: medicineController,
                      onChanged: (_) => onSearchChanged(),
                    ).paddingSymmetric(horizontal: 16),
                  ),
                  const SizedBox(height: 8),
                  if (medicineList.isNotEmpty) ...[
                    const Text('Medicine in clinic'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: DataTitleWidget(
                            leftSpacing: 16,
                            verticalPadding: 6,
                            titles: [
                              DataTitleModel(name: 'Name', flex: 2),
                              DataTitleModel(name: 'Inventory', flex: 1),
                              DataTitleModel(name: 'Unit', flex: 1),
                              DataTitleModel(name: 'Price', flex: 1),
                            ],
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ).paddingSymmetric(horizontal: 16),
                    const Divider(thickness: 2, height: 0)
                        .paddingSymmetric(horizontal: 16),
                  ],
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 0),
                      itemBuilder: (context, index) => Row(
                        children: [
                          Expanded(
                            child: DataTitleWidget(
                              leftSpacing: 16,
                              verticalPadding: 6,
                              titles: [
                                DataTitleModel(
                                    name:
                                        medicineList[index].medicineName ?? '',
                                    flex: 2),
                                DataTitleModel(
                                    name: medicineList[index].inventory == null
                                        ? ''
                                        : medicineList[index]
                                            .inventory
                                            .toString(),
                                    flex: 1),
                                DataTitleModel(
                                    name:
                                        medicineList[index].medicineUnit ?? '',
                                    flex: 1),
                                DataTitleModel(
                                    name: medicineList[index].prices == null
                                        ? ''
                                        : medicineList[index].prices.toString(),
                                    flex: 1),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 24,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(4),
                              onTap: !checkIsAdded(medicineList[index])
                                  ? () => addListMedicine(medicineList[index])
                                  : null,
                              child: Icon(
                                Icons.add_box_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 24,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(4),
                              onTap: checkIsAdded(medicineList[index])
                                  ? () =>
                                      removeListMedicine(medicineList[index])
                                  : null,
                              child: Icon(
                                Icons.delete_outline_outlined,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      itemCount: medicineList.length,
                    ).paddingSymmetric(horizontal: 16),
                  ),
                  const SizedBox(height: 8),
                  if (list.isNotEmpty) ...[
                    const Text('Medicine for examination'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: DataTitleWidget(
                            leftSpacing: 16,
                            verticalPadding: 6,
                            titles: [
                              DataTitleModel(name: 'Name', flex: 2),
                              DataTitleModel(name: 'Inventory', flex: 1),
                            ],
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 16),
                    const Divider(thickness: 2, height: 0)
                        .paddingSymmetric(horizontal: 16),
                  ],
                  Expanded(
                    child: ListView(
                      children: list
                          .asMap()
                          .map(
                            (index, v) => MapEntry(
                              index,
                              Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      list[index].$2?.name ?? '',
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: InkWell(
                                            onTap: () =>
                                                increaseQuantity(index),
                                            child: Icon(
                                              Icons.add_circle_rounded,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          list[index].$2?.quantity == null
                                              ? ''
                                              : list[index]
                                                  .$2!
                                                  .quantity
                                                  .toString(),
                                        ),
                                        const SizedBox(width: 4),
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: InkWell(
                                            onTap: () =>
                                                decreaseQuantity(index),
                                            child: Icon(
                                              Icons.remove_circle_rounded,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                                  .paddingSymmetric(vertical: 4)
                                  .paddingOnly(left: 16),
                            ),
                          )
                          .values
                          .toList(),
                    ).paddingSymmetric(horizontal: 16),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 44,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Diagnosis',
                      ),
                      controller: diagnosisController,
                    ).paddingSymmetric(horizontal: 16),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 44,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Reason',
                      ),
                      controller: reasonController,
                    ).paddingSymmetric(horizontal: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 44,
              child: FilledButton(
                onPressed: () => widget.createBilling?.call(
                    widget.appointment,
                    diagnosisController.text,
                    reasonController.text,
                    list
                        .map((e) => e.$2 ?? PrescriptionMedicineRequest())
                        .toList()),
                child: const Text('Create Billing'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
