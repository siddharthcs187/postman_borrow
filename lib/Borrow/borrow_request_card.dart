import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BorrowRequestCard extends StatefulWidget {
  final String imageUrl;
  final String username;
  final String title;
  final String body;
  final String profilePicUrl;

  BorrowRequestCard({
    Key? key,
    required this.imageUrl,
    required this.username,
    required this.title,
    required this.body,
    required this.profilePicUrl,
  }) : super(key: key);

  @override
  _BorrowRequestCardState createState() => _BorrowRequestCardState();
}

class _BorrowRequestCardState extends State<BorrowRequestCard> {
  bool isSaved = false; // Track save button state
  bool showFullText = false; // Track whether to show full text

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFF144272),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(widget.profilePicUrl),
                ),
              ),
              const SizedBox(width: 8.0), Text(
                  widget.username,
                  style: GoogleFonts.poppins(color: Colors.white),
                ),

            ],
          ),
          Stack(
            children: [
              Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                height: 150, // Set the height of the image
                width: double.infinity, // Use full width
              ),
              Positioned(
                top: 16.0,
                left: 16.0,
                right: 16.0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.transparent, // Add a background color
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row( // Added a row to contain the title and "<Required" text
                        children: [
                          Expanded( // Ensure the title takes available space
                            child: Text(
                              widget.title,
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            '<Required',
                            style: GoogleFonts.poppins(
                              color: Color(0xFF5AF5FF),
                              fontWeight: FontWeight.w400
                            )
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      // Show full text if showFullText is true
                      Text(
                        widget.body,
                        maxLines: showFullText ? null : 2, // Display all lines if showFullText is true
                        overflow: showFullText ? null : TextOverflow.ellipsis, // Use ellipsis if not showing full text
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                      // Toggle visibility of text when "Read More" is pressed
                      TextButton(
                        onPressed: () {
                          setState(() {
                            showFullText = !showFullText;
                          });
                        },
                        child: Text(
                          showFullText ? 'Read Less' : 'Read More',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w400
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isSaved = !isSaved; // Toggle save button state
                  });
                },
              ),
              Spacer(), // Add a spacer to push the Send button to the right
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Handle Send button press here
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
