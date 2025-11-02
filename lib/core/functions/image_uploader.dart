import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<String?> uploadImageToCloudinary(File imageFile) async {
  String cloudName = "dgdg1dexe";
  String presetName = "se7ety";

  final url = Uri.parse(
    "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
  );

  final request = http.MultipartRequest("Post", url);

  request.fields["upload_preset"] = presetName;

  request.files.add(await http.MultipartFile.fromPath("file", imageFile.path));

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseData = json.decode(responseBody);

      return responseData["secure_url"];
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
