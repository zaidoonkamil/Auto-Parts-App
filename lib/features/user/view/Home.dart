import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:auto_parts_app/core/%20navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../core/localization/localization_extension.dart';
import '../../../core/network/remote/dio_helper.dart';
import '../../../core/styles/themes.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/circular_progress.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../model/CatModel.dart';
import '../model/GetAdsModel.dart';
import 'ads.dart';
import 'all_categories.dart';
import 'all_products.dart';
import 'search_products.dart';
import 'subcategories.dart';
import 'widgets/product_grid_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static int currentIndex = 0;

  void showSuccessSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: context.l10n.operationCompleted,
        message: message,
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit()
        ..getGreeting()
        ..getAds(context: context)
        ..getCat(context: context)
        ..scrol()
        ..getFeaturedProducts(context: context, page: '1', limit: 8),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is AddToBasketSuccessState) {
            showSuccessSnackBar(context, context.l10n.productAddedToBasketSuccess);
          }
        },
        builder: (context, state) {
          final cubit = UserCubit.get(context);
          final localeCode = Localizations.localeOf(context).languageCode;

          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  const CustomAppBar(),
                  Expanded(
                    child: cubit.getCatModel.isEmpty
                        ? CircularProgressHome()
                        : SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                _buildSearchStrip(context)
                                    .animate()
                                    .fadeIn(duration: 280.ms)
                                    .slideY(
                                      begin: 0.22,
                                      end: 0,
                                      duration: 420.ms,
                                      curve: Curves.easeOutCubic,
                                    ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 130),
                                  child: Column(
                                    children: [
                                      _buildHeroAds(context, cubit, localeCode)
                                          .animate()
                                          .fadeIn(delay: 80.ms, duration: 300.ms)
                                          .slideY(
                                            begin: 0.18,
                                            end: 0,
                                            duration: 430.ms,
                                            curve: Curves.easeOutCubic,
                                          ),
                                      const SizedBox(height: 18),
                                      _buildSectionHeader(
                                        title: context.l10n.categoriesTitle,
                                        actionLabel: context.l10n.viewAll,
                                        onTap: () {
                                          navigateTo(
                                            context,
                                            AllCategoriesPage(
                                              categories: List<CatModel>.from(cubit.getCatModel),
                                              useHomeAppBar: false,
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 12),
                                      _buildCategories(cubit, context, localeCode)
                                          .animate()
                                          .fadeIn(delay: 200.ms, duration: 300.ms)
                                          .slideY(
                                            begin: 0.14,
                                            end: 0,
                                            duration: 430.ms,
                                            curve: Curves.easeOutCubic,
                                          ),
                                      const SizedBox(height: 20),
                                      _buildSectionHeader(
                                        title: context.l10n.featuredProductsTitle,
                                        actionLabel: context.l10n.viewAll,
                                        onTap: () {
                                          navigateTo(context, const AllProductsPage());
                                        },
                                      ),
                                      const SizedBox(height: 12),
                                      _buildProducts(cubit, context, localeCode)
                                          .animate()
                                          .fadeIn(delay: 320.ms, duration: 320.ms)
                                          .slideY(
                                            begin: 0.12,
                                            end: 0,
                                            duration: 460.ms,
                                            curve: Curves.easeOutCubic,
                                          ),
                                    ],
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

  Widget _buildSearchStrip(BuildContext context) {
    return Container(
      height: 85,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF131C25), Color(0xFF253444)],
        ),
      ),
      child: GestureDetector(
        onTap: () {
          navigateTo(context, const SearchProductsPage());
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Row(
            children: [
              const Icon(Iconsax.filter, color: Colors.white),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      context.l10n.searchProductsTitle,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.92),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      context.l10n.searchProductsSubtitle,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.60),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Iconsax.search_normal,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroAds(BuildContext context, UserCubit cubit, String localeCode) {
    return ConditionalBuilder(
      condition: cubit.getAdsModel.isNotEmpty,
      builder: (context) {
        return Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: secondPrimaryColor.withValues(alpha: 0.12),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CarouselSlider(
                  items: cubit.getAdsModel
                      .expand<Widget>(
                        (GetAds ad) => ad.images.map(
                          (String imageUrl) {
                            final formattedDate = DateFormat('yyyy/M/d').format(ad.createdAt);
                            final localizedTitle = ad.localizedTitle(localeCode);
                            final localizedDescription = ad.localizedDescription(localeCode);
                            return GestureDetector(
                              onTap: () {
                                navigateTo(
                                  context,
                                  AdsUser(
                                    tittle: localizedTitle,
                                    desc: localizedDescription,
                                    image: imageUrl,
                                    time: formattedDate,
                                  ),
                                );
                              },
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    "$url/uploads/$imageUrl",
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Color(0x22000000),
                                          Color(0xCC111821),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 18,
                                    left: 18,
                                    bottom: 18,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          localizedTitle,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w800,
                                            height: 1.2,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          localizedDescription,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            color: Colors.white.withValues(alpha: 0.78),
                                            fontSize: 12,
                                            height: 1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: 255,
                    viewportFraction: 1,
                    enlargeCenterPage: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 6),
                    onPageChanged: (index, reason) {
                      currentIndex = index;
                      cubit.slid();
                    },
                  ),
                ),
              ),
              Positioned(
                left: 18,
                bottom: 18,
                child: Row(
                  children: List.generate(
                    cubit.getAdsModel.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      margin: const EdgeInsets.only(right: 6),
                      width: currentIndex == index ? 22 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: currentIndex == index
                            ? primaryColor
                            : Colors.white.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      fallback: (context) => const SizedBox.shrink(),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    String? actionLabel,
    VoidCallback? onTap,
  }) {
    return Row(
      children: [
        if (actionLabel != null && onTap != null)
          GestureDetector(
            onTap: onTap,
            child: Text(
              actionLabel,
              style: const TextStyle(
                color: primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
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
                  color: secondPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategories(UserCubit cubit, BuildContext context, String localeCode) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        reverse: true,
        scrollDirection: Axis.horizontal,
        itemCount: cubit.getCatModel.length,
        itemBuilder: (context, i) {
          final rawImageUrl = cubit.getCatModel[i].images[0];
          final cleanImageUrl = rawImageUrl.replaceAll(RegExp(r'[\[\]]'), '');

          return GestureDetector(
            onTap: () => navigateTo(
              context,
              SubCategoriesPage(parentCategory: cubit.getCatModel[i]),
            ),
            child: Container(
              width: 86,
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cardSurfaceColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor),
                boxShadow: [
                  BoxShadow(
                    color: secondPrimaryColor.withValues(alpha: 0.05),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Image.network(
                    "$url/uploads/$cleanImageUrl",
                    fit: BoxFit.cover,
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cubit.getCatModel[i].localizedName(localeCode),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: secondPrimaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
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

  Widget _buildProducts(UserCubit cubit, BuildContext context, String localeCode) {
    if (cubit.products.isEmpty) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cubit.products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.61,
      ),
      itemBuilder: (context, index) {
        final product = cubit.products[index];

        return UserProductGridCard(
          cubit: cubit,
          productId: product.id.toString(),
          sellerId: product.seller.id.toString(),
          title: product.localizedTitle(localeCode),
          description: product.localizedDescription(localeCode),
          price: product.price,
          images: product.images,
          isFavorite: product.isFavorite,
          imageSeller: product.seller.image,
          locationSeller: product.seller.location,
          nameSeller: product.seller.name,
        );
      },
    );
  }
}
