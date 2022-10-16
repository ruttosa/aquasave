import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:isolate';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import '../models/Task.dart';
import 'package:flutter/cupertino.dart';

class TaskDetailCircular extends StatefulWidget {
  /// Home page
  const TaskDetailCircular({super.key, required this.task});

  // Declare a field that holds the Todo.
  final Task task;

  @override
  _TaskDetailCircularState createState() => _TaskDetailCircularState();
}

///
/// Page state
///
class _TaskDetailCircularState extends State<TaskDetailCircular> {
  final CountDownController _controller = CountDownController();
  bool isStarted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // When the child is tapped, show a snackbar.
        onTap: () {
          if (!isStarted) {
            _controller.start();
            isStarted = true;
          } else {
            _controller.resume();
            isStarted = false;
            const snackBar = SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                    "¡Felicitaciones! Has finalizado la tarea exitosamente."));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            _controller.reset();
          }
        },
        // The custom button
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: CircularCountDownTimer(
                  // Countdown duration in Seconds.
                  duration: getCountDownDuration(
                    widget.task.recommendedTime,
                    widget.task.recommendedTimeType,
                  ),

                  // Countdown initial elapsed Duration in Seconds.
                  initialDuration: 0,

                  // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
                  controller: _controller,

                  // Width of the Countdown Widget.
                  width: MediaQuery.of(context).size.width / 2,

                  // Height of the Countdown Widget.
                  height: MediaQuery.of(context).size.height / 2,

                  // Ring Color for Countdown Widget.
                  ringColor: Color.fromARGB(255, 89, 165, 228),

                  // Ring Gradient for Countdown Widget.
                  ringGradient: null,

                  // Filling Color for Countdown Widget.
                  fillColor: Colors.blueGrey[100]!,

                  // Filling Gradient for Countdown Widget.
                  fillGradient: null,

                  // Background Color for Countdown Widget.
                  backgroundColor: const Color.fromARGB(255, 20, 101, 167),

                  // Background Gradient for Countdown Widget.
                  backgroundGradient: null,

                  // Border Thickness of the Countdown Ring.
                  strokeWidth: 20.0,

                  // Begin and end contours with a flat edge and no extension.
                  strokeCap: StrokeCap.round,

                  // Text Style for Countdown Text.
                  textStyle: const TextStyle(
                    fontSize: 33.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),

                  // Format for the Countdown Text.
                  textFormat: CountdownTextFormat.MM_SS,

                  // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
                  isReverse: true,

                  // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
                  isReverseAnimation: false,

                  // Handles visibility of the Countdown Text.
                  isTimerTextShown: true,

                  // Handles the timer start.
                  autoStart: false,

                  // This Callback will execute when the Countdown Starts.
                  onStart: () {
                    // Here, do whatever you want
                    debugPrint('Countdown Started');
                  },

                  // This Callback will execute when the Countdown Ends.
                  onComplete: () {
                    fireAlarm();
                    isStarted = false;
                    if (!_controller.isResumed) {
                      const snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          elevation: 10,
                          content: Text(
                              "¡Lo siento! Se ha agotado el tiempo para realizar la tarea."));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      _controller.reset();
                    } else {}
                  },

                  // This Callback will execute when the Countdown Changes.
                  onChange: (String timeStamp) {
                    // Here, do whatever you want
                    debugPrint('Countdown Changed $timeStamp');
                  }),
            ),
          ],
        ));
  }

  Widget _button({required String title, VoidCallback? onPressed}) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.purple),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void fireAlarm() async {
    FlutterRingtonePlayer.playAlarm();
    sleep(const Duration(seconds: 20));
    FlutterRingtonePlayer.stop();
  }

  static Route<void> _modalBuilder(BuildContext context, Object? arguments) {
    return CupertinoModalPopupRoute<void>(
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Fin'),
          message: const Text('Ha finalizado el tiempo recomendado'),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              child: const Text('OK'),
              onPressed: () {
                FlutterRingtonePlayer.stop();
              },
            ),
          ],
        );
      },
    );
  }
}

int getCountDownDuration(int recommendedTime, String type) {
  switch (type) {
    case "min":
      int seconds = recommendedTime * 60;
      return seconds;
    default:
      return recommendedTime;
  }
}
