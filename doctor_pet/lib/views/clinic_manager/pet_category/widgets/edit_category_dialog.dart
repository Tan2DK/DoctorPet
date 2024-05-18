import 'package:doctor_pet/core/data/request/pet_category_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common_widget/custom_text/custom_text_widget.dart';

class EditCategoryDialog extends StatefulWidget {
  const EditCategoryDialog({
    Key? key,
    this.petCategory,
    this.index,
    this.addEditPetCategory,
  }) : super(key: key);
  final PetCategoryRequest? petCategory;
  final int? index;
  final Function(PetCategoryRequest)? addEditPetCategory;

  @override
  State<EditCategoryDialog> createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  final textControllerCateName = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.petCategory == null) return;
    textControllerCateName.text = widget.petCategory!.petTypeName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomTextWidget(
        text: '${widget.petCategory != null ? 'Edit' : 'Add'} Pet Category',
        fontWeight: FontWeight.bold,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            keyboardType: TextInputType.text,
            controller: textControllerCateName,
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              labelText: 'Pet Category Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => widget.addEditPetCategory?.call(
            PetCategoryRequest(
              petTypeId: widget.petCategory?.petTypeId,
              petTypeName: textControllerCateName.text,
            ),
          ),
          child: CustomTextWidget(
            text: widget.petCategory != null ? 'Edit' : 'Add',
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
