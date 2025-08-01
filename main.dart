import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void main() => runApp(SmartShoeDashboard());

class SmartShoeDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Shoe Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final databaseReference = FirebaseDatabase.instance.ref("alerts");
  List<String> alerts = [];

  @override
  void initState() {
    super.initState();
    databaseReference.onValue.listen((event) {
      final data = event.snapshot.value as Map;
      setState(() {
        alerts = data.values.map((e) => e.toString()).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Smart Shoe Dashboard")),
      body: ListView.builder(
        itemCount: alerts.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.warning, color: Colors.red),
          title: Text(alerts[index]),
        ),
      ),
    );
  }
}