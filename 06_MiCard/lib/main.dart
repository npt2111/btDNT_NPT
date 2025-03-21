import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DonutCounter(),
    );
  }
}

class DonutCounter extends StatefulWidget {
  @override
  _DonutCounterState createState() => _DonutCounterState();
}

class _DonutCounterState extends State<DonutCounter> {
  int nDonuts = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Demo'),
      ),
      body: Center(
        child: Text(
          'Number of donuts eaten: $nDonuts',
          style: TextStyle(
            fontSize: 40.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            nDonuts++;
          });
        },
      ),
    );
  }
}
