import 'package:advocatepro_f/features/lawyer/controller/add_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/images/s_circular_image.dart';
import '../../../../../../utils/constants/color.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/validators/check_method.dart';

class AddDetailForm extends StatelessWidget {
  const AddDetailForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddDetailController());
    return Form(
        child: Column(
      children: [
        TextFormField(
          controller: controller.name,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            labelText: 'Title',
            hintText: 'Which appear on client screen',
            prefixIcon: Icon(
              Icons.person_2,
              color: SColors.iconColor,
            ),
          ),
          validator: (value) => SValidator.checkname(value),
        ),
        const SizedBox(
          height: SSizes.spaceBtwInputFields,
        ),

        DropdownButtonFormField<String>(
          menuMaxHeight: 500,
          isExpanded: true,
          decoration: const InputDecoration(
            labelText: 'Specialization',
            hintText: "Select or add your specialization",
            prefixIcon: Icon(
              Icons.personal_injury_outlined,
              color: SColors.iconColor,
            ),
          ),
          value: controller.selectedSpecialization.value.isNotEmpty
              ? controller.selectedSpecialization.value
              : null,
          items: controller.specializationOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: controller.onSpecializationChanged,
        ),

        // if (controller.isCustomSpecialization.value)
        //   TextFormField(
        //     controller: controller.specialization,
        //     decoration: const InputDecoration(
        //       labelText: 'Custom Specialization',
        //       hintText: 'Enter your specialization',
        //     ),
        //     onChanged: (value) {
        //       controller.selectedSpecialization = value;
        //     },
        //   ),
        const SizedBox(
          height: SSizes.spaceBtwInputFields,
        ),
        TextFormField(
          maxLines: null,
          controller: controller.description,
          decoration: const InputDecoration(
            labelText: 'Description',
            hintText: "Add information about yourself",
            prefixIcon: Icon(
              Icons.personal_injury_outlined,
              color: SColors.iconColor,
            ),
          ),
          validator: (value) => SValidator.checkEmail(value),
        ),
        const SizedBox(
          height: SSizes.spaceBtwInputFields,
        ),

        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Obx(() {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: controller.photoUrls.map((url) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SCircularImage(
                          image: url.isNotEmpty ? url : SImages.noimage,
                          width: 80,
                          height: 80,
                          isNetworkImage: url.isNotEmpty,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
              Obx(() {
                final uploadimage = controller.photoURL.value;
                final image =
                    uploadimage.isNotEmpty ? uploadimage : SImages.noimage;
                return controller.imageUplodaing.value
                    ? const CircularProgressIndicator()
                    : SCircularImage(
                        image: image,
                        width: 80,
                        height: 80,
                        isNetworkImage: uploadimage.isNotEmpty,
                        fit: BoxFit.cover,
                      );
              }),
              TextButton(
                  onPressed: () => controller.uploadPicture(),
                  child: const Text('Upload one or more image')),
            ],
          ),
        ),
        // check box
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Obx(
                () => Checkbox(
                    checkColor: Colors.white,
                    activeColor: SColors.primary,
                    value: controller.checkAgency.value,
                    onChanged: (value) => controller.checkAgency.value =
                        !controller.checkAgency.value),
              ),
            ),
            const SizedBox(
              width: SSizes.spaceBetweenItems,
            ),
            Text(
              'If you working under someone or agency',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),

        ///Bar Number
        Obx(() {
          if (controller.checkAgency.value) {
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  TextFormField(
                      controller: controller.agencyId,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_pin_rounded),
                        labelText: "Agency ID",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        return SValidator.checkDigits(value);
                      }),
                  const SizedBox(
                    height: SSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    controller: controller.agencyName,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Agency Name',
                      hintText: 'Name agency you are working under',
                      prefixIcon: Icon(
                        Icons.person_pin_rounded,
                        color: SColors.iconColor,
                      ),
                    ),
                    validator: (value) => SValidator.checkname(value),
                  ),
                  const SizedBox(
                    height: SSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                      controller: controller.lawyerAgencyId,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_pin_rounded),
                        labelText: "ID Number by agency",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        return SValidator.checkDigits(value);
                      }),
                ],
              ),
            );
          }
          return const SizedBox();
        }),
        const SizedBox(
          height: SSizes.spaceBtwInputFields,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => controller.uploadDetail(),
              child: const Text('Upload')),
        ),
      ],
    ));
  }
}
