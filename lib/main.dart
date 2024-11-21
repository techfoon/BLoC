import 'dart:developer';

import 'package:bloc_sm/BLoC/counter_block.dart';
import 'package:bloc_sm/BLoC/counter_event.dart';
import 'package:bloc_sm/BLoC/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
          create: (context) => CounterBLoc(),
          child: MyApp(),
        ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  MyHomePage(),
        );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // log("build is callred");
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterBLoc, CounterState>(builder: (context, state) {
              log("bloc is callred");

              ///  it rebuild only Text
              return Text(
                '${context.watch<CounterBLoc>().state.count} or  ${state.count}', // no need to add full code we can do here only with state
              );
            }),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text("Second page"),
                      ),
                      body: Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                context
                                    .read<CounterBLoc>()
                                    .add(DecrementCounterEvent());
                              },
                              icon: Icon(Icons.cut))
                        ],
                      ),
                    );
                  }));
                },
                child: Text("clieck here"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterBLoc>().add(
              IncrementCounterEvent()); // it is collection and we are adding data
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
