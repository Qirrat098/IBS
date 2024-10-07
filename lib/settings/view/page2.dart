import 'dart:core';

import 'package:cr_calendar/cr_calendar.dart';

import 'package:flutter/material.dart';
import 'package:project_scitforte/settings/extensions.dart';

import '../../res/colors.dart';
import '../../widgets/day_events_bottom_sheet.dart';
import '../../widgets/day_item_widget.dart';
import '../../widgets/event_widget.dart';
import '../../widgets/week_days_widget.dart';
import '../constants.dart';
import '../utils/calendarform.dart';


/// Main calendar page.
class CalendarPage2 extends StatefulWidget {
  const CalendarPage2({super.key});

  @override
  _CalendarPage2State createState() => _CalendarPage2State();
}

class _CalendarPage2State extends State<CalendarPage2> {
  final _currentDate = DateTime.now();
  final _endDate = DateTime.now();
  final _appbarTitleNotifier = ValueNotifier<String>('');
  final _monthNameNotifier = ValueNotifier<String>('');

  late CrCalendarController _calendarController;

  @override
  void initState() {
    _setTexts(_currentDate.year, _currentDate.month);
    _setTexts(_endDate.year, _endDate.month);
    _createExampleEvents();

    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    _appbarTitleNotifier.dispose();
    _monthNameNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton:  FloatingActionButton(
        onPressed: () async {
          await _addEvent;
        },
        backgroundColor: Color(0xFFC01562),
        child: Icon(Icons.add, size: 30, color: Colors.white), // Adjust the icon size if needed
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        title: ValueListenableBuilder(
          valueListenable: _appbarTitleNotifier,
          builder: (ctx, value, child) => Text(value),
        ),
        actions: [
          // IconButton(
          //   tooltip: 'Go to current date',
          //   icon: const Icon(Icons.calendar_today),
          //   onPressed: _showCurrentMonth,
          // ),
        ],

      ),

      body: Column(
        children: [
          /// Calendar control row.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  _changeCalendarPage(showNext: false);
                },
              ),
              ValueListenableBuilder(
                valueListenable: _monthNameNotifier,
                builder: (ctx, value, child) => Text(
                  value,
                  style: const TextStyle(
                      fontSize: 16, color: violet, fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  _changeCalendarPage(showNext: true);
                },
              ),
            ],
          ),

          /// Calendar view.
          Expanded(
            child: CrCalendar(
              firstDayOfWeek: WeekDay.monday,
              eventsTopPadding: 32,
              initialDate: _currentDate,
              maxEventLines: 3,
              controller: _calendarController,
              forceSixWeek: true,
              dayItemBuilder: (builderArgument) =>
                  DayItemWidget(properties: builderArgument),
              weekDaysBuilder: (day) => WeekDaysWidget(day: day),
              eventBuilder: (drawer) => EventWidget(drawer: drawer),
              onDayClicked: _showDayEventsInModalSheet,
              minDate: DateTime.now().subtract(const Duration(days: 1000)),
              maxDate: DateTime.now().add(const Duration(days: 180)),
              // weeksToShow: [0,1,2].toList(),
              //localizedWeekDaysBuilder: (weekDay) => LocalizedWeekDaysWidget(weekDay: weekDay),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: IconButton(
              tooltip: 'Go to current date',
              icon: const Icon(Icons.calendar_today),
              onPressed: _showCurrentMonth,
            ),
          ),
        ],
      ),

    );
  }

  /// Control calendar with arrow buttons.
  void _changeCalendarPage({required bool showNext}) => showNext
      ? _calendarController.swipeToNextMonth()
      : _calendarController.swipeToPreviousPage();

  void _onCalendarPageChanged(int year, int month) {
    _setTexts(year, month);
  }

  /// Set app bar text and month name over calendar.
  void _setTexts(int year, int month) {
    final date = DateTime(year, month);
    _appbarTitleNotifier.value = date.format(kAppBarDateFormat);
    _monthNameNotifier.value = date.format(kMonthFormat);
  }

  /// Show current month page.
  void _showCurrentMonth() {
    _calendarController.goToDate(_currentDate);
  }

  /// Show [CreateEventDialog] with settings for new event.
  Future<void> _addEvent() async {
    final event = await showDialog(
        context: context, builder: (context) => const CreateEventDialog2());
    if (event != null) {
      _calendarController.addEvent(event);
    }
  }

  void _createExampleEvents() {
    final now = _currentDate;
    _calendarController = CrCalendarController(
      onSwipe: _onCalendarPageChanged,
      events: [
        CalendarEventModel(
          name: '1 event',
          begin: DateTime(now.year, now.month, (now.day-2).clamp(1, 28)),
          end: DateTime(now.year, now.month, (now.day+2).clamp(1, 28)),
          eventColor: eventColors[0],
        ),
        // CalendarEventModel(
        //   name: '2 event',
        //   begin: DateTime(now.year, now.month - 1, (now.day - 2).clamp(1, 28)),
        //   end: DateTime(now.year, now.month, (now.day + 2).clamp(1, 28)),
        //   eventColor: eventColors[1],
        // ),
        // CalendarEventModel(
        //   name: '3 event',
        //   begin: DateTime(now.year, now.month, (now.day - 3).clamp(1, 28)),
        //   end: DateTime(now.year, now.month + 1, (now.day + 4).clamp(1, 28)),
        //   eventColor: eventColors[2],
        // ),
        // CalendarEventModel(
        //   name: '4 event',
        //   begin: DateTime(now.year, now.month - 1, (now.day).clamp(1, 28)),
        //   end: DateTime(now.year, now.month + 1, (now.day + 5).clamp(1, 28)),
        //   eventColor: eventColors[3],
        // ),
        // CalendarEventModel(
        //   name: '5 event',
        //   begin: DateTime(now.year, now.month + 1, (now.day + 1).clamp(1, 28)),
        //   end: DateTime(now.year, now.month + 2, (now.day + 7).clamp(1, 28)),
        //   eventColor: eventColors[4],
        // ),
      ],
    );
  }

  void _showDayEventsInModalSheet(
      List<CalendarEventModel> events, DateTime day) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
        isScrollControlled: true,
        context: context,
        builder: (context) => DayEventsBottomSheet(
          events: events,
          day: day,
          screenHeight: MediaQuery.of(context).size.height,
        ));
  }
}
