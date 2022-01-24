import 'package:fennec_desktop/pages/menu/certificates/certificates_screen.dart';
import 'package:fennec_desktop/pages/menu/ead/ead_screen.dart';
import 'package:fennec_desktop/pages/menu/feed/feed_screen.dart';
import 'package:fennec_desktop/pages/menu/profile/profile_screen.dart';
import 'package:fennec_desktop/pages/menu/team/team_menu_screen.dart';
import 'package:fennec_desktop/pages/menu/wrokspace/workspace_screen.dart';
import 'package:flutter/material.dart';

class SidebarButtons {
  final IconData icon;
  final String title;
  final Widget? content;

  SidebarButtons({required this.icon, required this.title, this.content});
}

final sidebarButtons = [
  SidebarButtons(
    icon: Icons.person,
    title: 'Perfil',
    content: const ProfileScreen(),
  ),
  SidebarButtons(
    icon: Icons.groups,
    title: 'Time',
    content: const TeamMenuScreen(),
  ),
  SidebarButtons(
    icon: Icons.workspaces,
    title: 'Workspace',
    content: const WorkspaceScreen(),
  ),
  SidebarButtons(
    icon: Icons.feed,
    title: 'Feed',
    content: const FeedScreen(),
  ),
  SidebarButtons(
    icon: Icons.computer,
    title: 'EAD',
    content: const EadScreen(),
  ),
  SidebarButtons(
    icon: Icons.star,
    title: 'Certificados',
    content: const CertificatesScreen(),
  ),
  SidebarButtons(icon: Icons.logout, title: 'Sair'),
];
