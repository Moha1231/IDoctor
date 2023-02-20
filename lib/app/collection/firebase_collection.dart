import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_model.dart';
import 'package:hallo_doctor_doctor_app/app/models/user_model.dart';

///Firebase collection class to make it easy accessing the firebase collection, if you wanto add new collection
///Just add collection name, and create CollectionReference base on the class model, and initialize it in FirebaseCollection._internal function
///Make sure you follow the template
class FirebaseCollection {
  /// User Collection base on firebase collection name
  static const String userCollectionName = "Users";
  static const String doctorCollectionName = "Doctors";

  static final FirebaseCollection _singleton = FirebaseCollection._internal();
  static final Map<Type, CollectionReference<dynamic>> _collectionCache = {};
  late CollectionReference<UserModel> userCol;
  late CollectionReference<Doctor> doctorCol;
  factory FirebaseCollection() {
    return _singleton;
  }

  FirebaseCollection._internal() {
    userCol = _getOrCreateCollection<UserModel>(
        collectionName: userCollectionName,
        fromJson: UserModel.fromFirestore,
        toJson: (UserModel model) => model.toJson());
    doctorCol = _getOrCreateCollection<Doctor>(
        collectionName: doctorCollectionName,
        fromJson: Doctor.fromFirestore,
        toJson: (Doctor model) => model.toJson());
  }
  static CollectionReference<T> _getOrCreateCollection<T>(
      {required String collectionName,
      required T Function(DocumentSnapshot doc) fromJson,
      required Map<String, dynamic> Function(T model) toJson}) {
    final type = T;
    if (_collectionCache.containsKey(type)) {
      return _collectionCache[type] as CollectionReference<T>;
    }
    final collection =
        FirebaseFirestore.instance.collection(collectionName).withConverter<T>(
              fromFirestore: (snapshot, _) => fromJson(snapshot),
              toFirestore: (value, _) => toJson(value),
            );
    _collectionCache[type] = collection;
    return collection;
  }
}
