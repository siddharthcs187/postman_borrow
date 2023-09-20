import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:postman/provider/google_sign_in.dart';
import 'package:postman/signinpage.dart';
import 'package:provider/provider.dart';

import 'model_classes.dart';

class HamMenu extends StatelessWidget {
  int lendRequestCount = 0;
  int borrowRequestCount = 0;

  Future<void> initializeAsyncData() async {
    lendRequestCount = await getLendRequestCount();
    borrowRequestCount = await getBorrowRequestCount();
  }

  HamMenu() {
    initializeAsyncData();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final username = user?.displayName ?? 'User';
    final profilePicUrl = user?.photoURL ?? '';

    return Drawer(
      backgroundColor: const Color(0xFF144272),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 30, 0, 0),
                child: Text(
                  'Hi,',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 25.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                child: Text(
                  '$username!',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0),
                ),
              ),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profilePicUrl),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('$lendRequestCount देन',style: GoogleFonts.poppins(color: Color(0xFFA74FFF), fontWeight: FontWeight.bold, fontSize: 20),),
              Text('$borrowRequestCount लेन',style: GoogleFonts.poppins(color: Color(0xFFF900FF), fontWeight: FontWeight.bold, fontSize: 20),),
            ],
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/myposts.svg',
              color: Colors.white,
            ),
            title: Text(
              'My Posts',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            title: Text(
              'Bookmarked Posts',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: Text(
              'Settings',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/feedback.svg',
              color: Colors.white,
            ),
            title: Text(
              'Feedback',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/donate.svg',
              color: Colors.white,
            ),
            title: Text(
              'Donate',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/developers.svg',
              color: Colors.white,
            ),
            title: Text(
              'Developers',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            title: Text(
              'Sign Out',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            onTap: () async {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              await provider.GoogleLogout();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SignInPage(),
              ));
            },
          ),
          Center(
            child: Container(
              width: 200.04,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.48,
                    strokeAlign: BorderSide.strokeAlignInside,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
