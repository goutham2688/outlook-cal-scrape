import 'package:flutter/material.dart';

class CalItem extends StatelessWidget {
  final String calTitle;
  final DateTime startTime;
  final DateTime endTime;
  final Duration duration;
  final DateTime nowTime;
  const CalItem({
    super.key,
    required this.calTitle,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.nowTime,
  });

  String _timeFormatter(DateTime time) {
    final hour = (time.hour > 12) ? time.hour - 12 : time.hour;
    final min = (time.minute != 0) ? time.minute.toString() : '00';
    final meridien = (time.hour > 12) ? 'PM' : 'AM';
    return '$hour:$min $meridien';
  }

  Future<void> dialogBuilder(
      BuildContext context, String title, bool meetingComplete) {
    final localStartTime = startTime.toLocal();
    final localEndTime = endTime.toLocal();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(
              "Title: $calTitle\n\nStartTime: ${_timeFormatter(localStartTime)}\n\nEndTime: ${_timeFormatter(localEndTime)}\n\nDuration: ${duration.inMinutes}mins"),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localStartTime = startTime.toLocal();
    final isMeetingComplete = endTime.isBefore(nowTime);
    final truncatedMeetingTitle = (calTitle.length > 81)
        ? calTitle.replaceRange(80, calTitle.length, '...')
        : calTitle;
    TextStyle? txtStyle;

    // set height for cards
    double heightForCard = 0.0;
    if (duration.inMinutes < 31) {
      // for less than 30 min meetings
      heightForCard = 90.0;
    } else {
      heightForCard = 120.0;
    }
    // grey out old meetings
    if (isMeetingComplete) {
      txtStyle = TextStyle(color: Colors.grey[300]);
    }

    // truncated meeting title

    return SizedBox(
      width: double.infinity,
      height: heightForCard,
      child: GestureDetector(
        onTap: () {
          dialogBuilder(context, truncatedMeetingTitle, isMeetingComplete);
        },
        child: Card.outlined(
            margin: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                const SizedBox(width: 5.0),
                Expanded(
                    flex: 25,
                    child: Text(
                      truncatedMeetingTitle,
                      style: txtStyle,
                    )),
                const VerticalDivider(indent: 7.0, endIndent: 7.0),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${duration.inMinutes}mins',
                        style: txtStyle,
                      ),
                      const Divider(
                        indent: 7.0,
                        endIndent: 7.0,
                        thickness: 2.0,
                        color: Colors.black,
                      ),
                      Text(
                        'at: ${_timeFormatter(localStartTime)}',
                        style: txtStyle,
                      )
                    ]),
                const SizedBox(width: 5.0),
              ],
            )),
      ),
    );
  }
}
