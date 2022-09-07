import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStorageRepositoryProvider = Provider((ref) =>
    FirebaseStorageRepository(firebaseStorage: FirebaseStorage.instance));

class FirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  FirebaseStorageRepository({required this.firebaseStorage});

  //! ADD A FILE TO FIREBASE
  Future<String> addFileToFirebaseStorage(
      {required String storageRef, required File file}) async {
    //! CREATE AN UPLOAD TASK
    UploadTask uploadTask =
        firebaseStorage.ref().child(storageRef).putFile(file);

    //! COLLECT THE SNAPSHOT FOR DOWNLOAD URL RETRIEVAL
    TaskSnapshot snapshot = await uploadTask;

    //! GET DOWNLOAD URL
    String downloadURL = await snapshot.ref.getDownloadURL();

    return downloadURL;
  }
}
