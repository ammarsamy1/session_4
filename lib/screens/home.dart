import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:session_4/screens/add_task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Taskaty"),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: SizedBox(
        width: 140,
        height: 60,
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTask()),
            ).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Task added successfully")),
              );
              setState(() {});
            });
          },
          child: Row(
            children: [
              SizedBox(width: 10),
              Text(
                "Add Task",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(width: 10),
              Icon(Icons.add, color: Colors.white, size: 30),
            ],
          ),
        ),
      ),
      body: (Hive.box("Taskaty").isEmpty)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/Empty box by partho.json",
                    width: 300,
                    height: 300,
                  ),
                  Text(
                    "No tasks found",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: Hive.box("Taskaty").length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(

                    title: Text(Hive.box("Taskaty").getAt(index)["task"]),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Hive.box("Taskaty").getAt(index)["description"]),
                        Text(Hive.box("Taskaty").getAt(index)["date"] ?? "No date"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddTask(index: index,),
                              ),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                        ),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            Hive.box("Taskaty").deleteAt(index);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
