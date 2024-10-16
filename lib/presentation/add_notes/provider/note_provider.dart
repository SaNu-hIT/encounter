import 'package:flutter/material.dart';
import '../../study_details_screen/models/tags_respo.dart';
import '../../study_details_screen/repo/course_detail_repo.dart';

class NotesProvider with ChangeNotifier {
  List<bool> selected = [true, false, false]; // To track the selected option
  TextEditingController notesController =
      TextEditingController(); // Controller for notes
  Color currentColor = Colors.blue; // Initial color for color picker

  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.cyan,
    Colors.lime,
    Colors.brown,
    Colors.grey,
    Colors.indigo,
    Colors.amber,
    Colors.lightBlue,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.lightGreen,
  ];

  bool _isAddingTag = false;
  TextEditingController tagController = TextEditingController();
  TagsRespo _tag_respo = TagsRespo();
  TagsRespo get tag_respo => _tag_respo;
  final CourseDetailRepo _repo = CourseDetailRepo();
  List<TagData> availableTags = [];
  List<TagData> selectedTags = [];
  var type;
  String statement_ids = "";
  String dataItem = "";
  void updateSelection(int index) {
    for (int i = 0; i < selected.length; i++) {
      selected[i] = i == index;
    }
    notifyListeners();
  }

  void addTag() {
    final newTag = tagController.text.trim();
    print(newTag);
    if (newTag.isNotEmpty && !availableTags.contains(newTag)) {
      addTags(newTag);
      tagController.clear();
    }
  }

  Future<void> addTags(String newTag) async {
    print(newTag);
    var respo = await _repo.addTags(tagname: newTag);
    getTags();
  }

  Future<void> deleteTags(String tagId) async {
    print(tagId);
    var respo = await _repo.deleteTags(tagId: tagId);

    getTags();
  }

  Future<void> submitNote(BuildContext context) async {
    print("statement_ids");
    print(statement_ids);
    print(dataItem);
    var respo = await _repo.addMarkings(
        type: type, statement_ids: statement_ids, data: dataItem);
    Navigator.pop(context);
  }

  Future<void> getTags() async {
    _tag_respo = await _repo.getTags();
    if (_tag_respo.status == "success" && _tag_respo.data != null) {
      // Clear previous tag data if needed
      availableTags.clear();
      availableTags.addAll(_tag_respo.data ?? []);
      // Optionally notify listeners if using a state management solution
      notifyListeners(); // If using Provider or similar
    } else {
      // Handle the error case
      print('Failed to fetch tags: ${_tag_respo.status}');
    }
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  loader(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  void selectTag(TagData tag) {
    selectedTags.add(tag);
    notifyListeners();
  }

  void removeTag(TagData tag) {
    selectedTags.remove(tag);
    notifyListeners();
  }

  void selectColor(Color color) {
    currentColor = color;
    notifyListeners();
  }
}
