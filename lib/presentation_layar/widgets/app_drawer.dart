import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final top = MediaQuery.of(context).padding.top;

    return Drawer(
      backgroundColor: cs.surface,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, top + 20, 20, 20),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [cs.primary, cs.primary.withOpacity(0.75)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
              boxShadow: [
                BoxShadow(
                  color: cs.primary.withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: cs.primary),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Welcome User",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "user@example.com",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _menuItem(context, Icons.account_balance, "Accounts", AppRoutes.accounts),
                _menuItem(context, Icons.swap_horiz, "Transactions", AppRoutes.transactions),
                _menuItem(
                  context,
                  Icons.schedule,
                  "Scheduled Transactions",
                  AppRoutes.scheduled,
                ),
                _menuItem(context, Icons.notifications, "Notifications", AppRoutes.notifications),
                const Divider(height: 30),
                _menuItem(
                  context,
                  Icons.logout,
                  "Logout",
                  AppRoutes.login,
                  color: Colors.red,
                  replaceAll: true,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "Banking App v1.0",
              style: TextStyle(
                color: cs.primary.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _menuItem(
      BuildContext context,
      IconData icon,
      String title,
      String route, {
        Color? color,
        bool replaceAll = false,
      }) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () {
        if (replaceAll) {
          Navigator.pushNamedAndRemoveUntil(context, route, (_) => false);
        } else {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      splashColor: cs.primary.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 22, color: color ?? cs.primary),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: color ?? cs.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
