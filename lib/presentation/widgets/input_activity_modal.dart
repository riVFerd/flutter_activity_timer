import 'package:flutter/material.dart';
import 'package:flutter_activity_timer/logic/bloc/activities_bloc.dart';
import 'package:flutter_activity_timer/presentation/theme/card_constants.dart';
import 'package:flutter_activity_timer/presentation/theme/theme_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/models/activity.dart';

class InputActivityModal extends StatefulWidget {
  final Activity? activity;

  const InputActivityModal({
    super.key,
    this.activity,
  });

  @override
  State<InputActivityModal> createState() => _InputActivityModalState();
}

class _InputActivityModalState extends State<InputActivityModal> {
  TimeOfDay? _selectedTime;
  String? _inputActivityName;
  int _selectedColorId = 0;
  bool _isEditing = false;

  /// Either insert or update activity based on [widget.activity]
  void _submitActivity() {
    if (_inputActivityName != null && _selectedTime != null) {
      if (_isEditing) {
        final activity = widget.activity!.copyWith(
          activityName: _inputActivityName,
          goalTime: Activity.toSecond(_selectedTime!),
          colorId: _selectedColorId,
        );
        BlocProvider.of<ActivitiesBloc>(context).add(
          ActivitiesUpdate(activity),
        );
      } else {
        final activity = Activity(
          activityId: DateTime.now().millisecondsSinceEpoch,
          activityName: _inputActivityName!,
          goalTime: Activity.toSecond(_selectedTime!),
          timeSpent: 0,
          lastTrackedDate: DateTime.now(),
          colorId: _selectedColorId,
        );
        BlocProvider.of<ActivitiesBloc>(context).add(
          ActivitiesAdd(activity),
        );
      }
      Navigator.of(context).pop();
    }
  }

  void _deleteActivity() {
    if (_isEditing) {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ThemeConstants.darkBlue,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Are you sure you want to delete this activity?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Theme(
                  data: ThemeData(
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        backgroundColor: ThemeConstants.dark,
                        foregroundColor: ThemeConstants.light,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.red,
                          ),
                        ),
                        onPressed: () {
                          BlocProvider.of<ActivitiesBloc>(context).add(
                            ActivitiesDelete(widget.activity!),
                          );
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Yes'),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('No'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

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
  void initState() {
    super.initState();
    if (widget.activity != null) {
      _selectedTime = TimeOfDay(
        hour: widget.activity!.goalTime ~/ 3600,
        minute: (widget.activity!.goalTime % 3600) ~/ 60,
      );
      _inputActivityName = widget.activity!.activityName;
      _selectedColorId = widget.activity!.colorId;
      _isEditing = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
      ),
      child: SingleChildScrollView(
        child: Padding(
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
              Text(
                (_isEditing) ? 'Edit Activity' : 'Add Activity',
                style: const TextStyle(
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
                controller: TextEditingController(text: _inputActivityName),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: _isEditing,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 32),
                      child: _CustomIconButton(
                        backgroundColor: Colors.red,
                        foregroundColor: ThemeConstants.light,
                        icon: const Icon(Icons.delete_forever),
                        onPressed: _deleteActivity,
                      ),
                    ),
                  ),
                  _CustomIconButton(
                    icon: Icon(
                      (_isEditing) ? Icons.edit_rounded : Icons.check_sharp,
                    ),
                    onPressed: _submitActivity,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  const _CustomIconButton({
    required this.onPressed,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
  });

  final Icon icon;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? ThemeConstants.dark,
        foregroundColor: foregroundColor ?? ThemeConstants.light,
      ),
      icon: icon,
      padding: const EdgeInsets.all(16),
      iconSize: 32,
      onPressed: onPressed,
    );
  }
}
