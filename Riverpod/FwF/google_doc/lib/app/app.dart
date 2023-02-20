import 'package:flutter/material.dart';

class GoogleDocApp extends StatelessWidget {
  const GoogleDocApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Doc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home:  Scaffold(
        appBar: AppBar(
          title: const Text('Google Doc'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
