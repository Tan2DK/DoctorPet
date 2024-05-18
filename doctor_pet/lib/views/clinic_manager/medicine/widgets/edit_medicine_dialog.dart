import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:doctor_pet/core/data/request/medicine_request.dart';
import 'package:doctor_pet/core/data/response/medicine_category_response.dart';

import '../../../../common_widget/custom_text/custom_text_widget.dart';

class EditMedicineDialog extends StatefulWidget {
  const EditMedicineDialog({
    Key? key,
    this.medicine,
    this.medicineCategories,
    this.selectDate,
    this.onAddEditMedicine,
  }) : super(key: key);

  final MedicineRequest? medicine;
  final List<MedicineCategoryResponse>? medicineCategories;
  final Function(BuildContext, DateTime, bool)? selectDate;
  final Function(MedicineRequest)? onAddEditMedicine;

  @override
  State<EditMedicineDialog> createState() => _EditMedicineDialogState();
}

class _EditMedicineDialogState extends State<EditMedicineDialog> {
  final TextEditingController textControllerName = TextEditingController();
  final TextEditingController textControllerUnit = TextEditingController();
  final TextEditingController textControllerPrice = TextEditingController();
  final TextEditingController textControllerInventory = TextEditingController();
  final TextEditingController textControllerSpecifications =
      TextEditingController();
  MedicineCategoryResponse? selectedMedicineCategory;
  @override
  void initState() {
    super.initState();
    textControllerName.text = widget.medicine?.medicineName ?? '';
    textControllerUnit.text = widget.medicine?.medicineUnit ?? '';
    textControllerPrice.text = widget.medicine?.prices == null
        ? ''
        : widget.medicine!.prices.toString();
    textControllerInventory.text = widget.medicine?.inventory == null
        ? ''
        : widget.medicine!.inventory.toString();
    textControllerSpecifications.text = widget.medicine?.specifications ?? '';
    selectedMedicineCategory = widget.medicineCategories?.firstWhereOrNull((cate) => cate.id == widget.medicine?.medicineCateId);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomTextWidget(
        text: '${widget.medicine != null ? 'Edit' : 'Add'}Medicine',
        fontWeight: FontWeight.bold,
      ),
      content: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.text,
                controller: textControllerName,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<MedicineCategoryResponse>(
                items: widget.medicineCategories
                    ?.map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name ?? ''),
                      ),
                    )
                    .toList(),
                onChanged: (medicineCategory) => setState(() {
                  selectedMedicineCategory = medicineCategory;
                }),
                borderRadius: BorderRadius.circular(10),
                value: selectedMedicineCategory,
                itemHeight: 54.5,
                menuMaxHeight: 200,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                isExpanded: true,
                underline: const SizedBox.shrink(),
                hint: const Text('Category'),
              ),
            ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.text,
                controller: textControllerUnit,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Unit',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.text,
                controller: textControllerInventory,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Inventory',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                controller: textControllerPrice,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.text,
                controller: textControllerSpecifications,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                    labelText: 'Specifications',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => widget.onAddEditMedicine?.call(
            MedicineRequest(
              medicineId: widget.medicine?.medicineId,
              medicineName: textControllerName.text,
              inventory: int.tryParse(textControllerInventory.text),
              medicineUnit: textControllerUnit.text,
              specifications: textControllerSpecifications.text,
              medicineCateName: widget.medicine?.medicineCateName,
              prices: int.tryParse(textControllerPrice.text),
              medicineCateId: selectedMedicineCategory?.id,
            ),
          ),
          child: CustomTextWidget(
            text: widget.medicine != null ? 'Edit' : 'Add',
            txtColor: Colors.black,
          ),
        ),
        TextButton(
          onPressed: Get.back,
          child: const CustomTextWidget(
            text: 'Cancel',
            txtColor: Colors.black,
          ),
        ),
      ],
    );
  }
}
