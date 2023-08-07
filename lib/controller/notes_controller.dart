import 'package:get/get.dart';
import 'package:mindjot/const/firebase_const.dart';
import 'package:mindjot/models/note.dart';
import 'package:mindjot/services/api_service.dart';

class NoteController extends GetxController {
  var isLoading = true.obs;
  RxList notes = [].obs;

  NoteController() {
    fetchNotes();
  }
  void addNote(Note note) {
    notes.add(note);
    sortnotes();
    ApiService.addNote(note);
  }

  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.nid == note.nid));
    notes[indexOfNote] = note;
    sortnotes();
    ApiService.addNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.nid == note.nid));
    notes.removeAt(indexOfNote);
    sortnotes();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async {
    notes.value = await ApiService.fetchNotes(currentuser!.uid);
    sortnotes();
    isLoading.value = false;
  }

  void sortnotes() {
    notes.sort((a, b) => b.dateadded!.compareTo(a.dateadded!));
  }

  List getFilteredNoted(String searchQuery) {
    return notes.value
        .where((element) =>
            element.title!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            element.content!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }
}
