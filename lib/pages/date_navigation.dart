// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cal_list_cubit.dart';

class DateNavigation extends StatelessWidget {
  final DateTime date;
  final bool previousButtonEnabled;
  final bool nextButtonEnabled;
  const DateNavigation({
    super.key,
    required this.date,
    required this.previousButtonEnabled,
    required this.nextButtonEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: IconButton(
                disabledColor: Colors.grey[350],
                onPressed: previousButtonEnabled
                    ? () =>
                        {BlocProvider.of<CalListCubit>(context).goToPrevDate()}
                    : null,
                icon: Icon(
                  Icons.chevron_left,
                  color: previousButtonEnabled ? Colors.black : null,
                )),
          ),
          Text(
              '${_convertWeekDayToString(date.weekday)} (${_convertMonthIntToString(date.month)}-${date.day})'),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              disabledColor: Colors.grey[350],
              onPressed: nextButtonEnabled
                  ? () =>
                      {BlocProvider.of<CalListCubit>(context).goToNextDate()}
                  : null,
              icon: Icon(
                Icons.chevron_right,
                color: nextButtonEnabled ? Colors.black : null,
              ),
            ),
          )
        ],
      ),
    );
  }

  String _convertWeekDayToString(int weekday) {
    final String weekDay;
    switch (weekday) {
      case 1:
        weekDay = 'Mon';
        break;
      case 2:
        weekDay = 'Tue';
        break;
      case 3:
        weekDay = 'Wed';
        break;
      case 4:
        weekDay = 'Thu';
        break;
      case 5:
        weekDay = 'Fri';
        break;
      case 6:
        weekDay = 'Sat';
        break;
      case 7:
        weekDay = 'Sun';
        break;
      default:
        weekDay = 'NAN';
    }
    return weekDay;
  }

  String _convertMonthIntToString(int month) {
    final String monthStr;
    switch (month) {
      case 1:
        monthStr = 'Jan';
        break;
      case 2:
        monthStr = 'Feb';
        break;
      case 3:
        monthStr = 'Mar';
        break;
      case 4:
        monthStr = 'Apr';
        break;
      case 5:
        monthStr = 'May';
        break;
      case 6:
        monthStr = 'Jun';
        break;
      case 7:
        monthStr = 'Jul';
        break;
      case 8:
        monthStr = 'Aug';
        break;
      case 9:
        monthStr = 'Sep';
        break;
      case 10:
        monthStr = 'Oct';
        break;
      case 11:
        monthStr = 'Nov';
        break;
      case 12:
        monthStr = 'Dec';
        break;
      default:
        monthStr = 'NAN';
    }
    return monthStr;
  }
}
