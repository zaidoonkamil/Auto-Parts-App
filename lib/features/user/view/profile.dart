import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:auto_parts_app/core/%20navigation/navigation.dart';
import 'package:auto_parts_app/core/localization/locale_cubit.dart';
import 'package:auto_parts_app/core/localization/localization_extension.dart';
import 'package:auto_parts_app/core/widgets/show_toast.dart';
import 'package:auto_parts_app/features/user/view/favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/styles/themes.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/circular_progress.dart';
import '../../../core/widgets/constant.dart';
import '../../auth/view/login.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit()..getProfile(context: context),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = UserCubit.get(context);
          final bool isLoggedIn = token != '';
          final bool isAdmin = adminOrUser == 'admin';

          return SafeArea(
            child: Scaffold(
              backgroundColor: pageBackgroundColor,
              body: Column(
                children: [
                  isAdmin ? CustomAppBarAdmin() : CustomAppBar(),
                  Expanded(
                    child: ConditionalBuilder(
                      condition: true,
                      builder: (context) => SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
                        child: Column(
                          children: [
                            if (isLoggedIn)
                              cubit.profileModel != null
                                  ? _ProfileHeader(cubit: cubit)
                                  : const CircularProgress()
                            else
                              const _GuestHeader(),
                            const SizedBox(height: 10),
                            _SocialCard(
                              title: context.l10n.whatsapp,
                              subtitle: context.l10n.whatsappSubtitle,
                              icon: FontAwesomeIcons.whatsapp,
                              onTap: () async {
                                final whatsappUri = Uri.parse('https://wa.me/9647503553636');
                                final opened = await launchUrl(
                                  whatsappUri,
                                  mode: LaunchMode.externalApplication,
                                );
                                if (!opened && context.mounted) {
                                  showToastError(
                                    text: context.l10n.unableToOpenLink,
                                    context: context,
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            const _LanguageTile(),
                            if (!isAdmin) ...[
                              const SizedBox(height: 10),
                              _ActionTile(
                                title: context.l10n.favorites,
                                subtitle: context.l10n.favoritesSubtitle,
                                icon: Icons.favorite_border_rounded,
                                onTap: () {
                                  if (isLoggedIn) {
                                    navigateTo(context, Favorites());
                                  } else {
                                    showToastInfo(
                                      text: context.l10n.loginRequiredFirst,
                                      context: context,
                                    );
                                  }
                                },
                              ),
                            ],
                            const SizedBox(height: 10),
                            if (isLoggedIn)
                              _ActionTile(
                                title: context.l10n.logout,
                                subtitle: context.l10n.logoutSubtitle,
                                icon: Icons.logout_rounded,
                                iconColor: accentColor,
                                onTap: () {
                                  signOut(context);
                                },
                              )
                            else
                              const _PrimaryLoginButton(),
                            if (isLoggedIn && !isAdmin) ...[
                              const SizedBox(height: 12),
                              _ActionTile(
                                title: context.l10n.deleteAccount,
                                subtitle: context.l10n.deleteAccountSubtitle,
                                icon: Icons.delete_outline_rounded,
                                iconColor: Colors.redAccent,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.warning_rounded,
                                                size: 60,
                                                color: Colors.redAccent,
                                              ),
                                              Text(
                                                context.l10n.deleteAccountTitle,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                context.l10n.deleteAccountMessage,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black87,
                                                  height: 1.4,
                                                ),
                                              ),
                                              const SizedBox(height: 25),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(dialogContext);
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.grey.shade300,
                                                        foregroundColor: Colors.black,
                                                        padding:
                                                            const EdgeInsets.symmetric(vertical: 12),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                      ),
                                                      child: Text(context.l10n.cancel),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        cubit.deleteAccount(context: context);
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.redAccent,
                                                        foregroundColor: Colors.white,
                                                        padding:
                                                            const EdgeInsets.symmetric(vertical: 12),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                      ),
                                                      child: Text(context.l10n.deletePermanently),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                            const SizedBox(height: 120),
                          ],
                        ),
                      ),
                      fallback: (context) => const Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: CircularProgress(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.cubit});

  final UserCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF131C25), Color(0xFF253444)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  cubit.profileModel!.name,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  cubit.profileModel!.phone,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.72),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.10),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.10)),
            ),
            child: const Icon(Icons.person_rounded, color: Colors.white, size: 34),
          ),
        ],
      ),
    );
  }
}

class _GuestHeader extends StatelessWidget {
  const _GuestHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            context.l10n.welcomeGuest,
            style: const TextStyle(
              color: secondPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.welcomeGuestSubtitle,
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: secondTextColor,
              fontSize: 13,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialCard extends StatelessWidget {
  const _SocialCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _ActionTile(
      title: title,
      subtitle: subtitle,
      icon: icon,
      onTap: onTap,
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile();

  @override
  Widget build(BuildContext context) {
    final localeCubit = context.read<LocaleCubit>();
    final currentCode = context.watch<LocaleCubit>().state.languageCode;

    return _ActionTile(
      title: context.l10n.language,
      subtitle: context.l10n.languageSubtitle,
      icon: Icons.language_rounded,
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (sheetContext) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      context.l10n.chooseLanguage,
                      style: const TextStyle(
                        color: secondPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _LanguageOptionTile(
                      label: context.l10n.languageArabic,
                      selected: currentCode == 'ar',
                      onTap: () async {
                        await localeCubit.changeLocale('ar');
                        if (sheetContext.mounted) {
                          Navigator.pop(sheetContext);
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    _LanguageOptionTile(
                      label: context.l10n.languageKurdish,
                      selected: currentCode == 'ckb',
                      onTap: () async {
                        await localeCubit.changeLocale('ckb');
                        if (sheetContext.mounted) {
                          Navigator.pop(sheetContext);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? mutedSurfaceColor : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: selected ? primaryColor : borderColor),
        ),
        child: Row(
          children: [
            if (selected)
              const Icon(Icons.check_circle_rounded, color: primaryColor)
            else
              const Icon(Icons.circle_outlined, color: secondTextColor),
            const Spacer(),
            Text(
              label,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: secondPrimaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.iconColor = primaryColor,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: secondPrimaryColor.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: secondPrimaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: secondTextColor,
                      fontSize: 10,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: mutedSurfaceColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrimaryLoginButton extends StatelessWidget {
  const _PrimaryLoginButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(context, Login());
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF18222D), Color(0xFF243446)],
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Text(
            context.l10n.login,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
