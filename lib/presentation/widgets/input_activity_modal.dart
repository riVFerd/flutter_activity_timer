import 'package:flutter/material.dart';
import 'package:flutter_activity_timer/presentation/theme/theme_constants.dart';

class InputActivityModal extends StatefulWidget {
  const InputActivityModal({
    super.key,
  });

  @override
  State<InputActivityModal> createState() => _InputActivityModalState();
}

class _InputActivityModalState extends State<InputActivityModal> {
  TimeOfDay? _selectedTime;
  String? _inputActivityName;

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
      // initialEntryMode: TimePickerEntryMode.inputOnly,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 24,
        right: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add New Activity',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              labelText: 'Activity Name',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            onChanged: (value) {
              _inputActivityName = value;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Goal Time : ${_selectedTime?.hour ?? 0} h ${_selectedTime?.minute ?? 0} m',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectTime(),
                  child: const Text(
                    'Set Time',
                    style: TextStyle(
                      color: ThemeConstants.dark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton.filled(
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeConstants.dark,
              foregroundColor: ThemeConstants.light,
            ),
            icon: const Icon(
              Icons.check_sharp,
              size: 36,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
