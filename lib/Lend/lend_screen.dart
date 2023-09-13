import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:postman/Lend/lend_request_card.dart';
import 'package:postman/bottom_nav_bar.dart';
import 'package:postman/hamburger_menu.dart';
import 'package:postman/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../Borrow/borrow_request_card.dart';
import '../Borrow/borrow_screen.dart';
import '../Post/post_screen.dart';
import '../model_classes.dart';

class LendScreen extends StatefulWidget {
  const LendScreen({Key? key}) : super(key: key);

  @override
  State<LendScreen> createState() => _LendScreenState();
}

class _LendScreenState extends State<LendScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          drawer: HamMenu(),
          appBar: AppBar(
            backgroundColor: const Color(0xFF144272),
            title:  Text("Lend Requests",style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: Colors.white),),
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white,),
                  onPressed: () {Scaffold.of(context).openDrawer();  },
                );
              }
            ),
            actions: <Widget>[
              IconButton(onPressed: (){}, icon: SvgPicture.asset('assets/chats.svg')),
            ],
          ),
          body: Container(
            color: const Color(0xFF0A2647),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Borrow_Requests')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
                  return const Text('No Lend Requests available.');
                }

                final lendRequests = snapshot.data.docs.map((doc) {
                  return BorrowRequestCard(
                    imageUrl: doc['imageUrl'],
                    username: doc['username'],
                    title: doc['title'],
                    body: doc['body'],
                    profilePicUrl: doc['profilePicUrl'],

                  );
                }).toList();
                return ListView.builder(
                  itemCount: lendRequests.length,
                  itemBuilder: (BuildContext context, int index) {
                    return lendRequests[index];
                  },
                );
              },
            ),
          ),
          bottomNavigationBar: BottomNavBar(currentIndex: 0, onTap: (index) {
            if (index == 1) {
              // Navigate to PostScreen
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => PostScreen()),
              );
            } else if (index == 2) {
              // Navigate to BorrowScreen
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => BorrowScreen()),
              );
            }
          }),
        );
      }),
    );
  }
}
