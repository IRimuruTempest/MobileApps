import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  String title;

  Event(this.title);
}

class Calendar_Page extends StatefulWidget {
  const Calendar_Page({super.key});

  @override
  State<Calendar_Page> createState() => _Calendar_PageState();
}

class _Calendar_PageState extends State<Calendar_Page> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Event>> events = {};
  TextEditingController _eventController = TextEditingController();
  late final ValueNotifier<List<Event>> _selectedEvents;

  @override
  initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _selectedEvents.addListener(() {
      setState(() {});
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(_selectedDay!);
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text("Event Name"),
                  content: Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      controller: _eventController,
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          events.addAll({
                            _selectedDay!: [Event(_eventController.text)]
                          });
                          Navigator.of(context).pop();
                          _selectedEvents.value =
                              _getEventsForDay(_selectedDay!);
                        },
                        child: Text("Ekle")),
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2022, 3, 10),
            lastDay: DateTime.utc(2030, 3, 10),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: _onDaySelected,
            eventLoader: _getEventsForDay,
            headerStyle: HeaderStyle(titleTextStyle: TextStyle(color: Colors.purple)), //November 2023 kısmı

            calendarStyle: CalendarStyle(
              todayTextStyle: TextStyle(color: Colors.blue), //bugünün Text Rengi
              weekendTextStyle: TextStyle(color: Colors.purple), // Hafta sonu rengi
              defaultTextStyle: TextStyle(color: Colors.red), //Bütün günlerin rengi
              outsideDaysVisible: false,
            ),
            rowHeight: 40,
            daysOfWeekVisible: false,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          textColor: Colors.black,
                          key: ValueKey(value[index]),
                          onTap: () => print(value[index].title),
                          title: Text('${value[index].title}'),
                        ),
                      );
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}