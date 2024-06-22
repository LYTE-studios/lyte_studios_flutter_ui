import 'package:flutter/material.dart';
import 'package:lyte_studios_flutter_ui/shared/utils/lyte_date_time_util.dart';

class LyteTimePicker extends StatefulWidget {
  final DateTime? initialDateTime;
  final double itemExtent;
  final Function(DateTime?)? onChanged;
  final Color? selectorColor;
  final TextStyle? textStyle;

  const LyteTimePicker({
    super.key,
    this.initialDateTime,
    this.onChanged,
    this.itemExtent = 30,
    this.selectorColor,
    this.textStyle,
  });

  @override
  LyteTimePickerState createState() => LyteTimePickerState();
}

class LyteTimePickerState extends State<LyteTimePicker> {
  late int selectedHour;
  late int selectedMinute;
  late FixedExtentScrollController hourScrollController;
  late FixedExtentScrollController minuteScrollController;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedHour = widget.initialDateTime?.hour ?? now.hour;
    selectedMinute = widget.initialDateTime?.minute ?? now.minute;
    hourScrollController =
        FixedExtentScrollController(initialItem: selectedHour);
    minuteScrollController =
        FixedExtentScrollController(initialItem: selectedMinute);
  }

  void _onHourChanged(int hour) {
    setState(() {
      selectedHour = hour;
      _updateSelectedDateTime();
    });
  }

  void _onMinuteChanged(int minute) {
    setState(() {
      selectedMinute = minute;
      _updateSelectedDateTime();
    });
  }

  void _updateSelectedDateTime() {
    final now = DateTime.now();
    final updatedDateTime = DateTime(
      widget.initialDateTime?.year ?? now.year,
      widget.initialDateTime?.month ?? now.month,
      widget.initialDateTime?.day ?? now.day,
      selectedHour,
      selectedMinute,
    );
    widget.onChanged?.call(updatedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Center(
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: widget.selectorColor ?? Colors.grey.withOpacity(0.1),
              ),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            const SizedBox(
              width: 27,
            ),
            Expanded(
              child: ListWheelScrollView.useDelegate(
                controller: hourScrollController,
                itemExtent: widget.itemExtent,
                physics: const FixedExtentScrollPhysics(),
                overAndUnderCenterOpacity: 0.5,
                perspective: 0.01,
                onSelectedItemChanged: _onHourChanged,
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    return Center(
                      child: Text(
                        LyteDateTimeUtil.formatTimeNumber(index),
                        style: widget.textStyle,
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
                itemExtent: widget.itemExtent,
                physics: const FixedExtentScrollPhysics(),
                overAndUnderCenterOpacity: 0.5,
                perspective: 0.01,
                onSelectedItemChanged: _onMinuteChanged,
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    return Center(
                      child: Text(
                        LyteDateTimeUtil.formatTimeNumber(index),
                        style: widget.textStyle,
                      ),
                    );
                  },
                  childCount: 60,
                ),
              ),
            ),
            const SizedBox(
              width: 27,
            ), // Adjust as needed
          ],
        ),
      ],
    );
  }
}
