abstract class ListEvent {
  //in abstract we can not create direct object
}

class AdditionMapEvent extends ListEvent {
 // List<Map<String, dynamic>> passingData;

  String title, description;
  

  AdditionMapEvent({ required this.title, required this.description});
}

class FetchMapEvent extends ListEvent {}

class UpdateMapEvent extends ListEvent {}

class RemoveMapEvent extends ListEvent {
  int passingIndex;

  RemoveMapEvent({required this.passingIndex});
}
