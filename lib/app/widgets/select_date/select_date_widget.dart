import 'package:control_concierge_agents/app/core/style/app_colors.dart';
import 'package:control_concierge_agents/app/core/style/app_text.dart';
import 'package:control_concierge_agents/app/data/enums/date_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class SelectDateWidget extends StatefulWidget {
  const SelectDateWidget({
    Key? key,
    required this.date,
    required this.onTap,
    required this.hintText,
    required this.onClean,
    required this.label,
    required this.datePickerType,
  }) : super(key: key);

  final DateTime? date;
  final Function() onTap;
  final String hintText;
  final Function() onClean;
  final String label;
  final DatePickerType datePickerType;

  @override
  State<SelectDateWidget> createState() => _SelectDateWidgetState();
}

class _SelectDateWidgetState extends State<SelectDateWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.date != null)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              widget.label,
              style: AppText.text()
                  .bodySmall!
                  .copyWith(color: AppColor.primary, fontSize: 12),
            ),
          ),
        InkWell(
          onTap: widget.onTap,
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColor.lightGrey,
              borderRadius: BorderRadius.circular(12),
              border: widget.date == null &&
                      widget.datePickerType == DatePickerType.reference
                  ? Border.all(color: AppColor.error)
                  : null,
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
                    style: AppText.text().titleMedium!.copyWith(
                          color: widget.date == null
                              ? AppColor.mediumBlue
                              : Colors.black,
                        ),
                  ),
                  widget.date != null
                      ? InkWell(
                          onTap: widget.onClean,
                          child: const Icon(Icons.close_rounded),
                        )
                      : SvgPicture.asset(
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
