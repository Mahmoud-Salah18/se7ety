import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static final CollectionReference _doctorCollection = FirebaseFirestore
      .instance
      .collection("doctor");

  // static final CollectionReference _patientCollection = FirebaseFirestore
  //     .instance
  //     .collection("patient");

  static Future<QuerySnapshot> sortDoctorsByRating() {
    return _doctorCollection
        .orderBy("rating", descending: true)
        .where("specialization", isNull: false)
        .get();
  }

  static Future<QuerySnapshot> filterDoctorsBySpecialization(
    String specialization,
  ) {
    return _doctorCollection
        .where("specialization", isEqualTo: specialization, isNull: false)
        .get();
  }

  static Future<QuerySnapshot> getDoctorsByName(String searchKey) {
    return _doctorCollection
        .orderBy("name")
        .where("specialization", isNull: false)
        .startAt({searchKey})
        .endAt(["$searchKey\uf8ff"])
        .get();
  }
}
