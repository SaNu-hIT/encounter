import 'package:encounter_app/presentation/add_notes/provider/note_provider.dart';
import 'package:encounter_app/presentation/study_details_screen/models/course_day_details.dart';
import 'package:encounter_app/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../core/app_export.dart';

class AddNotesPage extends StatefulWidget {
  const AddNotesPage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  BiblePageState createState() => BiblePageState();
  static Widget builder(
      BuildContext context, Statements? statements, CourseDayVerse? verses) {
    return ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: AddNotesPage(),
    );
  }
}

class BiblePageState extends State<AddNotesPage>
    with AutomaticKeepAliveClientMixin<AddNotesPage> {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
  }
  // Handle the close button press
  void _closeNote() {
    Navigator.of(context).pop();
  }
  final int _maxWords = 300;

  // Function to count words in the text
  int _countWords(String text) {
    if (text.isEmpty) return 0;
    return text.trim().split(RegExp(r'\s+')).length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<NoteProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return LoaderWidget();
          }
          return AlertDialog(
            title: Text("Add Notes"), // Title of the dialog
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title or statement text
                  // Text(widget.statements?.statementText ?? ""),
                  SizedBox(height: 20),
                  // Note input field
                  TextField(
                    controller: provider.noteController,
                    maxLines: 8,
                    decoration: InputDecoration(
                      labelText: 'Note',
                      hintText: 'Enter your note (max $_maxWords words)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (_countWords(value) > _maxWords) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Note cannot exceed $_maxWords words'),
                        ));
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              // Close button
              TextButton(
                onPressed: _closeNote,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Close'),
                ),
              ),
              // Submit button
              ElevatedButton(
                onPressed: () {
                  // Ensure submit is wrapped properly with a lambda
                  // provider.submitNote(widget.statements, widget.verses);
                  _closeNote();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Submit'),
                ),
              ),
            ],
          );
       
       
       
        },
      ),
    );
  }


}
