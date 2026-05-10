import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:condition_report/models/general_details_model.dart';
import 'package:condition_report/models/image_detail.dart';
import 'package:condition_report/models/new_element_model.dart';
import 'package:condition_report/models/occupancy_model.dart';
import 'package:condition_report/models/property_details_model.dart';
import 'package:condition_report/provider/assessment_provider.dart';

class FireStoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get assessment collection for a specific user
  CollectionReference<Map<String, dynamic>> getAssessmentCollection() {
    return _firestore.collection("users").doc(uid).collection("assessment");
  }

  final List<String> ids = [];

  // Create a new assessment and return its ID
  Future<String> createAssessment() async {
    try {
      final docRef = getAssessmentCollection().doc();
      ids.add(docRef.id);
      currentId = docRef.id;
      await docRef.set({
        'createdAt': FieldValue.serverTimestamp(),
        "generalDetails": {},
        "propertyDetails": {},
        "occupancy": {},
        "images": []
      });
      return docRef.id;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> createNewElement(String elementName, NewElementModel data) async {
    try {
      final docRef = getAssessmentCollection().doc(currentId);
      await docRef.update({
        elementName: data.toMap(),
      });
      return docRef.id;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addGeneralDetails( String assessmentId, GeneralDetailsModel data) async {
    try {
      log(currentId!);
      await getAssessmentCollection().doc(assessmentId).update({
        "generalDetails": data.toMap(),
      });
      log('General details added successfully');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addImage( String assessmentId, ImageDetail imageDetail) async {
    try {
      await getAssessmentCollection().doc(assessmentId).update({
        "images": FieldValue.arrayUnion([imageDetail.toMap()]),
      });
      log("Image detail added successfully to Firestore.");
    } catch (e) {
      log("Error adding image detail to Firestore: $e");
      throw Exception(e.toString());
    }
  }

  Future<void> addPropertyDetails( String assessmentId, PropertyDetailsModel data) async {
    try {
      await getAssessmentCollection().doc(assessmentId).update({
        "propertyDetails": data.toMap(),
      });
      log('Property details added successfully');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addOccupancyDetails( String assessmentId, OccupancyModel data) async {
    try {
      await getAssessmentCollection().doc(assessmentId).update({
        "occupancy": data.toMap(),
      });
      log('Occupancy details added successfully');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> fetchAssessment( String assessmentId) async {
    try {
      final docSnapshot = await getAssessmentCollection().doc(assessmentId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data()!;
      } else {
        throw Exception("Assessment not found");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllAssessments() {
    try {
      return getAssessmentCollection()
          .orderBy('createdAt', descending: true)
          .snapshots();
    } catch (e) {
      throw Exception("Error fetching assessments: ${e.toString()}");
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> fetchNewElements() {
    try {
      return getAssessmentCollection().doc(currentId).snapshots();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteAssessment( String assessmentId) async {
    try {
      await getAssessmentCollection().doc(assessmentId).delete();
      log('Assessment deleted successfully');
    } catch (e) {
      throw Exception("Error deleting assessment: ${e.toString()}");
    }
  }

  Stream<List<Map<String, dynamic>>> fetchPhotoStreamImages() {
    try {
      return getAssessmentCollection()
          .doc(currentId)
          .snapshots()
          .map((documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic>? data = documentSnapshot.data();
          List<dynamic>? imagesList = data?["images"] as List<dynamic>?;
          if (imagesList != null) {
            List<Map<String, dynamic>> filteredImages = imagesList
                .where((image) => image is Map<String, dynamic> && image["id"] == "ps")
                .map((image) => image as Map<String, dynamic>)
                .toList();
            return filteredImages;
          }
        }
        return [];
      });
    } catch (e) {
      log("Error fetching images: $e");
      return Stream.value([]);
    }
  }

  Future<List<Map<String, dynamic>>> fetchGDImages() async {
    try {
      var documentSnapshot = await getAssessmentCollection().doc(currentId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data = documentSnapshot.data();
        List<dynamic>? imagesList = data?["images"] as List<dynamic>?;

        if (imagesList != null) {
          List<Map<String, dynamic>> filteredImages = imagesList
              .where((image) => image is Map<String, dynamic> && image["id"] == "gd")
              .map((image) => image as Map<String, dynamic>)
              .toList();

          return filteredImages;
        }
      }
      return [];
    } catch (e) {
      log("Error fetching images: $e");
      return [];
    }
  }

  Stream<List<String>> fetchAllImages() {
    try {
      return getAssessmentCollection()
          .doc(currentId)
          .snapshots()
          .map((documentSnapshot) {
        List<String> allImages = [];

        Map<String, dynamic>? data = documentSnapshot.data();
        List<dynamic>? imagesList = data?["images"] as List<dynamic>?;

        if (imagesList != null) {
          for (var image in imagesList) {
            if (image is Map<String, dynamic> && image.containsKey("path")) {
              allImages.add(image["path"]);
            }
          }
        }
        return allImages;
      });
    } catch (e) {
      log("Error fetching images: $e");
      return Stream.value([]);
    }
  }
}