import 'package:encounter_app/presentation/profile_screen/repo/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/app_export.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../models/DropItems.dart';
import '../models/profile_model.dart';

/// A provider class for the ProfileScreen.
///
/// This provider manages the state of the ProfileScreen, including the
/// current profileModelObj
// ignore_for_file: must_be_immutable

class ProfileProvider extends ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  var serverImage;
  List<SelectionPopupModel>? genderItems = [];
  bool isSelectedSwitch = false;
  dynamic result;
  final ImagePicker _picker = ImagePicker();
  @override
  void dispose() {
    super.dispose();
  }

  SelectionPopupModel? selFender;
  var gender = "";
  onSelectedGender(dynamic value) {
    print("value");
    print(value?.title);
    for (var element in genderItems!) {
      element.isSelected = false;
      if (element.title == value?.title) {
        gender = element.title;
        print("gender" + gender);
        element.isSelected = true;
      }
    }
    notifyListeners();
  }

  void changeSwitchBox(bool value) {
    isSelectedSwitch = value;
    notifyListeners();
  }

  var bytes;
  var image;
  var croppedImage;

  String fileName = "";
  ProfileResponse _respo = ProfileResponse();
  ProfileResponse get respo => _respo;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ProfileRepo _repo = ProfileRepo();
  String personName = "";
  String dailyVerses = "";
  loader(bool load) {
    _isLoading = load;
    notifyListeners();
  }

  List<Dropitems>? genderLisy = [
    Dropitems(
      title: "Male",
      id: 1,
    ),
    Dropitems(
      title: "Female",
      id: 2,
    ),
  ];

  getDataForEdit() async {
    loader(true);
    var respo1 = await _repo.getProfile();
    genderItems = genderLisy?.map((data) {
      return SelectionPopupModel(
        id: data.id,
        title: data.title ?? "",
        isSelected: respo1.data?.gender != null
            ? data.title == respo1.data?.gender
            : false,
      );
    }).toList();

    firstNameController.text = respo1.data?.firstName ?? "";
    secondNameController.text = respo1.data?.lastName ?? "";
    emailController.text = respo1.data?.email ?? "";
    serverImage = respo1.data?.image ?? "";
    gender = respo1.data?.gender ?? "";
    selFender = gender != ""
        ? genderItems?.firstWhere((item) => item.title == gender)
        : null;
    loader(false);
    notifyListeners();
  }

  getData() async {
    loader(true);
    var respo1 = await _repo.getProfile();
    personName = PrefUtils().getName();
    dailyVerses = PrefUtils().getVerses();
    image = respo1.data?.image ?? PrefUtils().getImage();
    loader(false);
    notifyListeners();
  }

  void handleImageSelection(BuildContext context) async {
    result = await _picker.pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      bytes = await result!.readAsBytes();
      // image = await decodeImageFromList(bytes);
      fileName = result!.name;
      // CroppedFile? file = await cropImage(result.path, context);
      image = await cropImage(result.path, context);
      croppedImage = XFile(image.path);
      // _doc.sink.add(true);
    } else {}

    if (result!.path.isEmpty) retrieveLostData();

    notifyListeners();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {}
  }

  Future<CroppedFile?> cropImage(String imageFile, BuildContext context) async {
    return await ImageCropper().cropImage(
      sourcePath: imageFile,
      // aspectRatioPresets: [
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio3x2,
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.ratio16x9
      // ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            // toolbarColor: gradiGreen,
            // toolbarWidgetColor: textBlack_25354F,
            initAspectRatio: CropAspectRatioPreset.original,
            // backgroundColor: bg,
            dimmedLayerColor: Colors.transparent,
            cropFrameColor: Colors.red,
            // cropGridColor: gradiBlue,
            // activeControlsWidgetColor: gradiGreen,
            // statusBarColor: gradiGreen,
            showCropGrid: true,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
  }

  saveData() async {
    print("titleController.text");
    print(firstNameController.text);
    print(secondNameController.text);
    print(emailController.text);
    print(gender);
    if (firstNameController.text != "" &&
        secondNameController.text != "" &&
        emailController.text != "" &&
        gender != "") {
      loader(true);
      var familyUpdateRespo = await _repo.editProfile(
          first_name: firstNameController.text,
          second_name: secondNameController.text,
          gender: gender,
          email: emailController.text,
          image: croppedImage);

      if (familyUpdateRespo.status == "success") {
        Fluttertoast.showToast(
            msg: "Update Success ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        NavigatorService.goBack();
      } else {
        Fluttertoast.showToast(
            msg: "Update failed ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Fill all values ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
