import 'dart:developer';

import 'package:bloc_sm/BLoC/list_block.dart';
import 'package:bloc_sm/BLoC/list_event.dart';
import 'package:bloc_sm/BLoC/list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => ListBLoc(),
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  List<Map<String, dynamic>> pdata = [
    {"name": "Peeyush", "class": "BSC-CS"}
  ];
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
            Expanded(
              child:
                  BlocBuilder<ListBLoc, ListState>(builder: (context, state) {
                log("blocBuilder is called is callred");

                ///  it rebuild only Text
                return state.mData.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(state.mData[index]['name']),
                              subtitle: Text(state.mData[index]
                                  ['class']) //state.mData[index]['class']
                              );
                        },
                        itemCount: state.mData.length)
                    : Text("there is no value in map");

                /* Text(
                  '${context.watch<ListBLoc>().state.count} or  ${state.count}', // no need to add full code we can do here only with state
                );*/
              }),
            ),
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
                                context.read<ListBLoc>().add(RemoveMapEvent());
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
          context.read<ListBLoc>().add(AdditionMapEvent(
              passingData: pdata)); // it is collection and we are adding data
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
