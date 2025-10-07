// import 'package:dream_carz/core/colors.dart';
// import 'package:dream_carz/core/responsiveutils.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class DateTimeSelectionWidget extends StatefulWidget {
//   final Function(DateTime, TimeOfDay) onDateTimeChanged;
//   final DateTime? initialDate;   // NEW optional param
//   final TimeOfDay? initialTime;  // NEW optional param
//   const DateTimeSelectionWidget({super.key, required this.onDateTimeChanged, this.initialDate, this.initialTime});

//   @override
//   DateTimeSelectionWidgetState createState() => DateTimeSelectionWidgetState();
// }

// class DateTimeSelectionWidgetState extends State<DateTimeSelectionWidget> {
//   DateTime selectedDate = DateTime.now();
//   TimeOfDay selectedTime = TimeOfDay.now();
//   List<String> timeSlots = [];
//   final GlobalKey _popupMenuKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//     _generateTimeSlots();
//   }

//   void _generateTimeSlots() {
//     timeSlots.clear();

//     // Check if selected date is today
//     bool isToday =
//         selectedDate.year == DateTime.now().year &&
//         selectedDate.month == DateTime.now().month &&
//         selectedDate.day == DateTime.now().day;

//     // Set end time to 8:00 PM for all dates
//     DateTime endTime = DateTime(
//       selectedDate.year,
//       selectedDate.month,
//       selectedDate.day,
//       24, // 12 AM
//       0,
//     );

//     if (isToday) {
//       // For today, generate slots based on current time
//       DateTime now = DateTime.now();
//       DateTime startTime;

//       if (now.minute >= 30) {
//         startTime = DateTime(now.year, now.month, now.day, now.hour + 1);
//       } else {
//         startTime = DateTime(now.year, now.month, now.day, now.hour, 30);
//       }

//       if (startTime.isBefore(now)) {
//         startTime = startTime.add(const Duration(minutes: 30));
//       }

//       // Check if it's already past end time
//       if (startTime.isBefore(endTime)) {
//         DateTime currentSlot = startTime;
//         while (!currentSlot.isAfter(endTime)) {
//           timeSlots.add(_formatDateTime(currentSlot));
//           currentSlot = currentSlot.add(const Duration(minutes: 30));
//         }
//       }
//     } else {
//       // For future dates, generate slots from 7:30 AM to 8:00 PM
//       DateTime startTime = DateTime(
//         selectedDate.year,
//         selectedDate.month,
//         selectedDate.day,
//         0, // 7 AM
//         30, // 30 minutes
//       );

//       DateTime currentSlot = startTime;
//       while (!currentSlot.isAfter(endTime)) {
//         timeSlots.add(_formatDateTime(currentSlot));
//         currentSlot = currentSlot.add(const Duration(minutes: 30));
//       }
//     }

//     // Update selected time if it's not in available slots
//     if (timeSlots.isNotEmpty &&
//         !timeSlots.contains(_formatTimeOfDay(selectedTime))) {
//       selectedTime = TimeOfDay.fromDateTime(
//         DateFormat('h:mm a').parse(timeSlots.first),
//       );
//     }
//   }

//   String _formatDateTime(DateTime dateTime) {
//     return DateFormat('h:mm a').format(dateTime);
//   }

//   String _formatTimeOfDay(TimeOfDay time) {
//     final now = DateTime.now();
//     final dateTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//     );
//     return DateFormat('h:mm a').format(dateTime);
//   }

//   TimeOfDay _parseTimeString(String timeString) {
//     final format = DateFormat('h:mm a');
//     final dateTime = format.parse(timeString);
//     return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             primaryColor: Appcolors.kprimarycolor,
//             hintColor: Appcolors.kprimarycolor,
//             colorScheme: const ColorScheme.light(
//               primary: Appcolors.kprimarycolor,
//               onPrimary: Colors.white,
//               onSurface: Colors.black,
//             ),
//             buttonTheme: const ButtonThemeData(
//               textTheme: ButtonTextTheme.primary,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//         _generateTimeSlots();
//       });
//       widget.onDateTimeChanged(selectedDate, selectedTime);

