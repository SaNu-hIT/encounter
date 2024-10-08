import 'package:encounter_app/core/app_export.dart';
import 'package:encounter_app/presentation/study_details_screen/provider/study_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';

class CustomBottomSheet extends StatefulWidget {
  final StudyDetailsProvider provider; // Accept the provider in the constructor

  CustomBottomSheet({required this.provider});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  List<bool> selected = [true, false, false]; // To track the selected option
  TextEditingController notesController =
      TextEditingController(); // Controller for notes
  Color currentColor = Colors.blue; // Initial color for color picker
  List<String> availableTags = [
    "Tag1",
    "Tag2",
    "Tag3",
    "Tag4"
  ]; // Available tags
  List<String> selectedTags = []; // To keep track of selected tags

  void updateSelection(int index) {
    setState(() {
      for (int i = 0; i < selected.length; i++) {
        selected[i] = i == index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Toggle buttons
          ToggleButtons(
            isSelected: selected,
            color: Colors.black45,
            fillColor: Colors.blue[50],
            splashColor: Colors.blue[50],
            selectedBorderColor: Colors.blue,
            selectedColor: Colors.blue,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            constraints: const BoxConstraints(minWidth: 110, minHeight: 40),
            onPressed: (int index) {
              updateSelection(
                  index); // Update the selection based on the clicked button
            },
            children: const [
              Row(
                children: [
                  Icon(Icons.note_add),
                  SizedBox(width: 5),
                  Text("Notes",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.sunny),
                  SizedBox(width: 5),
                  Text("Highlight",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.tag),
                  SizedBox(width: 5),
                  Text("Tag",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Show content based on the selected toggle button
          if (selected[0]) ...[
            // Notes input field
            TextField(
              controller: notesController,
              maxLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(1.0)),
                ),
                hintText: "Write your notes here...",
              ),
            ),
          ] else if (selected[1]) ...[
            // Color picker for Highlight
            ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (Color color) {
                setState(() {
                  currentColor = color;
                });
              },
            ),
            const SizedBox(height: 10),
          ] else if (selected[2]) ...[
            // Tag selection
            Wrap(
              spacing: 8.0,
              children: availableTags.map((tag) {
                bool isSelected = selectedTags.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: isSelected,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedTags.add(tag);
                      } else {
                        selectedTags.remove(tag);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Handle Cancel action here
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                      border: Border.all(
                          color: appTheme.black900.withOpacity(0.03)),
                    ),
                    child: Center(
                      child: Text(
                        "CANCEL",
                        style: CustomTextStyles.titleSmallBluegrayYellow,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Handle Save action here
                    widget.provider.submitNote(context);
                    // if (selected[0]) {
                    //   print("Notes: ${notesController.text}");
                    //   widget.provider.submitNote(notesController.text); // Use the provider
                    // } else if (selected[1]) {
                    //   print("Selected Color: $currentColor");
                    //   widget.provider.saveHighlightColor(currentColor); // Use the provider
                    // } else if (selected[2]) {
                    //   print("Selected Tags: $selectedTags");
                    //   widget.provider.saveTags(selectedTags); // Use the provider
                    // }
                    // Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: appTheme.blueButton,
                      border: Border.all(
                          color: appTheme.black900.withOpacity(0.03)),
                    ),
                    child: Center(
                      child: Text(
                        "SAVE",
                        style: CustomTextStyles.titleSmallWhiteA700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
