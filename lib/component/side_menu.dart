import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../config/size_config.dart';
import '../provider/menu_provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);

    return Drawer(
      elevation: 4,
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0D0F1A), Color(0xFF181A2E), Color(0xFF212840)],
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black87.withOpacity(0.6),
              blurRadius: 12,
              offset: Offset(3, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 140,
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF1C1E30), Color(0xFF282C42)],
                ),
                borderRadius: BorderRadius.only(topRight: Radius.circular(16)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 25,
                    child: SvgPicture.asset(
                      'assets/mac-action.svg',
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            ..._buildCompactMenuItems(menuProvider),

            Spacer(),

            Container(
              margin: EdgeInsets.only(bottom: 24),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF24273E), Color(0xFF1D2035)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.person_outline,
                  size: 20,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCompactMenuItems(MenuProvider menuProvider) {
    final menuItems = [
      {'icon': 'assets/home.svg', 'label': 'Dashboard', 'index': 0},
      {
        'icon': 'assets/pie-chart.svg',
        'label': 'Analytics & Reports',
        'index': 1,
      },
      {'icon': 'assets/clipboard.svg', 'label': 'Task Manager', 'index': 2},
      {
        'icon': 'assets/credit-card.svg',
        'label': 'Payments & Billing',
        'index': 3,
      },
      {
        'icon': 'assets/trophy.svg',
        'label': 'Achievements & Rewards',
        'index': 4,
      },
      {
        'icon': 'assets/invoice.svg',
        'label': 'Invoices & Transactions',
        'index': 5,
      },
    ];

    return menuItems.map((item) {
      final index = item['index'] as int;
      final isActive = menuProvider.selectedIndex == index;

      return GestureDetector(
        onTap: () => menuProvider.setSelectedIndex(index),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Stack(
            children: [
              if (isActive)
                Positioned(
                  left: 0,
                  top: 6,
                  bottom: 6,
                  child: Container(
                    width: 4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.blue.shade400, Colors.blue.shade600],
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                  ),
                ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient:
                      isActive
                          ? LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.blue.withOpacity(0.2),
                              Colors.transparent,
                            ],
                          )
                          : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(12),
                child: Center(
                  child: SvgPicture.asset(
                    item['icon'] as String,
                    width: 22,
                    height: 22,
                    color: isActive ? Colors.blue.shade300 : Colors.white60,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
