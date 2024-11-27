abstract class ListEvent {
  //in abstract we can not create direct object
}

class AdditionMapEvent extends ListEvent {
  List<Map<String, dynamic>> passingData;


  AdditionMapEvent({required this.passingData});
}

class FetchMapEvent extends ListEvent {}

class UpdateMapEvent extends ListEvent {}

class RemoveMapEvent extends ListEvent {}
