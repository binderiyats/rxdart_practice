import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

void testIt() async {
  final stream1 = Stream.periodic(
      const Duration(seconds: 1), (count) => 'Stream 1, count = $count');

  final stream2 = Stream.periodic(
      const Duration(seconds: 3), (count) => 'Stream 2, count = $count');
  final combined =
      Rx.combineLatest2(stream1, stream2, (a, b) => 'A is ($a), B is ($b)');

  await for (final value in combined) {
    value.log();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    testIt();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
    );
  }
}
