class AppointmentModel {
  final String id;
  final String patientID;
  final String doctorId;
  final String name;
  final String phone;
  final String description;
  final String doctorName;
  final String location;
  final DateTime date;
  final bool isComplete;
  final double? rating;

  AppointmentModel({
    required this.id,
    required this.patientID,
    required this.doctorId,
    required this.name,
    required this.phone,
    required this.description,
    required this.doctorName,
    required this.location,
    required this.date,
    required this.isComplete,
    this.rating,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json["id"],
      patientID: json["patientID"],
      doctorId: json["doctorId"],
      name: json["name"],
      phone: json["phone"],
      description: json["description"],
      doctorName: json["doctorName"],
      location: json["location"],
      date: DateTime.parse(json["date"]),
      isComplete: json["isComplete"],
      rating: json["rating"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "patientID": patientID,
      "doctorId": doctorId,
      "name": name,
      "phone": phone,
      "description": description,
      "doctorName": doctorName,
      "location": location,
      "date": date.toIso8601String(),
      "isComplete": isComplete,
      "rating": rating,
    };
  }
}
