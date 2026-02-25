import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/domain/entities/country_entity.dart';
import 'package:qent/core/helpers/helper_methods.dart';
import 'package:qent/core/presentation/widgets/custom_text_form_field.dart';
import 'package:qent/core/presentation/widgets/select_country_dialog.dart';
import 'package:qent/generated/l10n.dart';

class CountryAndPhoneTextField extends StatefulWidget {
  const CountryAndPhoneTextField({
    super.key,
    required this.controller,
    required this.onSelectCountry,

    this.validate,
  });
  final TextEditingController controller;
  final Function(CountryEntity) onSelectCountry;

  final String? Function(String?)? validate;

  @override
  State<CountryAndPhoneTextField> createState() =>
      _CountryAndPhoneTextFieldState();
}

class _CountryAndPhoneTextFieldState extends State<CountryAndPhoneTextField> {
  CountryEntity? _country;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      validate: widget.validate,
      controller: widget.controller,
      hintText: S.current.phoneNumber,
      maxLength: 10,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.phone,
      prefix: SizedBox(
        width: 100.w,
        child: GestureDetector(
          onTap: () async {
            final country = await showCountriesDialog(context);
            if (country != null) {
              setState(() {
                _country = country;
                widget.onSelectCountry(_country!);
              });
            }
          },
          child: _CountryCodeWidget(_country),
        ),
      ),
    );
  }
}

class _CountryCodeWidget extends StatelessWidget {
  const _CountryCodeWidget(this._country);

  final CountryEntity? _country;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodySmall;
    return Row(
      children: [
        const Spacer(),
        const Icon(Icons.arrow_drop_down),
        5.horizontalSpace,
        Text(
          _country != null ? getFlagEmoji(_country!.abbreviation) : '🌍',
          style: style!.copyWith(fontSize: 25.sp),
        ),
        const Spacer(),
        Text(
          '|',
          style: style.copyWith(fontSize: 25.sp, fontWeight: FontWeight.w700),
        ),
        10.horizontalSpace,
      ],
    );
  }
}
