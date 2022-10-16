import 'package:flutter/material.dart';
import '../../common/BottomMenuWidget.dart';
import '../../common/constant.dart';
import '../models/Task.dart';
import 'TaskDetail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _counter = 0;
  List<Task> aquasaveTasks = TASKS_LIST;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 101, 167),
        title: const Text("Inicio"),
      ),
      body: ListView.builder(
        itemCount: aquasaveTasks.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 2,
                      offset: Offset(2, 4))
                ],
                image: DecorationImage(
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  image: AssetImage(aquasaveTasks[index].backgroundImage),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.all(Radius.elliptical(10, 5))),
                child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        aquasaveTasks[index].title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Fuzzy Bubbles',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "${aquasaveTasks[index].recommendedTime} ${aquasaveTasks[index].recommendedTimeType}.",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Fuzzy Bubbles',
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TaskDetail(task: aquasaveTasks[index]),
                        ),
                      );
                    }),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: const MenuBottomWidget(),
    );
  }
}
