import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/helpers/validator.dart';
import 'package:qent/core/presentation/widgets/custom_text_form_field.dart';
import 'package:qent/core/resources/color_manager.dart';
import 'package:qent/generated/l10n.dart';

class AvailableToCreateCar extends StatefulWidget {
  final TextEditingController nIDController;
  final TextEditingController dobController;
  final Function(bool isChecked) onChanged;

  const AvailableToCreateCar({
    super.key,
    required this.onChanged,
    required this.nIDController,
    required this.dobController,
  });

  @override
  State<AvailableToCreateCar> createState() => _AvailableToCreateCarState();
}

class _AvailableToCreateCarState extends State<AvailableToCreateCar> {
  bool isChecked = false;

  DateTime? selectedDate;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectedDate = picked;
      widget.dobController.text =
          '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() => isChecked = value ?? false);
                widget.onChanged(value ?? false);
              },
              activeColor: ColorManager.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
            10.horizontalSpace,
            Text(
              S.current.availableToCreateCar,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        if (isChecked) ...[
          12.verticalSpace,
          CustomTextFormField(
            controller: widget.nIDController,
            keyboardType: TextInputType.number,
            maxLength: 14,
            hintText: S.current.nationalID,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validate: Validator.isValidNID,
          ),
          12.verticalSpace,
          CustomTextFormField(
            controller: widget.dobController,
            readOnly: true,
            onTap: _pickDate,
            keyboardType: TextInputType.datetime,
            validate: Validator.isValidField,
            hintText: S.current.dateOfBirth,
          ),
        ],
      ],
    );
  }
}
