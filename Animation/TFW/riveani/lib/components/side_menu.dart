import 'package:arive/models/rive_asset.dart';
import 'package:arive/utils/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'info_card.dart';
import 'side_menu_tile.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset _activeMenu = sideMenus.first;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: const Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoCard(name: "Sadra Babai", role: "Developer"),
              const SideMenuCaptionWidget(caption: 'Browse'),
              ...sideMenus.map(
                (e) => SideMenuTile(
                  menu: e,
                  onInit: (artboard) {
                    StateMachineController controller = RiveUtils.getController(
                      artboard,
                      stateMachineName: e.stateMachineName,
                    );
                    e.input = controller.findSMI('active') as SMIBool;
                  },
                  onTap: () {
                    e.input!.change(true);
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      e.input!.change(false);
                    });
                    setState(() {
                      _activeMenu = e;
                    });
                  },
                  isActive: _activeMenu == e,
                ),
              ),
              const SideMenuCaptionWidget(caption: 'History'),
              ...sideMenusHistory.map(
                    (e) => SideMenuTile(
                  menu: e,
                  onInit: (artboard) {
                    StateMachineController controller = RiveUtils.getController(
                      artboard,
                      stateMachineName: e.stateMachineName,
                    );
                    e.input = controller.findSMI('active') as SMIBool;
                  },
                  onTap: () {
                    e.input!.change(true);
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      e.input!.change(false);
                    });
                    setState(() {
                      _activeMenu = e;
                    });
                  },
                  isActive: _activeMenu == e,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SideMenuCaptionWidget extends StatelessWidget {
  const SideMenuCaptionWidget({
    super.key,
    required this.caption,
  });

  final String caption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
      child: Text(
        caption.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.white70),
      ),
    );
  }
}
