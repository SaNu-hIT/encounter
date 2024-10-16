import 'package:encounter_app/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../widgets/custom_text_form_field.dart';
import 'provider/note_provider.dart';

class AddNotesSheet extends StatelessWidget {
  final String statementIds; // Add a new parameter
  final VoidCallback onApiSuccess;
  AddNotesSheet({required this.statementIds, required this.onApiSuccess});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChangeNotifierProvider(
          create: (_) => NotesProvider(),
          builder: (context, _) {
            Provider.of<NotesProvider>(context, listen: false).getTags();
            return Container(
              width: SizeUtils.width,
              child: Consumer<NotesProvider>(builder: (context, provider, _) {
                provider.statement_ids = statementIds;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ToggleButtons(
                        isSelected: provider.selected,
                        color: Colors.black45,
                        fillColor: Colors.blue[50],
                        splashColor: Colors.blue[50],
                        selectedBorderColor: Colors.blue,
                        selectedColor: Colors.blue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        constraints:
                            const BoxConstraints(minWidth: 110, minHeight: 40),
                        onPressed: (int index) {
                          provider.updateSelection(
                              index); // Update the selection based on the clicked button
                        },
                        children: const [
                          Row(
                            children: [
                              Icon(Icons.note_add),
                              SizedBox(width: 5),
                              Text("Notes",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.sunny),
                              SizedBox(width: 5),
                              Text("Highlight",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.tag),
                              SizedBox(width: 5),
                              Text("Tag",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Show content based on the selected toggle button
                      if (provider.selected[0]) ...[
                        // Notes input field

                        Padding(
                          padding: EdgeInsets.only(left: 23.h, right: 23.h),
                          child: CustomTextFormField(
                            controller: provider.notesController,
                            hintText: "lbl_type_here".tr,
                            textInputAction: TextInputAction.done,
                            maxLines: 4,
                          ),
                        )
                      ] else if (provider.selected[1]) ...[
                        Padding(
                            padding: EdgeInsets.only(left: 23.h, right: 23.h),
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 7,
                              ),
                              itemCount: provider.colors.length,
                              itemBuilder: (context, index) {
                                final color = provider.colors[index];
                                bool isSelected =
                                    provider.currentColor == color;

                                return GestureDetector(
                                  onTap: () {
                                     provider.selectColor(color);
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(4.0),
                                        decoration: BoxDecoration(
                                          color: color,
                                          border: Border.all(
                                            color: isSelected
                                                ? Colors.black
                                                : Colors.transparent,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                      ),
                                      if (isSelected)
                                        Center(
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            )),

                        // Color picker for Highlight
                        // ColorPicker(
                        //   pickerColor: provider.currentColor,
                        //   onColorChanged: (Color color) {
                        //     provider.currentColor = color;
                        //   },
                        // ),

                        const SizedBox(height: 10),
                      ] else if (provider.selected[2]) ...[
                        Padding(
                          padding: EdgeInsets.only(left: 23.h, right: 23.h),
                          child: TextField(
                            controller: provider.tagController,
                            decoration: InputDecoration(
                              hintText: 'Enter a new tag',
                              suffixIcon: IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  print("object");
                                  provider.addTag();
                                },
                              ),
                            ),
                          ),
                        ),
                        // Tag selection
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: provider.availableTags.map((tag) {
                            bool isSelected =
                                provider.selectedTags.contains(tag);
                            return FilterChip(
                              label: Text(tag.tagName ?? ""),
                              selected: isSelected,
                              onDeleted: () {
                                provider.deleteTags(tag.id.toString());
                              },
                              onSelected: (bool selected) {
                                if (selected) {
                                  provider.selectTag(tag);
                                } else {
                                  provider.removeTag(tag);
                                }
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
                                Navigator.pop(
                                    context); // Handle Cancel action here
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: appTheme.whiteA700,
                                  border: Border.all(
                                      color:
                                          appTheme.black900.withOpacity(0.03)),
                                ),
                                child: Center(
                                  child: Text(
                                    "CANCEL",
                                    style: CustomTextStyles
                                        .titleSmallBluegrayYellow,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // Handle Save action here

                                if (provider.selected[0]) {
                                  print(
                                      "Notes: ${provider.notesController.text}");
                                  provider.type = 1;
                                  provider.dataItem =
                                      provider.notesController.text;
                                } else if (provider.selected[1]) {
                                  provider.type = 3;
                                  provider.dataItem = provider.currentColor
                                      .toHexString()
                                      .substring(2);

                                  print(
                                      "Selected Color: $provider.currentColor");
                                } else if (provider.selected[2]) {
                                  provider.type = 2;
                                  provider.dataItem = provider.selectedTags
                                      .map((tag) => tag.id
                                          .toString()) // Extract `id` from each `TagData` object and convert to string
                                      .join(
                                          ','); // Join all the ids into a comma-separated string
                                  print(
                                      "Selected Tags: ${provider.selectedTags}");
                                }
                                provider.submitNote(context);
                                onApiSuccess();
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: appTheme.blueButton,
                                  border: Border.all(
                                      color:
                                          appTheme.black900.withOpacity(0.03)),
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
                ); // this works fine
              }),
            );
          }),
    );
  }
}
