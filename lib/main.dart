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


  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
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
                            leading: Text("$index"),
                            title: Text(state.mData[index]['name']),
                            subtitle: Text(state.mData[index]['descrtion']),

                            trailing: IconButton(
                                onPressed: () {
                                  context
                                      .read<ListBLoc>()
                                      .add(RemoveMapEvent(passingIndex: index));
                                },
                                icon: Icon(Icons
                                    .delete)), //state.mData[index]['class']
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
                                // context.read<ListBLoc>().add();
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
          showModalBottomSheet(
              context: context,
              builder: (BuildContext) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Enter Your Name")),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Enter Your Description")),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("cancel")),
                          ElevatedButton(
                              onPressed: () {
                                context.read<ListBLoc>().add(AdditionMapEvent(
                                    title: nameController.text,
                                    description: descriptionController.text));
                              },
                              child: Text("ADD")),
                        ],
                      )
                    ],
                  ),
                );
              });
          // it is collection and we are adding data
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
