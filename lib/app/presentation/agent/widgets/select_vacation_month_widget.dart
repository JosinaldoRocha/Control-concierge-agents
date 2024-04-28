import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/core/style/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class SelectVacationMonthWidget extends StatefulWidget {
  const SelectVacationMonthWidget({
    super.key,
    required this.date,
    required this.onTap,
    required this.hintText,
  });
  final DateTime? date;
  final Function() onTap;
  final String hintText;

  @override
  State<SelectVacationMonthWidget> createState() =>
      _SelectVacationMonthWidgetState();
}

class _SelectVacationMonthWidgetState extends State<SelectVacationMonthWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.onTap,
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColor.lightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.date == null
                        ? widget.hintText
                        : DateFormat('dd/MM/yyyy').format(widget.date!),
                    style: AppText.text().bodyMedium!.copyWith(
                          color: widget.date == null
                              ? AppColor.mediumBlue
                              : Colors.black,
                          fontSize: 16,
                        ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/calendar.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColor.mediumBlue,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
