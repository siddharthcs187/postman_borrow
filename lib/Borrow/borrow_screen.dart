import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:postman/Lend/lend_screen.dart';
import 'package:postman/hamburger_menu.dart';
import 'package:provider/provider.dart';

import '../Lend/lend_request_card.dart';
import '../Post/post_screen.dart';
import '../bottom_nav_bar.dart';
import '../provider/google_sign_in.dart';
import 'borrow_request_card.dart';

class BorrowScreen extends StatefulWidget {
  const BorrowScreen({Key? key}) : super(key: key);

  @override
  State<BorrowScreen> createState() => _BorrowScreenState();
}

class _BorrowScreenState extends State<BorrowScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          drawer: HamMenu(),
          appBar: AppBar(
            title:  Text("Borrow Requests",style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: Colors.white),),
            backgroundColor: const Color(0xFF144272),
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white,),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
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
                  .collection('Lend_Requests')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
                  return const Text('No Borrow Requests available.');
                }

                final borrowRequests = snapshot.data.docs.map((doc) {
                  return LendRequestCard(
                    imageUrl: doc['imageUrl'],
                    username: doc['username'],
                    title: doc['title'],
                    body: doc['body'],
                    profilePicUrl: doc['profilePicUrl'], rentOrSell: doc['rentOrSell'],

                  );
                }).toList();
                return ListView.builder(
                  itemCount: borrowRequests.length,
                  itemBuilder: (BuildContext context, int index) {
                    return borrowRequests[index];
                  },
                );
              },
            ),
          ),
          bottomNavigationBar: BottomNavBar(currentIndex: 2, onTap: (index) {
            if (index == 1) {
              // Navigate to PostScreen
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => PostScreen()),
              );
            } else if (index == 0) {
              // Navigate to BorrowScreen
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => LendScreen()),
              );
            } }),
        );
      }),
    );
  }
}
