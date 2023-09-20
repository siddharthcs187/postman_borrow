import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class LendRequest {
  final String id;
  final String userId;
  final String username;
  final String profilePicUrl;
  final String imageUrl;
  final String title;
  final String body;
  bool isSaved;

  LendRequest({
    required this.imageUrl,
    required this.id,
    required this.userId,
    required this.username,
    required this.profilePicUrl,
    required this.title,
    required this.body,
    this.isSaved = false,
  });
}

class BorrowRequest {
  final String id;
  final String userId;
  final String username;
  final String profilePicUrl;
  final String title;
  final String description;
  final String body;
  final String imageUrl;
  final String saleOrRent;
  bool isSaved; // check later if it has to be implemented

  BorrowRequest({
    required this.id,
    required this.userId,
    required this.username,
    required this.profilePicUrl,
    required this.title,
    required this.description,
    required this.body,
    required this.imageUrl,
    required this.saleOrRent,
    this.isSaved = false,
  });
}

Future<String?> uploadImage(File imageFile, String userId) async {
  final uuid = Uuid();
  final String randomPart = uuid.v4();
  try {
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child(userId + '_' + randomPart + '.jpg');
    await storageReference.putFile(imageFile);
    final String imageUrl = await storageReference.getDownloadURL();
    return imageUrl;
  } catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}

Future<void> postLendRequest(
    {required String title,
    required String body,
    required String imageUrl,
    required String rentOrSell,
    required String username,
    required String profilePicUrl,
    required String userId}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      print('making lend: ' + rentOrSell);
      final lendRequestData = {
        'title': title,
        'body': body,
        'imageUrl': imageUrl,
        'rentOrSell': rentOrSell,
        'username': username,
        'profilePicUrl': profilePicUrl,
        'userId': userId,
      };

      await FirebaseFirestore.instance
          .collection('Lend_Requests')
          .add(lendRequestData);
      print('lend request successful');
    } catch (e) {
      print('Error posting lend request: $e');
    }
  }
}

Future<void> postBorrowRequest(
    {required String title,
    required String body,
    required String imageUrl,
    required String username,
    required String profilePicUrl,
    required String userId}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      final borrowRequestData = {
        'title': title,
        'body': body,
        'imageUrl': imageUrl,
        'username': username,
        'profilePicUrl': profilePicUrl,
        'userId': userId,
      };

      await FirebaseFirestore.instance
          .collection('Borrow_Requests')
          .add(borrowRequestData);
      print('borrow request successful');
    } catch (e) {
      print('Error posting borrow request: $e');
    }
  }
}

Future<int> getLendRequestCount() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    // User not authenticated
    return 0;
  }

  try {
    QuerySnapshot lendRequests = await FirebaseFirestore.instance
        .collection('Lend_Requests')
        .where('userId', isEqualTo: user.uid)
        .get();

    return lendRequests.size;
  } catch (e) {
    print('Error getting lend requests: $e');
    return 0;
  }
}

Future<int> getBorrowRequestCount() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    // User not authenticated
    return 0;
  }

  try {
    QuerySnapshot borrowRequests = await FirebaseFirestore.instance
        .collection('Borrow_Requests')
        .where('userId', isEqualTo: user.uid)
        .get();

    return borrowRequests.size;
  } catch (e) {
    print('Error getting borrow requests: $e');
    return 0;
  }
}