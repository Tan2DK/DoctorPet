import 'package:doctor_pet/common_widget/custom_text/custom_text_widget.dart';
import 'package:doctor_pet/core/data/data_title_model.dart';
import 'package:flutter/material.dart';
import 'package:doctor_pet/common_widget/data_title_widget.dart';
import 'package:get/get.dart';
import 'clinic_pet_category_controller.dart';

class ClinicPetCategoryView extends GetView<ClinicPetCategoryController> {
  const ClinicPetCategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            const Row(
              children: [
                SizedBox(width: 50),
                CustomTextWidget(
                  text: 'Pet Category of Clinic',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: controller.showMenu,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Edit Pet Category'),
                    SizedBox(width: 16),
                    Icon(Icons.arrow_forward_ios_rounded, size: 18),
                  ],
                ),
              ).paddingSymmetric(horizontal: 16),
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 3, height: 0),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        DataTitleWidget(
                          leftSpacing: 16,
                          verticalPadding: 8,
                          titles: [
                            DataTitleModel(name: 'Pet Category ID', flex: 1),
                            DataTitleModel(name: 'Pet Category Name', flex: 1),
                          ],
                        ),
                        const Divider(thickness: 3, height: 0),
                        Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const Divider(height: 0),
                            itemBuilder: (context, index) => DataTitleWidget(
                              leftSpacing: 16,
                              verticalPadding: 8,
                              titles: [
                                DataTitleModel(
                                    name: controller.selectedPetCategoryList
                                            .value[index].petTypeId ??
                                        '',
                                    flex: 4),
                                DataTitleModel(
                                    name: controller.selectedPetCategoryList
                                            .value[index].petTypeName ??
                                        '',
                                    flex: 4),
                              ],
                            ),
                            itemCount:
                                controller.selectedPetCategoryList.value.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (controller.isShowMenu.value) ...[
                    const VerticalDivider(width: 0, thickness: 2),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Text(
                              'Choose Pet Category for your clinic',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              runSpacing: 16,
                              spacing: 16,
                              children: controller.petCategoryList.value.entries
                                  .map(
                                    (e) => ChoiceChip(
                                      showCheckmark: true,
                                      label: Text(e.key.petTypeName ?? ''),
                                      selected: e.value,
                                      onSelected: (value) {
                                        controller.petCategoryList
                                            .value[e.key] = value;
                                        controller.petCategoryList.refresh();
                                        controller.checkButton();
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 16),
                            Align(
                              alignment: Alignment.centerRight,
                              child: FilledButton(
                                onPressed: controller.isUpdateEnable.isFalse
                                    ? null
                                    : controller.updatePetCategoriesByClinic,
                                child: const Text('Update'),
                              ).paddingSymmetric(horizontal: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
