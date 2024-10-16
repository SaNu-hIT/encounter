import 'package:encounter_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../add_notes/add_notes_page.dart';
import '../models/bible_detail_model.dart';
import '../models/bible_model.dart';
import '../repo/login_repo.dart';

/// A provider class for the BiblePage.
///
/// This provider manages the state of the BiblePage, including the
/// current bibleModelObj
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class BibleProvider extends ChangeNotifier {
  @override
  void dispose() {
    super.dispose();
  }

  bool _isSelectedOldTestament = true;
  bool _isSelectedNewTestament = false;

  bool get isSelectedOldTestament => _isSelectedOldTestament;
  bool get isSelectedNewTestament => _isSelectedNewTestament;

  void selectOldTestament() {
    _isSelectedOldTestament = true;
    _isSelectedNewTestament = false;
    testament_id = "1";
    notifyListeners();
    getBibleList();
  }

  void selectNewTestament() {
    _isSelectedOldTestament = false;
    _isSelectedNewTestament = true;
    testament_id = "2";
    notifyListeners();
    getBibleList();
  }

  final BibleRepo _repo = BibleRepo();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  loader(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  var testament_id = "1";
  var book_id = "";
  BibleDetailModel _bibleDetailRespo = BibleDetailModel();
  BibleListModel _bibleRespo = BibleListModel();
  BibleDetailModel get bibleDetailRespo => _bibleDetailRespo;
  BibleListModel get bibleRespo => _bibleRespo;

  void toggleData(int statementIndex, int? id) {
    if (id == null) return;

    ChapterData? courseDayVerseItem = _bibleDetailRespo.data?.firstWhere(
      (verse) => verse.chapterId == id,
    );
    // statementIndex = statementIndex + 1;
    if (courseDayVerseItem != null) {
      if (statementIndex >= 0 &&
          statementIndex < courseDayVerseItem.statements!.length) {
        Statements statement = courseDayVerseItem.statements![statementIndex];
        statement.isSelected = !statement.isSelected;

        // Notify listeners to update the UI after toggling the data
        notifyListeners();
      } else {
        print("Invalid statement index.");
      }
    } else {
      print("CourseDayVerse with id $id not found.");
    }
  }

  String getSelectedBibleTextIds() {
    // List to store the selected IDs
    List<String> selectedIds = [];

    // Iterate over each CourseDayVerse
    _bibleDetailRespo.data?.forEach((verse) {
      // Check if verse contains statements
      verse.statements?.forEach((statement) {
        // If the statement is selected, add its ID to the list
        if (statement.isSelected) {
          selectedIds.add(statement.statementId
              .toString()); // Assuming statementNo is the ID
        }
      });
    });

    // Join the selected IDs into a comma-separated string
    return selectedIds.join(',');
  }

  int getSelectedBibleTextCount() {
    // Variable to store the count of selected items
    int selectedCount = 0;

    // Iterate over each CourseDayVerse
    _bibleDetailRespo.data?.forEach((verse) {
      // Check if verse contains statements
      verse.statements?.forEach((statement) {
        // If the statement is selected, increase the count
        if (statement.isSelected) {
          selectedCount++;
        }
      });
    });

    // Return the count of selected items
    return selectedCount;
  }

  bool isMultipleSelect = false;

  void unselectAll() {
    // Check if there are any CourseDayVerse items
    if (_bibleDetailRespo.data != null) {
      // Iterate through each CourseDayVerse
      for (var courseDayVerseItem in _bibleDetailRespo.data!) {
        // Iterate through each statement in the CourseDayVerse and unselect it
        for (var statement in courseDayVerseItem.statements!) {
          statement.isSelected = false;
        }
      }
      isMultipleSelect = false;
      // Notify listeners to update the UI after unselecting all statements
      notifyListeners();
    } else {
      print("No CourseDayVerse items found.");
    }
  }

  getBibleList() async {
    loader(true);

    _bibleRespo = await _repo.getBibleList(testament_id: testament_id);
    loader(false);

    notifyListeners();
  }

  getBibleChapter(String book_id) {
    this.book_id = book_id;
    reloadData();
  }

  reloadData() async {
    loader(true);

    _bibleDetailRespo = await _repo.getBibleChapter(book_id: this.book_id);
    loader(false);

    notifyListeners();
  }

  void showCustomBottomSheet(BuildContext context, String statementIds) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize:
              0.5, // Starting height as a fraction of the screen (50%)
          minChildSize: 0.5, // Minimum height (30% of screen)
          maxChildSize: 0.9, // Maximum height (90% of screen)
          expand: false, // Prevents full-screen expansion
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller:
                  scrollController, // Enables scrolling within the bottom sheet
              child: AddNotesSheet(
                statementIds: statementIds,
                onApiSuccess: () {
                  reloadData();
                },
              ),
            );
          },
        );
      },
    );
  }

  String getSelectedBibleText() {
    // List to store the selected IDs
    List<String> selectedText = [];

    // Iterate over each CourseDayVerse
    _bibleDetailRespo.data?.forEach((verse) {
      // Check if verse contains statements
      verse.statements?.forEach((statement) {
        // If the statement is selected, add its ID to the list
        if (statement.isSelected) {
          selectedText.add(statement.statementText.toString() +
              "\n" +
              verse.bookName.toString() +
              " " +
              verse.chapterName.toString() +
              " : " +
              verse.chapterNo.toString()); // Assuming statementNo is the ID
        }
      });
    });

    // Join the selected IDs into a comma-separated string
    return selectedText.join('\n \n \n');
  }

  void copyData() {
    Clipboard.setData(
      ClipboardData(
        text: getSelectedBibleText(),
      ),
    );
  }

  void shareWhatsApp() {
    shareToWhatsAppText("Bible Verses \n", getSelectedBibleText() ?? "", "");
  }

  void showAlertPopup(BuildContext context, Statements statement) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Text('Options'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !isMultipleSelect
                    ? GestureDetector(
                        onTap: () {
                          isMultipleSelect = true;
                          notifyListeners();
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(child: Text('Select Multiple')),
                        ))
                    : GestureDetector(
                        onTap: () {
                          unselectAll();
                          isMultipleSelect = false;
                          notifyListeners();
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(child: Text('Unselect all')),
                        )),
                GestureDetector(
                    onTap: () {
                      isMultipleSelect = false;
                      copyData();
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(child: Text('Copy')),
                    )),
                GestureDetector(
                    onTap: () {
                      isMultipleSelect = false;
                      Navigator.pop(context);
                      showCustomBottomSheet(context, getSelectedBibleTextIds());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(child: Text('Add Notes')),
                    )),
                GestureDetector(
                    onTap: () {
                      isMultipleSelect = false;
                      shareWhatsApp();
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(child: Text('Share')),
                    ))
              ],
            ),
            actions: [
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
