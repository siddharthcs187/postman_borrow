import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:postman/provider/google_sign_in.dart';
import 'package:postman/signinpage.dart';
import 'package:provider/provider.dart';
class HamMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final username = user?.displayName ?? 'User'; // Use a default value if the username is not available
    final profilePicUrl = user?.photoURL ?? ''; // Use an empty string if the URL is not available

    return Drawer(
      backgroundColor: const Color(0xFF144272),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Padding(
               padding: const EdgeInsets.fromLTRB(8.0,30,0,0),
               child: Text(
                'Hi,',
                style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 25.0),
            ),
             ),Padding(
              padding: const EdgeInsets.fromLTRB(8.0,0,0,0),
              child: Text(
                '$username!',
                style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25.0),
              ),
            ),
                Center(
                    child: CircleAvatar(
                     radius: 50,
              backgroundImage: NetworkImage(profilePicUrl), // Use the user's profile picture URL
            ),

                ),],
          ),
          ListTile(
            leading: SvgPicture.asset('assets/myposts.svg', color: Colors.white,),
            title: Text('My Posts', style: GoogleFonts.poppins(color: Colors.white),),
            onTap: () {
              // Navigate to the My Posts screen
              Navigator.pop(context); // Close the drawer
              // Implement navigation to My Posts screen
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark, color: Colors.white,),
            title: Text('Bookmarked Posts', style: GoogleFonts.poppins(color: Colors.white),),
            onTap: () {
              // Navigate to the Bookmarked Posts screen
              Navigator.pop(context); // Close the drawer
              // Implement navigation to Bookmarked Posts screen
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.white,),
            title: Text('Settings', style: GoogleFonts.poppins(color: Colors.white),),
            onTap: () {
              // Navigate to the Settings screen
              Navigator.pop(context); // Close the drawer
              // Implement navigation to Settings screen
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/feedback.svg', color: Colors.white,),
            title: Text('Feedback', style: GoogleFonts.poppins(color: Colors.white),),
            onTap: () {
              // Navigate to the Feedback screen
              Navigator.pop(context); // Close the drawer
              // Implement navigation to Feedback screen
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/donate.svg', color: Colors.white,),
            title: Text('Donate', style: GoogleFonts.poppins(color: Colors.white),),
            onTap: () {
              // Navigate to the Donate screen
              Navigator.pop(context); // Close the drawer
              // Implement navigation to Donate screen
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/developers.svg', color: Colors.white,),
            title: Text('Developers', style: GoogleFonts.poppins(color: Colors.white),),
            onTap: () {
              // Navigate to the Developers screen
              Navigator.pop(context); // Close the drawer
              // Implement navigation to Developers screen
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.white,),
            title: Text('Sign Out', style: GoogleFonts.poppins(color: Colors.white),),
            onTap: () async{
              // Implement sign-out logic
              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              await provider.GoogleLogout();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SignInPage(), // Replace with your sign-in screen widget
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
      ),    );
  }
}
