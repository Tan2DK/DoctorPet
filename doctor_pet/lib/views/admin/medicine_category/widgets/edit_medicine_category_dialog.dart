import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common_widget/custom_text/custom_text_widget.dart';
import '../../../../core/data/request/medicine_category_request.dart';

class EditMedicineCategoryDialog extends StatefulWidget {
  const EditMedicineCategoryDialog({
    Key? key,
    this.medicineCategory,
    this.selectDate,
    this.onAddEditMedicineCategory,
  }) : super(key: key);

  final MedicineCategoryRequest? medicineCategory;
  final Function(BuildContext, DateTime, bool)? selectDate;
  final Function(MedicineCategoryRequest)? onAddEditMedicineCategory;

  @override
  State<EditMedicineCategoryDialog> createState() =>
      _EditMedicineCategoryDialogState();
}

class _EditMedicineCategoryDialogState
    extends State<EditMedicineCategoryDialog> {
  final TextEditingController textControllerName = TextEditingController();

  @override
  void initState() {
    super.initState();
    textControllerName.text = widget.medicineCategory?.name ?? '';

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomTextWidget(
        text: '${widget.medicineCategory != null ? 'Edit' : 'Add'} Medicine Category',
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
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => widget.onAddEditMedicineCategory?.call(
            MedicineCategoryRequest(
              id: widget.medicineCategory?.id,
              name: textControllerName.text,
            ),
          ),
          child: CustomTextWidget(
            text: widget.medicineCategory != null ? 'Edit' : 'Add',
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
