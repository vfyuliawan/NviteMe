import 'package:flutter/material.dart';

class DateTimeComponent extends StatefulWidget {
  final DateTime? dateValue;
  final Function(DateTime value) setValue;

  const DateTimeComponent({
    Key? key,
    this.dateValue,
    required this.setValue,
  }) : super(key: key);

  @override
  _DateTimeComponentState createState() => _DateTimeComponentState();
}

class _DateTimeComponentState extends State<DateTimeComponent> {
  late TextEditingController dateTimeController;

  @override
  void initState() {
    super.initState();

    dateTimeController = TextEditingController(
      text: widget.dateValue.toString(),
    );
  }

  Future<void> selectDateTime(BuildContext context) async {
    DateTime selectedDate = widget.dateValue ?? DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDate: selectedDate,
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );

      if (pickedTime != null) {
        selectedDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        if (selectedDate != widget.dateValue) {
          setState(() {
            widget.setValue(selectedDate);
            dateTimeController.text = selectedDate.toString();
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16 + 4, bottom: 8),
      child: TextField(
        controller: dateTimeController,
        onTap: () => selectDateTime(context),
        readOnly: true,
        autofocus: false,
        focusNode: FocusNode(),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black54),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelStyle: TextStyle(fontSize: 20),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.black54),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'Date and Time',
          hintText: "${widget.dateValue}",
          suffixIcon: const Icon(Icons.calendar_today),
        ),
      ),
    );
  }
}
