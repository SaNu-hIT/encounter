import 'package:dio/dio.dart';
import 'package:encounter_app/presentation/profile_screen/models/profile_model.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../services/dio_services/dio_builder.dart';
import '../../../network/app_apis.dart';

class ProfileRepo {
  Future<ProfileResponse> getProfile() async {
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      final response = (await dioBuilderResponse.dio.get(
        AppAPIs.myprofile,
        options: dioBuilderResponse.dioOptions,
      ));
      ProfileResponse model = ProfileResponse();
      if (response.statusCode == 200) {
        model = ProfileResponse.fromJson((response.data));
      } else {
        model = ProfileResponse.fromJson((response.data));
      }
      return model;
    } catch (e) {
      print(e);
      return ProfileResponse();
    }
  }

  Future<ProfileResponse> editProfile({
    XFile? image,
    required String first_name,
    required String second_name,
    required String gender,
    required String email,
  }) async {
    MultipartFile? imageFile;
    if (null != image) {
      imageFile = await MultipartFile.fromFile(image.path);
    }
    try {
      DioBuilderResponse dioBuilderResponse =
          await DioBuilder().buildNonCachedDio(hasAuth: true);
      FormData formData = FormData.fromMap({
        'first_name': first_name,
        'last_name': second_name,
        'gender': gender,
        'email': email,
        if (image != null) 'image': imageFile,
      });
      print(formData.toString());
      formData.fields.forEach((element) {
        print("${element.key}: ${element.value}");
      });
      formData.files.forEach((element) {
        print("${element.key}: ${element.value.contentType}");
      });
      final response = await dioBuilderResponse.dio.post(AppAPIs.edit_profile,
          options: dioBuilderResponse.dioOptions, data: formData);
      if (response.statusCode == 200) {
        return ProfileResponse.fromJson((response.data));
      } else {
        return ProfileResponse();
      }
    } catch (e) {
      return ProfileResponse();
    }
  }
}

class UpdateFamilyRespo {}
