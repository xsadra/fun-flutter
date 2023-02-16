import 'package:rive/rive.dart';

import '../constants.dart';

class RiveAsset {
  RiveAsset({
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    required this.src,
    this.input,
  });

  final String artboard;
  final String stateMachineName;
  final String title;
  final String src;
  late SMIBool? input;

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavAssets = [
  RiveAsset(
    artboard: 'CHAT',
    stateMachineName: 'CHAT_Interactivity',
    title: 'Chat',
    src: Assets.iconsRive,
  ),
  RiveAsset(
    artboard: 'SEARCH',
    stateMachineName: 'SEARCH_Interactivity',
    title: 'Search',
    src: Assets.iconsRive,
  ),
  RiveAsset(
    artboard: 'TIMER',
    stateMachineName: 'TIMER_Interactivity',
    title: 'Timer',
    src: Assets.iconsRive,
  ),
  RiveAsset(
    artboard: 'BELL',
    stateMachineName: 'BELL_Interactivity',
    title: 'Bell',
    src: Assets.iconsRive,
  ),
  RiveAsset(
    artboard: 'USER',
    stateMachineName: 'USER_Interactivity',
    title: 'User',
    src: Assets.iconsRive,
  ),
];

List<RiveAsset> sideMenus = [
  RiveAsset(
    artboard: 'HOME',
    stateMachineName: 'HOME_interactivity',
    title: 'Home',
    src: Assets.iconsRive,
  ),
  RiveAsset(
    artboard: 'SEARCH',
    stateMachineName: 'SEARCH_Interactivity',
    title: 'Search',
    src: Assets.iconsRive,
  ),
  RiveAsset(
    artboard: 'LIKE/STAR',
    stateMachineName: 'STAR_Interactivity',
    title: 'Favorites',
    src: Assets.iconsRive,
  ),
  RiveAsset(
    artboard: 'CHAT',
    stateMachineName: 'CHAT_Interactivity',
    title: 'Help',
    src: Assets.iconsRive,
  ),
];