import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<Meeting> _meetings = [];

  @override
  void initState() {
    super.initState();
    // Populate the meetings list with some initial data
    _meetings = _getDataSource();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Events'),
        actions: [
          // Add button to create a new event
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddEditDialog(context);
            },
          ),
        ],
      ),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: MeetingDataSource(_meetings),
        onTap: calendarTapped,
        monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        ),
      ),
    );
  }

  // Function to initialize a set of sample meetings
  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
      Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false),
    );
    return meetings;
  }

  // Function to handle taps on calendar elements
  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment) {
      // User tapped on an existing event
      final Meeting meeting = details.appointments!.first;
      _showEventOptions(context, meeting);
    } else if (details.targetElement == CalendarElement.calendarCell) {
      // User tapped on a blank date cell or a cell that may already contain an event
      final DateTime selectedDate = details.date!;
      final List<Meeting> meetingsOnDate = _meetings
          .where((meeting) =>
              meeting.from.year == selectedDate.year &&
              meeting.from.month == selectedDate.month &&
              meeting.from.day == selectedDate.day)
          .toList();

      if (meetingsOnDate.isNotEmpty) {
        // There are meetings on the selected date, show options
        _showEventOptions(context, meetingsOnDate.first);
      } else {
        // No meetings on the selected date, open the dialog to add an event
        _showAddEditDialog(context, selectedDate: selectedDate);
      }
    }
  }

  // Function to show options (Edit or Delete) for a selected event
  void _showEventOptions(BuildContext context, Meeting meeting) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            // Edit event option
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                _showAddEditDialog(context, meeting: meeting); // Trigger the edit dialog
              },
            ),
            // Delete event option
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                setState(() {
                  _meetings.remove(meeting); // Remove the event
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // Function to show dialog for adding/editing an event
  void _showAddEditDialog(BuildContext context, {Meeting? meeting, DateTime? selectedDate}) {
    final bool isEditing = meeting != null;
    final TextEditingController eventNameController =
        TextEditingController(text: meeting?.eventName ?? '');
    DateTime? startTime = meeting?.from ?? selectedDate ?? DateTime.now();
    DateTime? endTime = meeting?.to ?? selectedDate?.add(const Duration(hours: 1)) ?? DateTime.now().add(const Duration(hours: 1));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Event' : 'Add Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Input field for event name
              TextField(
                controller: eventNameController,
                decoration: const InputDecoration(labelText: 'Event Name'),
              ),
              const SizedBox(height: 10),
              // Button to select the start time
              ElevatedButton(
                onPressed: () async {
                  final DateTime? pickedDate = await _selectDateTime(context, startTime);
                  if (pickedDate != null) {
                    setState(() {
                      startTime = pickedDate;
                      endTime = pickedDate.add(const Duration(hours: 1)); // Set default 1-hour duration
                    });
                  }
                },
                child: Text('Select Start Time: ${startTime!.toLocal()}'),
              ),
              // Button to select the end time
              ElevatedButton(
                onPressed: () async {
                  final DateTime? pickedDate = await _selectDateTime(context, endTime);
                  if (pickedDate != null) {
                    setState(() {
                      endTime = pickedDate;
                    });
                  }
                },
                child: Text('Select End Time: ${endTime!.toLocal()}'),
              ),
            ],
          ),
          actions: [
            // Cancel button to close dialog
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            // Save button to add or update event
            TextButton(
              onPressed: () {
                setState(() {
                  if (isEditing) {
                    // Update the existing meeting
                    meeting!.eventName = eventNameController.text;
                    meeting.from = startTime!;
                    meeting.to = endTime!;
                  } else {
                    // Add a new meeting to the list
                    _meetings.add(
                      Meeting(eventNameController.text, startTime!, endTime!, Colors.green, false),
                    );
                  }
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Function to show DatePicker and TimePicker for selecting a date and time
  Future<DateTime?> _selectDateTime(BuildContext context, DateTime? initialDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate ?? DateTime.now()),
      );
      if (pickedTime != null) {
        return DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
    return null;
  }
}

// Meeting data source to feed the calendar
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

// Meeting model to hold event data
class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
