import 'dart:developer';

import 'package:bloc_sm/BLoC/list_block.dart';
import 'package:bloc_sm/BLoC/list_event.dart';
import 'package:bloc_sm/BLoC/list_state.dart';
import 'package:bloc_sm/local/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => NotesBloc(db: DBHelper.getInstance),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NotesBloc>().add(FetchMapEvent());
  }

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

  TextEditingController updatenameController = TextEditingController();
  TextEditingController updatedescriptionController = TextEditingController();
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
                  BlocBuilder<NotesBloc, NotesState>(builder: (context, state) {
                log("blocBuilder is called is callred");

                ///  it rebuild only Text
                ///
                if (state is NotesLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NotesErroState) {
                  return Center(
                    child: Text(state.errMsg),
                  );
                } else if (state is NotesLoadedState) {
                  return state.stateArrNotes.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Text("$index"),
                              title: Text(state.stateArrNotes[index]['title']),
                              subtitle: Text(
                                  state.stateArrNotes[index]['description']),

                              trailing: IconButton(
                                  onPressed: () {
                                    context.read<NotesBloc>().add(
                                        RemoveMapEvent(passingIndex: index));
                                  },
                                  icon: Icon(Icons.delete)),

                              onTap: () {
                                updatenameController.text =
                                    state.stateArrNotes[index]['name'];
                                updatedescriptionController.text =
                                    state.stateArrNotes[index]['descrtion'];
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
                                              controller: updatenameController,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  label:
                                                      Text("update Your Name")),
                                            ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                            TextField(
                                              controller: descriptionController,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  label: Text(
                                                      "update Your Description")),
                                            ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("cancel")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      context
                                                          .read<NotesBloc>()
                                                          .add(UpdateMapEvent(
                                                              passingIndex:
                                                                  index,
                                                              title:
                                                                  updatenameController
                                                                      .text,
                                                              description:
                                                                  updatedescriptionController
                                                                      .text));
                                                    },
                                                    child: Text("ADD")),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              }, //state.stateArrNotes[index]['class']
                            );
                          },
                          itemCount: state.stateArrNotes.length)
                      : Text("there is no value in map");
                } else {
                  return Container(
                    child: Text("Operation Failed"),
                  );
                }

                /* Text(
                  '${context.watch<NotesBloc>().state.count} or  ${state.count}', // no need to add full code we can do here only with state
                );*/
              }),
            ),
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
                                context.read<NotesBloc>().add(AdditionMapEvent(
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
