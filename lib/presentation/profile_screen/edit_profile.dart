import 'dart:io';

import 'package:encounter_app/presentation/profile_screen/provider/profile_provider.dart';
import 'package:tuple/tuple.dart';

import '../../core/app_export.dart';
import '../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/circular_loader.dart';
import '../../widgets/custom_drop_down.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_text_form_field_login.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  AddMemberScreenState createState() => AddMemberScreenState();

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProfileProvider(), child: EditProfileScreen());
  }
}

class AddMemberScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).getDataForEdit();
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            SizedBox(
                width: SizeUtils.width,
                child: Container(
                    margin: EdgeInsets.only(left: 14.h, right: 14.h),
                    padding: EdgeInsets.symmetric(vertical: 14.v),
                    decoration: AppDecoration.fillWhiteA.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder16,
                    ),
                    child: Stack(alignment: Alignment.center, children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.h,
                          ),
                          decoration:
                              AppDecoration.gradientTealToTeal300.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder40,
                          ),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.h),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 24.v),
                                      Selector<ProfileProvider,
                                              Tuple2<dynamic, dynamic>>(
                                          selector: (context, provider) =>
                                              Tuple2(provider.image,
                                                  provider.serverImage),
                                          builder: (context, result, child) {
                                            return Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 86.adaptSize,
                                                  width: 86.adaptSize,
                                                  padding: EdgeInsets.all(3.h),
                                                  decoration: AppDecoration
                                                      .outline
                                                      .copyWith(
                                                    borderRadius:
                                                        BorderRadiusStyle
                                                            .circleBorder43,
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      Provider.of<ProfileProvider>(
                                                              context,
                                                              listen: false)
                                                          .handleImageSelection(
                                                              context);
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        null != result.item2
                                                            ? CustomImageView(
                                                                imagePath: result
                                                                        .item2 ??
                                                                    "",
                                                                fit:
                                                                    BoxFit.fill,
                                                                height: 76
                                                                    .adaptSize,
                                                                width: 76
                                                                    .adaptSize,
                                                                radius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  38.h,
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                              )
                                                            : SizedBox(),
                                                        null !=
                                                                result
                                                                    .item1?.path
                                                            ? Container(
                                                                height: 76
                                                                    .adaptSize,
                                                                width: 76
                                                                    .adaptSize,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    38.h,
                                                                  ),
                                                                ),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    45.h,
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    height: 90
                                                                        .adaptSize,
                                                                    width: 90
                                                                        .adaptSize,
                                                                    child: Image
                                                                        .file(
                                                                      File(result
                                                                          .item1
                                                                          .path),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ))
                                                            : CustomImageView(
                                                                imagePath: result
                                                                        .item2 ??
                                                                    "",
                                                                height: 76
                                                                    .adaptSize,
                                                                fit: BoxFit
                                                                    .cover,
                                                                width: 76
                                                                    .adaptSize,
                                                                radius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  38.h,
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),

                                      SizedBox(
                                        height: 14,
                                      ),

                                      Divider(
                                        height: 2,
                                      ),
                                      SizedBox(
                                        height: 14,
                                      ),

                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Selector<ProfileProvider,
                                                  TextEditingController?>(
                                              selector: (context, provider) =>
                                                  provider.firstNameController,
                                              builder: (context, nameController,
                                                  child) {
                                                return CustomTextFormFieldLogIn(
                                                  fieldType: FieldType.name,
                                                  controller: nameController,
                                                  hintText: "First Name".tr,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter a name';
                                                    }
                                                    return null;
                                                  },
                                                );
                                              }),
                                          SizedBox(
                                            height: 14,
                                          ),
                                          Selector<ProfileProvider,
                                                  TextEditingController?>(
                                              selector: (context, provider) =>
                                                  provider.secondNameController,
                                              builder: (context, nameController,
                                                  child) {
                                                return CustomTextFormFieldLogIn(
                                                  fieldType: FieldType.name,
                                                  controller: nameController,
                                                  hintText: "Last Name".tr,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter a name';
                                                    }
                                                    return null;
                                                  },
                                                );
                                              }),
                                          SizedBox(
                                            height: 14,
                                          ),
                                          Selector<ProfileProvider,
                                                  List<SelectionPopupModel>?>(
                                              selector: (context, provider) =>
                                                  provider.genderItems,
                                              builder: (context, genderItems,
                                                  child) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomDropDown(
                                                      hintText: "Gender".tr,
                                                      items: genderItems ?? [],
                                                      selectedItems: context
                                                          .read<
                                                              ProfileProvider>()
                                                          .selFender,
                                                      onChanged: (value) {
                                                        context
                                                            .read<
                                                                ProfileProvider>()
                                                            .onSelectedGender(
                                                                value);
                                                      },
                                                      validator: (value) {
                                                        if (value == null) {
                                                          return 'Please select gender';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ],
                                                );
                                              }),
                                          SizedBox(
                                            height: 14,
                                          ),
                                          Selector<ProfileProvider,
                                                  TextEditingController?>(
                                              selector: (context, provider) =>
                                                  provider.emailController,
                                              builder: (context, nameController,
                                                  child) {
                                                return CustomTextFormFieldLogIn(
                                                  fieldType: FieldType.email,
                                                  controller: nameController,
                                                  hintText: "Email".tr,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter a email';
                                                    }
                                                    return null;
                                                  },
                                                );
                                              }),
                                        ],
                                      ),
                                      //
                                      SizedBox(
                                        height: 14,
                                      ),

                                      SizedBox(height: 21.v),
                                    ]),
                              )),
                        ),
                      ),
                    ]))),
            Selector<ProfileProvider, bool>(
              selector: (context, provider) => provider.isLoading,
              builder: (context, value, child) {
                return value ? CircularLoader() : SizedBox();
              },
            ),
          ],
        ));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 54.v,
        leadingWidth: 51.h,
        leading: AppbarLeadingIconbutton(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 25.h, top: 13.v, bottom: 13.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title: Column(
          children: [
            AppbarTitle(
                text: "Edit Profile", margin: EdgeInsets.only(left: 14.h)),
          ],
        ),
        actions: [
          AppbarSubtitle(
              onTap: () => {
                    if (_formKey.currentState!.validate())
                      {
                        // Form is valid, proceed with further actions
                        Provider.of<ProfileProvider>(context, listen: false)
                            .saveData()
                      }
                    else
                      {
                        // Form is invalid, display an error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Please correct the errors in the form')),
                        )
                      }
                  },
              text: "Update",
              margin: EdgeInsets.fromLTRB(23.h, 15.v, 23.h, 18.v))
        ]);
  }

  /// Navigates to the previous screen.
  onTapArrowLeft(BuildContext context) {
    NavigatorService.goBack();
  }
}
