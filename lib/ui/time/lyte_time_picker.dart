import 'package:flutter/material.dart';

class LyteTimePicker extends StatelessWidget {
  final DateTime? selectedDatetime;

  final Function(DateTime?)? onChanged;

  final ScrollController? hourScrollController;

  final ScrollController? minuteScrollController;

  const LyteTimePicker({
    super.key,
    this.selectedDatetime,
    this.onChanged,
    this.hourScrollController,
    this.minuteScrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 32),
        Expanded(
          child: ListWheelScrollView.useDelegate(
            controller: hourScrollController,
            itemExtent: 40,
            physics: const FixedExtentScrollPhysics(),
            overAndUnderCenterOpacity: 0.5,
            perspective: 0.01,
            onSelectedItemChanged: (int hour) {
              DateTime now = DateTime.now();

              onChanged?.call(
                DateTime(
                  selectedDatetime?.year ?? now.year,
                  selectedDatetime?.month ?? now.month,
                  selectedDatetime?.day ?? now.day,
                  hour,
                  selectedDatetime?.minute ?? 0,
                ),
              );
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                return Center(
                  child: Text(
                    '$index h',
                  ),
                );
              },
              childCount: 24,
            ),
          ),
        ),
        Expanded(
          child: ListWheelScrollView.useDelegate(
            controller: minuteScrollController,
            itemExtent: 40,
            physics: const FixedExtentScrollPhysics(),
            overAndUnderCenterOpacity: 0.5,
            perspective: 0.01,
            onSelectedItemChanged: (int minute) {
              DateTime now = DateTime.now();

              onChanged?.call(
                DateTime(
                  selectedDatetime?.year ?? now.year,
                  selectedDatetime?.month ?? now.month,
                  selectedDatetime?.day ?? now.day,
                  selectedDatetime?.hour ?? 0,
                  minute,
                ),
              );
            },
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                return Center(
                  child: Text(
                    '$index min',
                  ),
                );
              },
              childCount: 60,
            ),
          ),
        ),
        const SizedBox(width: 16), // Adjust as needed
      ],
    );
  }
}
