class PatientModel {
  String? name;
  String? image;
  String? age;
  String? email;
  String? phone;
  int? gender;
  String? bio;
  String? city;
  String? uid;

  PatientModel({
    this.name,
    this.image,
    this.age,
    this.email,
    this.phone,
    this.gender,
    this.bio,
    this.city,
    this.uid,
  });

  PatientModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    image = json["image"];
    age = json["age"];
    email = json["email"];
    phone = json["phone"];
    bio = json["bio"];
    city = json["city"];
    gender = json["gender"];
    uid = json["uid"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["image"] = image;
    data["age"] = age;
    data["email"] = email;
    data["phone"] = phone;
    data["bio"] = bio;
    data["city"] = city;
    data["uid"] = uid;
    data["gender"] = gender;
    return data;
  }
}
