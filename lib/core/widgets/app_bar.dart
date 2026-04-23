import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../features/auth/view/login.dart';
import '../../features/user/view/basket.dart';
import '../../features/user/view/notifications.dart';
import '../../features/user/view/search_products.dart';
import '../ navigation/navigation.dart';
import '../localization/localization_extension.dart';
import 'constant.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF131C25), Color(0xFF253444)],
        ),
      ),
      child: Row(
        children: [
          _ActionCircle(
            icon: FontAwesomeIcons.basketShopping,
            onTap: () {
              token != '' ? navigateTo(context, Basket()) : navigateTo(context, const Login());
            },
          ),
          const SizedBox(width: 40),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'AUTO PARTS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                context.l10n.appBarTagline,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.72),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          _ActionCircle(
            icon: FontAwesomeIcons.solidBell,
            onTap: () {
              token != '' ? navigateTo(context, NotificationsUser()) : navigateTo(context, const Login());
            },
          ),
          _ActionCircle(
            icon: FontAwesomeIcons.search,
            onTap: () {
              navigateTo(
                context,
                const SearchProductsPage(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomAppBarBack extends StatelessWidget {
  const CustomAppBarBack({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF131C25), Color(0xFF253444)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => navigateBack(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.10),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.72),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBarAdmin extends StatelessWidget {
  const CustomAppBarAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF131C25), Color(0xFF253444)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'AUTO PARTS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            context.l10n.appBarTagline,
            style: TextStyle(
              color: Colors.white.withOpacity(0.72),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCircle extends StatelessWidget {
  const _ActionCircle({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _IconButtonShell(icon: icon, onTap: onTap);
  }
}

class _IconButtonShell extends StatelessWidget {
  const _IconButtonShell({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 42,
        height: 42,
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
