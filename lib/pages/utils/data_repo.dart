import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/request_model.dart';

class DataRepository {
  DataRepository({required this.firestore});

  final FirebaseFirestore firestore;

  CollectionReference get collection =>
      firestore.collection('notes');

  //Retour de models a la place de snapshots
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Stream<QuerySnapshot> getStreamDetail(String id) {
    return collection.doc(id).collection('tasks').snapshots();
  }

  Stream<List<RequestModel>> noteStream() {
    try {
      return collection.snapshots().map((notes) {
        final List<RequestModel> notesFromFirestore = <RequestModel>[];
        for (var doc in notes.docs) {
          notesFromFirestore.add(RequestModel.fromMap(doc as Map<String, dynamic>?));
        }
        return notesFromFirestore;
      });
    } catch (e) {
      rethrow;
    }
  }
}