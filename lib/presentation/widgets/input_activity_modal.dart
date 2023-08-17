import 'package:flutter/material.dart';
import 'package:flutter_activity_timer/logic/bloc/activities_bloc.dart';
import 'package:flutter_activity_timer/presentation/theme/card_constants.dart';
import 'package:flutter_activity_timer/presentation/theme/theme_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/models/activity.dart';

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
  int _selectedColorId = 0;

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
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
          Container(
            height: 4,
            width: 64,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                CardConstants.backgroundColors.length,
                (index) {
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedColorId = index;
                    }),
                    child: Container(
                      margin: EdgeInsets.only(
                        left: index == 0 ? 0 : 8,
                      ),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: (_selectedColorId == index)
                            ? Border.all(
                                color: ThemeConstants.darkBlue,
                                width: 8,
                              )
                            : null,
                        color: CardConstants.backgroundColors[index],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          IconButton.filled(
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeConstants.dark,
              foregroundColor: ThemeConstants.light,
            ),
            icon: const Icon(
              Icons.check_sharp,
              size: 36,
            ),
            onPressed: () {
              if (_inputActivityName != null && _selectedTime != null) {
                final activity = Activity(
                  activityId: DateTime.now().millisecondsSinceEpoch,
                  activityName: _inputActivityName!,
                  goalTime:
                      _selectedTime!.hour * 3600 + _selectedTime!.minute * 60,
                  timeSpent: 0,
                  lastTrackedDate: DateTime.now(),
                  colorId: _selectedColorId,
                );
                BlocProvider.of<ActivitiesBloc>(context).add(
                  ActivitiesAdd(activity),
                );
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
    );
  }
}
