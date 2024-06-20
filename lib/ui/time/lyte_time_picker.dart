import 'package:flutter/material.dart';

class LyteTimePicker extends StatefulWidget {
  final DateTime? selectedDatetime;
  final double itemExtent;
  final Function(DateTime?)? onChanged;
  final FixedExtentScrollController? hourScrollController;
  final FixedExtentScrollController? minuteScrollController;

  const LyteTimePicker({
    super.key,
    this.selectedDatetime,
    this.onChanged,
    this.hourScrollController,
    this.minuteScrollController,
    this.itemExtent = 30
  });

  @override
  _LyteTimePickerState createState() => _LyteTimePickerState();
}

class _LyteTimePickerState extends State<LyteTimePicker> {
  late int selectedHour;
  late int selectedMinute;
  late FixedExtentScrollController hourScrollController;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedHour = widget.selectedDatetime?.hour ?? now.hour;
    selectedMinute = widget.selectedDatetime?.minute ?? now.minute;
    hourScrollController = FixedExtentScrollController(initialItem: 20 );
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
      widget.selectedDatetime?.year ?? now.year,
      widget.selectedDatetime?.month ?? now.month,
      widget.selectedDatetime?.day ?? now.day,
      selectedHour,
      selectedMinute,
    );
    widget.onChanged?.call(updatedDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 32),
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
                    '$index',
                  ),
                );
              },
              childCount: 24,
            ),
          ),
        ),
        Expanded(
          child: ListWheelScrollView.useDelegate(
            controller: widget.minuteScrollController,
            itemExtent: widget.itemExtent,
            physics: const FixedExtentScrollPhysics(),
            overAndUnderCenterOpacity: 0.5,
            perspective: 0.01,
            onSelectedItemChanged: _onMinuteChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                return Center(
                  child: Text(
                    '$index',
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