//       // Add a small delay before showing the time popup
//       Future.delayed(const Duration(milliseconds: 100), () {
//         dynamic state = _popupMenuKey.currentState;
//         state?.showButtonMenu();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           padding: const EdgeInsets.only(left: 8),
//           width: ResponsiveUtils.wp(40),
//           decoration: BoxDecoration(
//             color: Appcolors.kwhitecolor,
//             border: Border.all(color: Colors.black, width: .5),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
//                 InkWell(
//                   onTap: () => _selectDate(context),
//                   child: Icon(Icons.calendar_month_outlined),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.only(left: ResponsiveUtils.wp(2)),
//           width: ResponsiveUtils.wp(25),
//           decoration: BoxDecoration(
//             color: Appcolors.kwhitecolor,
//             border: Border.all(color: Appcolors.kblackcolor, width: .5),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: PopupMenuButton<String>(
//             color: Appcolors.kwhitecolor,
//             key: _popupMenuKey,
//             initialValue: _formatTimeOfDay(selectedTime),
//             onSelected: (String timeString) {
//               setState(() {
//                 selectedTime = _parseTimeString(timeString);
//               });
//               widget.onDateTimeChanged(selectedDate, selectedTime);
//             },
//             itemBuilder: (BuildContext context) {
//               return timeSlots.map((String time) {
//                 return PopupMenuItem<String>(
//                   value: time,
//                   height: ResponsiveUtils.hp(4),
//                   child: Text(time),
//                 );
//               }).toList();
//             },
//             constraints: BoxConstraints(maxHeight: ResponsiveUtils.hp(40)),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(_formatTimeOfDay(selectedTime)),
//                   const Icon(Icons.arrow_drop_down),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
///////////////////////////////////////
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class DateTimeSelectionWidget extends StatefulWidget {
//   final Function(DateTime, TimeOfDay) onDateTimeChanged;

//   /// Optional initial values (if not passed → defaults to now)
//   final DateTime? initialDate;
//   final TimeOfDay? initialTime;

//   const DateTimeSelectionWidget({
//     super.key,
//     required this.onDateTimeChanged,
//     this.initialDate,
//     this.initialTime,
//   });

//   @override
//   DateTimeSelectionWidgetState createState() => DateTimeSelectionWidgetState();
// }

// class DateTimeSelectionWidgetState extends State<DateTimeSelectionWidget> {
//   late DateTime selectedDate;
//   late TimeOfDay selectedTime;

//   List<String> timeSlots = [];
//   final GlobalKey _popupMenuKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//     // Use passed initial values OR fallback to now
//     selectedDate = widget.initialDate ?? DateTime.now();
//     selectedTime = widget.initialTime ?? TimeOfDay.now();
//     _generateTimeSlots();
//   }

//   void _generateTimeSlots() {
//     timeSlots.clear();

//     bool isToday = selectedDate.year == DateTime.now().year &&
//         selectedDate.month == DateTime.now().month &&
//         selectedDate.day == DateTime.now().day;

//     DateTime endTime = DateTime(
//       selectedDate.year,
//       selectedDate.month,
//       selectedDate.day,
//       24, // 12 AM
//       0,
//     );

//     if (isToday) {
//       DateTime now = DateTime.now();
//       DateTime startTime;

//       if (now.minute >= 30) {
//         startTime = DateTime(now.year, now.month, now.day, now.hour + 1);
//       } else {
//         startTime = DateTime(now.year, now.month, now.day, now.hour, 30);
//       }

//       if (startTime.isBefore(now)) {
//         startTime = startTime.add(const Duration(minutes: 30));
//       }

//       if (startTime.isBefore(endTime)) {
//         DateTime currentSlot = startTime;
//         while (!currentSlot.isAfter(endTime)) {
//           timeSlots.add(_formatDateTime(currentSlot));
//           currentSlot = currentSlot.add(const Duration(minutes: 30));
//         }
//       }
//     } else {
//       DateTime startTime = DateTime(
//         selectedDate.year,
//         selectedDate.month,
//         selectedDate.day,
//         0,
//         30,
//       );

//       DateTime currentSlot = startTime;
//       while (!currentSlot.isAfter(endTime)) {
//         timeSlots.add(_formatDateTime(currentSlot));
//         currentSlot = currentSlot.add(const Duration(minutes: 30));
//       }
//     }

//     if (timeSlots.isNotEmpty &&
//         !timeSlots.contains(_formatTimeOfDay(selectedTime))) {
//       selectedTime = TimeOfDay.fromDateTime(
//         DateFormat('h:mm a').parse(timeSlots.first),
//       );
//     }
//   }

//   String _formatDateTime(DateTime dateTime) {
//     return DateFormat('h:mm a').format(dateTime);
//   }

//   String _formatTimeOfDay(TimeOfDay time) {
//     final now = DateTime.now();
//     final dateTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//     );
//     return DateFormat('h:mm a').format(dateTime);
//   }

//   TimeOfDay _parseTimeString(String timeString) {
//     final format = DateFormat('h:mm a');
//     final dateTime = format.parse(timeString);
//     return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: ThemeData.light().copyWith(
//             primaryColor: Appcolors.kprimarycolor,
//             hintColor: Appcolors.kprimarycolor,
//             colorScheme: const ColorScheme.light(
//               primary: Appcolors.kprimarycolor,
//               onPrimary: Colors.white,
//               onSurface: Colors.black,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//         _generateTimeSlots();
//       });
//       widget.onDateTimeChanged(selectedDate, selectedTime);

//       Future.delayed(const Duration(milliseconds: 100), () {
//         dynamic state = _popupMenuKey.currentState;
//         state?.showButtonMenu();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           padding: const EdgeInsets.only(left: 8),
//           width: ResponsiveUtils.wp(40),
//           decoration: BoxDecoration(
//             color: Appcolors.kwhitecolor,
//             border: Border.all(color: Colors.black, width: .5),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
//                 InkWell(
//                   onTap: () => _selectDate(context),
//                   child: const Icon(Icons.calendar_month_outlined),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.only(left: ResponsiveUtils.wp(2)),
//           width: ResponsiveUtils.wp(25),
//           decoration: BoxDecoration(
//             color: Appcolors.kwhitecolor,
//             border: Border.all(color: Appcolors.kblackcolor, width: .5),
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: PopupMenuButton<String>(
//             color: Appcolors.kwhitecolor,
//             key: _popupMenuKey,
//             initialValue: _formatTimeOfDay(selectedTime),
//             onSelected: (String timeString) {
//               setState(() {
//                 selectedTime = _parseTimeString(timeString);
//               });
//               widget.onDateTimeChanged(selectedDate, selectedTime);
//             },
//             itemBuilder: (BuildContext context) {
//               return timeSlots.map((String time) {
//                 return PopupMenuItem<String>(
//                   value: time,
//                   height: ResponsiveUtils.hp(4),
//                   child: Text(time),
//                 );
//               }).toList();
//             },
//             constraints: BoxConstraints(maxHeight: ResponsiveUtils.hp(40)),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(_formatTimeOfDay(selectedTime)),
//                   const Icon(Icons.arrow_drop_down),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
// Base widget for "From" date/time selection
class FromDateTimeSelectionWidget extends StatefulWidget {
  final Function(DateTime, TimeOfDay) onDateTimeChanged;
  final DateTime? initialDate;
  final TimeOfDay? initialTime;

  const FromDateTimeSelectionWidget({
    super.key,
    required this.onDateTimeChanged,
    this.initialDate,
    this.initialTime,
  });

  @override
  FromDateTimeSelectionWidgetState createState() => FromDateTimeSelectionWidgetState();
}

class FromDateTimeSelectionWidgetState extends State<FromDateTimeSelectionWidget> {
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  List<String> timeSlots = [];
  final GlobalKey _popupMenuKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate ?? DateTime.now();
    selectedTime = widget.initialTime ?? TimeOfDay.now();
    _generateTimeSlots();
  }

  void _generateTimeSlots() {
    timeSlots.clear();

    bool isToday = selectedDate.year == DateTime.now().year &&
        selectedDate.month == DateTime.now().month &&
        selectedDate.day == DateTime.now().day;

    DateTime effectiveStartTime;
    
    if (isToday) {
      DateTime now = DateTime.now();
      if (now.minute >= 30) {
        effectiveStartTime = DateTime(now.year, now.month, now.day, now.hour + 1, 0);
      } else {
        effectiveStartTime = DateTime(now.year, now.month, now.day, now.hour, 30);
      }
    } else {
      effectiveStartTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        0,
        30,
      );
    }

    DateTime endTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      24,
      0,
    );

    if (effectiveStartTime.isBefore(endTime)) {
      DateTime currentSlot = effectiveStartTime;
      while (!currentSlot.isAfter(endTime)) {
        timeSlots.add(_formatDateTime(currentSlot));
        currentSlot = currentSlot.add(const Duration(minutes: 30));
      }
    }

    if (timeSlots.isNotEmpty &&
        !timeSlots.contains(_formatTimeOfDay(selectedTime))) {
      selectedTime = TimeOfDay.fromDateTime(
        DateFormat('h:mm a').parse(timeSlots.first),
      );
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('h:mm a').format(dateTime);
  }

  TimeOfDay _parseTimeString(String timeString) {
    final format = DateFormat('h:mm a');
    final dateTime = format.parse(timeString);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Appcolors.kprimarycolor,
            hintColor: Appcolors.kprimarycolor,
            colorScheme: const ColorScheme.light(
              primary: Appcolors.kprimarycolor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _generateTimeSlots();
      });
      widget.onDateTimeChanged(selectedDate, selectedTime);

      Future.delayed(const Duration(milliseconds: 100), () {
        dynamic state = _popupMenuKey.currentState;
        state?.showButtonMenu();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8),
          width: ResponsiveUtils.wp(40),
          decoration: BoxDecoration(
            color: Appcolors.kwhitecolor,
            border: Border.all(color: Colors.black, width: .5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: const Icon(Icons.calendar_month_outlined),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: ResponsiveUtils.wp(2)),
          width: ResponsiveUtils.wp(25),
          decoration: BoxDecoration(
            color: Appcolors.kwhitecolor,
            border: Border.all(color: Appcolors.kblackcolor, width: .5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: PopupMenuButton<String>(
            color: Appcolors.kwhitecolor,
            key: _popupMenuKey,
            initialValue: _formatTimeOfDay(selectedTime),
            onSelected: (String timeString) {
              setState(() {
                selectedTime = _parseTimeString(timeString);
              });
              widget.onDateTimeChanged(selectedDate, selectedTime);
            },
            itemBuilder: (BuildContext context) {
              return timeSlots.map((String time) {
                return PopupMenuItem<String>(
                  value: time,
                  height: ResponsiveUtils.hp(4),
                  child: Text(time),
                );
              }).toList();
            },
            constraints: BoxConstraints(maxHeight: ResponsiveUtils.hp(40)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatTimeOfDay(selectedTime)),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Separate widget for "To" date/time selection with 12-hour minimum gap
class ToDateTimeSelectionWidget extends StatefulWidget {
  final Function(DateTime, TimeOfDay) onDateTimeChanged;
  final DateTime? initialDate;
  final TimeOfDay? initialTime;
  final DateTime minDateTime; // Required minimum date/time

  const ToDateTimeSelectionWidget({
    super.key,
    required this.onDateTimeChanged,
    required this.minDateTime,
    this.initialDate,
    this.initialTime,
  });

  @override
  ToDateTimeSelectionWidgetState createState() => ToDateTimeSelectionWidgetState();
}

class ToDateTimeSelectionWidgetState extends State<ToDateTimeSelectionWidget> {
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  List<String> timeSlots = [];
  final GlobalKey _popupMenuKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Ensure initial date is not before minDateTime
    DateTime initialDate = widget.initialDate ?? widget.minDateTime;
    if (initialDate.isBefore(widget.minDateTime)) {
      initialDate = widget.minDateTime;
    }
    selectedDate = DateTime(initialDate.year, initialDate.month, initialDate.day);
    
    // Set initial time
    selectedTime = widget.initialTime ?? TimeOfDay.fromDateTime(widget.minDateTime);
    _generateTimeSlots();
  }

  @override
  void didUpdateWidget(ToDateTimeSelectionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If minDateTime changed, regenerate time slots
    if (oldWidget.minDateTime != widget.minDateTime) {
      // Check if current selection is still valid
      DateTime currentSelection = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      
      if (currentSelection.isBefore(widget.minDateTime)) {
        // Reset to minimum allowed
        selectedDate = DateTime(
          widget.minDateTime.year,
          widget.minDateTime.month,
          widget.minDateTime.day,
        );
        selectedTime = TimeOfDay.fromDateTime(widget.minDateTime);
      }
      _generateTimeSlots();
    }
  }

  void _generateTimeSlots() {
    timeSlots.clear();

    bool isMinDate = selectedDate.year == widget.minDateTime.year &&
        selectedDate.month == widget.minDateTime.month &&
        selectedDate.day == widget.minDateTime.day;

    DateTime effectiveStartTime;
    
    if (isMinDate) {
      // On the same day as minDateTime, start from minDateTime
      effectiveStartTime = widget.minDateTime;
    } else {
      // On a different day, start from midnight + 30 min
      effectiveStartTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        0,
        30,
      );
    }

    DateTime endTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      24,
      0,
    );

    if (effectiveStartTime.isBefore(endTime)) {
      DateTime currentSlot = effectiveStartTime;
      while (!currentSlot.isAfter(endTime)) {
        timeSlots.add(_formatDateTime(currentSlot));
        currentSlot = currentSlot.add(const Duration(minutes: 30));
      }
    }

    if (timeSlots.isNotEmpty &&
        !timeSlots.contains(_formatTimeOfDay(selectedTime))) {
      selectedTime = TimeOfDay.fromDateTime(
        DateFormat('h:mm a').parse(timeSlots.first),
      );
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('h:mm a').format(dateTime);
  }

  TimeOfDay _parseTimeString(String timeString) {
    final format = DateFormat('h:mm a');
    final dateTime = format.parse(timeString);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  Future<void> _selectDate(BuildContext context) async {
    // First date should be the date part of minDateTime
    DateTime firstDate = DateTime(
      widget.minDateTime.year,
      widget.minDateTime.month,
      widget.minDateTime.day,
    );

    // Ensure initialDate is valid (not before firstDate)
    DateTime validInitialDate = selectedDate;
    if (validInitialDate.isBefore(firstDate)) {
      validInitialDate = firstDate;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: validInitialDate,
      firstDate: firstDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Appcolors.kprimarycolor,
            hintColor: Appcolors.kprimarycolor,
            colorScheme: const ColorScheme.light(
              primary: Appcolors.kprimarycolor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _generateTimeSlots();
      });
      widget.onDateTimeChanged(selectedDate, selectedTime);

      Future.delayed(const Duration(milliseconds: 100), () {
        dynamic state = _popupMenuKey.currentState;
        state?.showButtonMenu();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8),
          width: ResponsiveUtils.wp(40),
          decoration: BoxDecoration(
            color: Appcolors.kwhitecolor,
            border: Border.all(color: Colors.black, width: .5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: const Icon(Icons.calendar_month_outlined),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: ResponsiveUtils.wp(2)),
          width: ResponsiveUtils.wp(25),
          decoration: BoxDecoration(
            color: Appcolors.kwhitecolor,
            border: Border.all(color: Appcolors.kblackcolor, width: .5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: PopupMenuButton<String>(
            color: Appcolors.kwhitecolor,
            key: _popupMenuKey,
            initialValue: _formatTimeOfDay(selectedTime),
            onSelected: (String timeString) {
              setState(() {
                selectedTime = _parseTimeString(timeString);
              });
              widget.onDateTimeChanged(selectedDate, selectedTime);
            },
            itemBuilder: (BuildContext context) {
              return timeSlots.map((String time) {
                return PopupMenuItem<String>(
                  value: time,
                  height: ResponsiveUtils.hp(4),
                  child: Text(time),
                );
              }).toList();
            },
            constraints: BoxConstraints(maxHeight: ResponsiveUtils.hp(40)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatTimeOfDay(selectedTime)),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}