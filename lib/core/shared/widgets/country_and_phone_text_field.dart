import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qent/core/models/country.dart';
import 'package:qent/core/resources/color_manager.dart';
import 'package:qent/core/router/app_router.dart';
import 'package:qent/core/shared/widgets/custom_text_form_field.dart';
import 'package:qent/generated/l10n.dart';

class CountryAndPhoneTextField extends StatefulWidget {
  const CountryAndPhoneTextField({
    super.key,
    required this.controller,
    required this.onSelectCountry,
    required this.isPhoneVerified,
  });
  final TextEditingController controller;
  final Function(Country) onSelectCountry;
  final bool isPhoneVerified;

  @override
  State<CountryAndPhoneTextField> createState() =>
      _CountryAndPhoneTextFieldState();
}

class _CountryAndPhoneTextFieldState extends State<CountryAndPhoneTextField> {
  late Country _country;
  @override
  void initState() {
    super.initState();
    _country = countries.first;
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge;
    return Stack(
      children: [
        CustomTextFormField(
          controller: widget.controller,
          hintText: S.current.phoneNumber,
          maxLength: _country.maxLength,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.phone,
          prefix: SizedBox(
            width: 105.w,
            child: GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (_) => Dialog(
                  constraints: BoxConstraints(
                    maxHeight: 400.h,
                    maxWidth: 300.w,
                  ),
                  child: ListView.builder(
                    itemCount: countries.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        setState(() {
                          _country = countries[index];
                          widget.onSelectCountry(_country);
                          widget.controller.clear();
                        });
                        Navigator.pop(context);
                      },
                      leading: Text(
                        countries[index].flag,
                        style: style!.copyWith(fontSize: 25.sp),
                      ),
                      title: Text(countries[index].name),
                      subtitle: Text(countries[index].dialCode),
                    ),
                  ),
                ),
              ),
              child: _CountryCodeWidget(country: _country),
            ),
          ),
        ),
        PositionedDirectional(
          bottom: 0,
          top: 12.h,
          end: 12.w,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.verifyPhone);
            },
            child: Text(
              widget.isPhoneVerified ? S.current.verified : S.current.verify,
              style: style!.copyWith(
                fontSize: 16.sp,
                color: widget.isPhoneVerified ? ColorManager.success : null,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CountryCodeWidget extends StatelessWidget {
  const _CountryCodeWidget({required Country country}) : _country = country;

  final Country _country;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodySmall;
    return Padding(
      padding: EdgeInsetsGeometry.directional(start: 6.w),
      child: Row(
        children: [
          Text(_country.flag, style: style!.copyWith(fontSize: 25.sp)),
          Expanded(
            child: Text(
              _country.dialCode,
              style: style.copyWith(fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          ),

          Text(
            '|',
            style: style.copyWith(fontSize: 25.sp, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
