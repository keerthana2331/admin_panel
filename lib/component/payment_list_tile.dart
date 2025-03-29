// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class PaymentListTile extends StatelessWidget {
  final String icon;
  final String label;
  final String amount;
  final String status;
  final Color? statusColor;

  const PaymentListTile({
    Key? key,
    required this.icon,
    required this.label,
    required this.amount,
    this.status = 'Successfully',
    this.statusColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PaymentTileProvider(),
      child: Consumer<PaymentTileProvider>(
        builder: (context, provider, child) {
          return GestureDetector(
            onTapDown: (_) => provider.setTapState(true),
            onTapUp: (_) => provider.setTapState(false),
            onTapCancel: () => provider.setTapState(false),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: 0.0,
                end: provider.isTapped ? 1.0 : 0.0,
              ),
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: 1.0 - (value * 0.02),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.1 * value),
                          blurRadius: 20,
                          offset: const Offset(0, 2),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.lerp(
                                  Colors.white.withOpacity(0.2),
                                  Colors.blue.shade500,
                                  value * 0.7,
                                )!,
                                Color.lerp(
                                  Colors.white.withOpacity(0.1),
                                  Colors.deepPurple.shade700,
                                  value * 0.8,
                                )!,
                              ],
                              stops: const [0.3, 1.0],
                            ),
                            border: Border.all(
                              color: Color.lerp(
                                Colors.white.withOpacity(0.3),
                                Colors.deepPurple.withOpacity(0.5),
                                value,
                              )!,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(22),
                          ),
child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,  
  children: [
  
    AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 56,
      height: 56,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.lerp(
              Colors.white.withOpacity(0.95),
              Colors.deepPurple.shade100,
              value,
            )!,
            Color.lerp(
              Colors.white,
              Colors.deepPurple.shade200,
              value,
            )!,
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05 + (0.05 * value)),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SvgPicture.asset(
        icon,
        width: 24,
        colorFilter: ColorFilter.mode(
          Color.lerp(
            Colors.deepPurple,
            Colors.deepPurple.shade800,
            value,
          )!,
          BlendMode.srcIn,
        ),
      ),
    ),
    const SizedBox(width: 16),

  
    Expanded(  
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,  
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
              color: Color.lerp(
                Colors.white.withOpacity(0.95),
                Colors.white,
                value,
              ),
            ),
          ),
          const SizedBox(height: 6),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Color.lerp(
                statusColor ?? Colors.green.withOpacity(0.2),
                statusColor?.withOpacity(0.4) ?? Colors.green.withOpacity(0.4),
                value,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: value > 0.5
                  ? [
                      BoxShadow(
                        color: (statusColor ?? Colors.green).withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ]
                  : [],
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color.lerp(
                  Colors.white.withOpacity(0.9),
                  Colors.white,
                  value,
                ),
              ),
            ),
          ),
        ],
      ),
    ),

    
    Flexible(
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 300),
        style: TextStyle(
          fontSize: 17 + (value * 1),
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
          color: Color.lerp(Colors.white, Colors.white, value)!,
          shadows: value > 0.5
              ? [
                  Shadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ]
              : [],
        ),
        child: Text(
          amount,
          overflow: TextOverflow.ellipsis,  
        ),
      ),
    ),
  ],
),

                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class PaymentTileProvider extends ChangeNotifier {
  bool _isTapped = false;

  bool get isTapped => _isTapped;

  void toggleTap() {
    _isTapped = !_isTapped;
    notifyListeners();
  }

  void setTapState(bool state) {
    _isTapped = state;
    notifyListeners();
  }
}
