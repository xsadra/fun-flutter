import 'package:arive/models/rive_asset.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SideMenuTile extends StatelessWidget {
  const SideMenuTile({
    super.key,
    required this.menu,
    required this.onTap,
    required this.onInit,
    required this.isActive,
  });

  final RiveAsset menu;
  final VoidCallback onTap;
  final ValueChanged<Artboard> onInit;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(
            color: Colors.white24,
            thickness: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              left: 0,
              height: 56,
              width: isActive? 287 : 0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF6792FF),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            ListTile(
              onTap: onTap,
              leading: SizedBox(
                height: 34,
                width: 34,
                child: RiveAnimation.asset(
                  menu.src,
                  artboard: menu.artboard,
                  onInit: onInit,
                ),
              ),
              title: Text(
                menu.title,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
