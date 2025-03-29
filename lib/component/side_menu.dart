// ignore_for_file: deprecated_member_use

import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../provider/side_menu_provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final size = MediaQuery.of(context).size;

    final List<Map<String, dynamic>> menuItems = [
      {
        "icon": "assets/home.svg",
        "label": "Home",
        "gradient": [Color(0xFF6C63FF), Color(0xFF5A56E9)],
        "icon2": Icons.rocket_launch,
      },
      {
        "icon": "assets/pie-chart.svg",
        "label": "Analytics",
        "gradient": [Color(0xFF00F5A0), Color(0xFF00D9F5)],
        "icon2": Icons.insights,
      },
      {
        "icon": "assets/clipboard.svg",
        "label": "Reports",
        "gradient": [Color(0xFFFD8489), Color(0xFFF1A7F1)],
        "icon2": Icons.assessment,
      },
      {
        "icon": "assets/credit-card.svg",
        "label": "Payments",
        "gradient": [Color(0xFFFFB347), Color(0xFFFFCC33)],
        "icon2": Icons.payments_outlined,
      },
      {
        "icon": "assets/trophy.svg",
        "label": "Achievements",
        "gradient": [Color(0xFFFF6CAB), Color(0xFFFF9BCC)],
        "icon2": Icons.emoji_events,
      },
      {
        "icon": "assets/invoice.svg",
        "label": "Invoices",
        "gradient": [Color(0xFF985EFF), Color(0xFFBB8DFF)],
        "icon2": Icons.receipt_long,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(color: Colors.transparent),
            ),

            Container(
              width: size.width * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF191B3A),
                    Color(0xFF131735),
                    Color(0xFF0A0F2E),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: -5,
                    offset: Offset(10, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildProfileHeader(context),

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white,
                              Colors.white,
                              Colors.white.withOpacity(0.1),
                            ],
                            stops: [0.0, 0.9, 1.0],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.dstIn,
                        child: ListView.builder(
                          itemCount: menuItems.length,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.only(top: 15, bottom: 100),
                          itemExtent: 75,
                          itemBuilder: (context, index) {
                            bool isSelected =
                                index == menuProvider.selectedIndex;
                            return UltraMenuButton(
                              icon: menuItems[index]["icon"]!,
                              iconData: menuItems[index]["icon2"],
                              label: menuItems[index]["label"]!,
                              isSelected: isSelected,
                              gradient: menuItems[index]["gradient"],
                              onPressed: () {
                                HapticFeedback.lightImpact();
                                menuProvider.setSelectedIndex(index);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  _buildFooter(),
                ],
              ),
            ),

            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              right: 0,
              top: 150 + (menuProvider.selectedIndex * 75),
              child: ActiveIndicator(
                gradient: menuItems[menuProvider.selectedIndex]["gradient"],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 25, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF6C63FF), Color(0xFF00F5A0)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF6C63FF).withOpacity(0.6),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),

                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/woman.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF30D158),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Keerthana",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 4),
                    GlassContainer(
                      width: 100,
                      height: 24,
                      borderRadius: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 4),
                          Text(
                            "Premium",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          GlassContainer(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Wrap(
              spacing: 16,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _buildStat("Total Invoices", "125"),
                _buildVerticalDivider(),
                _buildStat("Pending Payments", "\$1,650"),
                _buildVerticalDivider(),
                _buildStat("Completed Payments", "\$4,830"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 25,
      width: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.3),
            Colors.white.withOpacity(0.1),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          GlassContainer(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF6C63FF).withOpacity(0.8),
                        Color(0xFFFF6CAB).withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: Icon(
                    Icons.diamond_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upgrade to Pro",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Get exclusive features",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFooterButton(Icons.settings, "Settings"),
              _buildFooterButton(Icons.headset_mic, "Support"),
              _buildFooterButton(Icons.logout, "Logout"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButton(IconData icon, String label) {
    return GlassContainer(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 16),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = 14,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.15),
                Colors.white.withOpacity(0.05),
              ],
            ),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          ),
          child: child,
        ),
      ),
    );
  }
}

class UltraMenuButton extends StatefulWidget {
  final String icon;
  final IconData iconData;
  final String label;
  final bool isSelected;
  final List<Color> gradient;
  final VoidCallback onPressed;

  const UltraMenuButton({
    super.key,
    required this.icon,
    required this.iconData,
    required this.label,
    required this.isSelected,
    required this.gradient,
    required this.onPressed,
  });

  @override
  State<UltraMenuButton> createState() => _UltraMenuButtonState();
}

class _UltraMenuButtonState extends State<UltraMenuButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _rotateAnimation = Tween<double>(
      begin: 0,
      end: 0.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: widget.isSelected ? 0 : 8,
      ),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutQuint,
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onPressed();
        },
        onTapCancel: () => _controller.reverse(),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.rotate(
                angle: _rotateAnimation.value * (math.pi / 180),
                child: child,
              ),
            );
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeOutQuint,
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient:
                  widget.isSelected
                      ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: widget.gradient,
                      )
                      : null,
              color: widget.isSelected ? null : Colors.white.withOpacity(0.05),
              boxShadow:
                  widget.isSelected
                      ? [
                        BoxShadow(
                          color: widget.gradient[0].withOpacity(0.6),
                          blurRadius: 15,
                          spreadRadius: -5,
                          offset: Offset(2, 2),
                        ),
                      ]
                      : null,
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color:
                        widget.isSelected
                            ? Colors.white.withOpacity(0.2)
                            : Colors.white.withOpacity(0.05),
                    boxShadow:
                        widget.isSelected
                            ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                spreadRadius: -3,
                                offset: Offset(2, 2),
                              ),
                            ]
                            : null,
                  ),
                  child:
                      widget.isSelected
                          ? Icon(widget.iconData, color: Colors.white, size: 20)
                          : SvgPicture.asset(
                            widget.icon,
                            colorFilter: ColorFilter.mode(
                              Colors.white.withOpacity(0.7),
                              BlendMode.srcIn,
                            ),
                            width: 20,
                            height: 20,
                          ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.label,
                      style: TextStyle(
                        color:
                            widget.isSelected
                                ? Colors.white
                                : Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        fontWeight:
                            widget.isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(height: 3),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: widget.isSelected ? 20 : 0,
                      height: 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                AnimatedOpacity(
                  opacity: widget.isSelected ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 300),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ActiveIndicator extends StatelessWidget {
  final List<Color> gradient;

  const ActiveIndicator({super.key, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(2),
          bottomLeft: Radius.circular(2),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradient,
        ),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withOpacity(0.6),
            blurRadius: 8,
            spreadRadius: -2,
            offset: Offset(-2, 0),
          ),
        ],
      ),
    );
  }
}
