import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/responsive.dart';
import '../style/colors.dart';

class Header extends StatelessWidget {
  const Header({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.01),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeaderText(),
          Spacer(flex: 1),
          Expanded(
            flex: Responsive.isDesktop(context) ? 1 : 3,
            child: _buildSearchField(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderText() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withOpacity(0.08),
            Colors.purple.withOpacity(0.03),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback:
                (bounds) => LinearGradient(
                  colors: [
                    Color(0xFF4A6FFF),
                    Color(0xFF5E54FA),
                    Color(0xFF9747FF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
            child: Text(
              'Admin Panel',
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Container(
                height: 16,
                width: 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF4A6FFF), Color(0xFF9747FF)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Payments updates',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 6),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            blurRadius: 0,
            offset: Offset(0, 0),
            spreadRadius: 1,
          ),
        ],
      ),
      child: TextField(
        style: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.black.withOpacity(0.8),
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          contentPadding: EdgeInsets.only(
            left: 40.0,
            right: 15,
            top: 15,
            bottom: 15,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.4),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Color(0xFF4A6FFF).withOpacity(0.5),
              width: 1.5,
            ),
          ),
          prefixIcon: Container(
            padding: EdgeInsets.all(12),
            child: ShaderMask(
              shaderCallback:
                  (bounds) => LinearGradient(
                    colors: [Color(0xFF4A6FFF), Color(0xFF9747FF)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds),
              child: Icon(Icons.search, color: Colors.white),
            ),
          ),
          hintText: 'Search dashboard',
          hintStyle: GoogleFonts.inter(
            color: AppColors.secondary.withOpacity(0.6),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF1F5FF), Color(0xFFE4E9F7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              Icons.tune,
              color: Color(0xFF4A6FFF).withOpacity(0.7),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
