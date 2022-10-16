import 'package:aquasave/home/models/Task.dart';
import 'package:aquasave/home/widgets/TaskDetailCircular.dart';
import 'package:flutter/material.dart';

import '../widgets/TaskDetailTipsSlider.dart';

class TaskDetail extends StatefulWidget {
  const TaskDetail({super.key, required this.task});

  final Task task;

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 20, 101, 167),
          title: Text(widget.task.title),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(widget.task.backgroundImage))),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: TaskDetailCircular(task: widget.task),
                ),
              ),
              Opacity(
                opacity: 0.85,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  child: Title(
                    color: Colors.black,
                    child: const Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Fuzzy Bubbles',
                          fontWeight: FontWeight.bold,
                        ),
                        "Cumple la tarea antes del tiempo recomendado y contribuye al medio ambiente."),
                  ),
                ),
              ),
              Expanded(
                child: CarouselChangeReasonDemo(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: bottomNavigation());
  }
}

class bottomNavigation extends StatelessWidget {
  const bottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
      BottomNavigationBarItem(icon: Icon(Icons.water_drop), label: 'Aquasave'),
      BottomNavigationBarItem(icon: Icon(Icons.exit_to_app), label: 'Exit')
    ]);
  }
}
