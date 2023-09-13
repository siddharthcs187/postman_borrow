import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LendRequest {
  final String id; // Unique identifier for the request
  final String userId; // ID of the user who posted the request
  final String username; // Name of the user who posted the request
  final String profilePicUrl; // URL to user's profile picture
  final String imageUrl;
  final String title; // Title of the request
  final String body; // Additional details about the request
  bool isSaved; // Flag to indicate whether the request is saved

  LendRequest( {
    required this.imageUrl,
    required this.id,
    required this.userId,
    required this.username,
    required this.profilePicUrl,
    required this.title,
    required this.body,
    this.isSaved = false, // Default to false when a request is not saved
  });
}


class BorrowRequest {
  final String id; // Unique identifier for the request
  final String userId; // ID of the user who posted the request
  final String username; // Name of the user who posted the request
  final String profilePicUrl; // URL to user's profile picture
  final String title; // Title of the request
  final String description; // Main description of the request
  final String body; // Additional details about the request
  final String imageUrl; // URL to the image associated with the request
  final String saleOrRent; // "Sale" or "Rent" option
  bool isSaved; // Flag to indicate whether the request is saved

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
    this.isSaved = false, // Default to false when a request is not saved
  });
}


Future<String?> uploadImage(File imageFile, String userId) async {
  try {
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('user_images')
        .child(userId + '.jpg'); // You can customize the path and file name as needed
    await storageReference.putFile(imageFile);
    final String imageUrl = await storageReference.getDownloadURL();
    return imageUrl;
  } catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}

Future<void> postLendRequest({
  required String title,
  required String body,
  required String imageUrl,
  required String rentOrSell,
  required String username,
  required String profilePicUrl,
  required String userId
}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      final lendRequestData = {
        'title': title,
        'body': body,
        'imageUrl': imageUrl,
        'rentOrSell': rentOrSell,
        'username': username,
        'profilePicUrl': profilePicUrl,
        'userId': userId,
        // You can add other fields as needed
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
Future<void> postBorrowRequest({
  required String title,
  required String body,
  required String imageUrl,
  required String username,
  required String profilePicUrl,
  required String userId
}) async {
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
        // You can add other fields as needed
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