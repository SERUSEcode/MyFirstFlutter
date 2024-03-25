import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  List _items = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await json.decode(response);
    setState(() {
      print("hi");
      _items = data["items"];
      print(".. number of items ${_items.length}");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'dbestech',
        ),
      ),
      body:Column(children: [
        _items.isNotEmpty?Expanded(
        child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return Card(
              key: ValueKey(_items[index]["id"]),
              margin: const EdgeInsets.all(10),
              color: Colors.amber.shade100,
              child: ListTile(
                leading: Text(_items[index]["id"]),
                title: Text(_items[index]["name"]),
                subtitle: Text(_items[index]["description"]),
              ),
            );
          },
        ),
      ): ElevatedButton(
        onPressed: () {
          readJson();
        },
        child: Center(child: Text("Load Json")))
      ],),
    );
  }
}
