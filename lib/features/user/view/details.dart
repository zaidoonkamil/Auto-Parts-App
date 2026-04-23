import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:auto_parts_app/core/network/remote/dio_helper.dart';
import 'package:auto_parts_app/core/widgets/app_bar.dart';
import 'package:auto_parts_app/core/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/localization/localization_extension.dart';
import '../../../core/styles/themes.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.id,
    required this.sellerId,
    required this.tittle,
    required this.description,
    required this.price,
    required this.images,
    required this.imageSeller,
    required this.locationSeller,
    required this.nameSeller,
    required this.isFavorite,
  });

  static int currentIndex = 0;

  final String sellerId;
  final String id;
  final String tittle;
  final String description;
  final String price;
  final String imageSeller;
  final String nameSeller;
  final String locationSeller;
  final bool isFavorite;
  final List<String>? images;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit()..isLiked = isFavorite,
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is AddToBasketSuccessState) {
            showSuccessSnackBar(
              context,
              context.l10n.productAddedToBasketSuccess,
            );
          }
        },
        builder: (context, state) {
          final cubit = UserCubit.get(context);
          final int number = int.tryParse(price) ?? 0;
          final bool canOrder = adminOrUser == 'user' || token != '';
          final List<String> safeImages = (images ?? []).where((e) => e.isNotEmpty).toList();

          return SafeArea(
            child: Scaffold(
              backgroundColor: pageBackgroundColor,
              body: Column(
                children: [
                  CustomAppBarBack(
                    title: context.l10n.productDetailsTitle,
                    subtitle: context.l10n.productDetailsSubtitle,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildGallery(cubit, safeImages),
                          const SizedBox(height: 12),
                          _buildHeadline(context, number),
                          token ==''?Container(): const SizedBox(height: 8),
                          token ==''?Container(): _buildActionsCard(context, cubit, canOrder),
                          const SizedBox(height: 8),
                          // _buildDescriptionCard(context),
                          // const SizedBox(height: 8),
                          // _buildSellerCard(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: canOrder
                  ? SafeArea(
                      top: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: GestureDetector(
                          onTap: () {
                            cubit.addToBasket(
                              productId: id,
                              quantity: cubit.quantity.toString(),
                              context: context,
                            );
                          },
                          child: Container(
                            height: 58,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF18222D), Color(0xFF243446)],
                              ),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: secondPrimaryColor.withOpacity(0.18),
                                  blurRadius: 22,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.basketShopping,
                                      size: 18,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    context.l10n.addToBasket,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.10),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    context.l10n.piecesCount(cubit.quantity),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildGallery(UserCubit cubit, List<String> safeImages) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardSurfaceColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Hero(
            tag: 'product-image-$id',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: safeImages.isEmpty
                  ? Container(
                      height: 300,
                      color: Colors.grey.shade200,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        size: 44,
                        color: secondTextColor,
                      ),
                    )
                  : CarouselSlider(
                      items: safeImages.map((entry) {
                        return Image.network(
                          '$url/uploads/$entry',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 1,
                        enlargeCenterPage: false,
                        autoPlay: safeImages.length > 1,
                        autoPlayInterval: const Duration(seconds: 5),
                        onPageChanged: (index, reason) {
                          currentIndex = index;
                          cubit.slid();
                        },
                      ),
                    ),
            ),
          ),
          if (safeImages.length > 1) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: safeImages.asMap().entries.map((entry) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: currentIndex == entry.key ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentIndex == entry.key ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: borderColor),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeadline(BuildContext context, int number) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: secondPrimaryColor.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            tittle,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 18,
              color: secondPrimaryColor,
              fontWeight: FontWeight.w800,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: secondTextColor,
              height: 1.8,
            ),
            textAlign: TextAlign.end,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: mutedSurfaceColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.verified_outlined, size: 17, color: successColor),
                    const SizedBox(width: 6),
                    Text(
                      context.l10n.availableNow,
                      style: const TextStyle(
                        color: secondPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    NumberFormat('#,###').format(number),
                    style: const TextStyle(
                      fontSize: 24,
                      color: primaryColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    context.l10n.iraqiDinar,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 12,
                      color: secondTextColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionsCard(BuildContext context, UserCubit cubit, bool canOrder) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              LikeButton(
                size: 34,
                isLiked: cubit.isLiked,
                likeBuilder: (bool isLiked) {
                  return Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.grey[700],
                    size: 28,
                  );
                },
                onTap: (isLiked) async {
                  cubit.updateFavoritesDetails(idItem: id, context: context);
                  return !isLiked;
                },
              ),
            ],
          ),
          const Spacer(),
          if (canOrder)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: mutedSurfaceColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      cubit.add();
                    },
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      cubit.quantity.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        color: secondPrimaryColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      cubit.minus(context: context);
                    },
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor),
                      ),
                      child: const Icon(Icons.remove, color: secondPrimaryColor, size: 18),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            context.l10n.productDescription,
            style: const TextStyle(
              fontSize: 16,
              color: secondPrimaryColor,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.end,
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: secondTextColor,
              height: 1.8,
            ),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }

  // Widget _buildSellerCard(BuildContext context) {
  //   final String cleanSellerImage = imageSeller.replaceAll(RegExp(r'[\[\]]'), '');
  //
  //   return Container(
  //     padding: const EdgeInsets.all(18),
  //     decoration: BoxDecoration(
  //       gradient: const LinearGradient(
  //         begin: Alignment.topRight,
  //         end: Alignment.bottomLeft,
  //         colors: [Color(0xFF131C25), Color(0xFF253444)],
  //       ),
  //       borderRadius: BorderRadius.circular(24),
  //     ),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             children: [
  //               Text(
  //                 context.l10n.sellerInfo,
  //                 style: const TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w800,
  //                 ),
  //               ),
  //               const SizedBox(height: 10),
  //               Text(
  //                 nameSeller,
  //                 textAlign: TextAlign.end,
  //                 style: const TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 15,
  //                   fontWeight: FontWeight.w700,
  //                 ),
  //               ),
  //               const SizedBox(height: 8),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   Flexible(
  //                     child: Text(
  //                       locationSeller,
  //                       textAlign: TextAlign.end,
  //                       style: TextStyle(
  //                         color: Colors.white.withOpacity(0.74),
  //                         fontSize: 12,
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(width: 6),
  //                   const Icon(
  //                     Icons.location_on_outlined,
  //                     color: primaryColor,
  //                     size: 18,
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(width: 14),
  //         Container(
  //           width: 58,
  //           height: 58,
  //           decoration: BoxDecoration(
  //             color: Colors.white.withOpacity(0.12),
  //             borderRadius: BorderRadius.circular(18),
  //             border: Border.all(color: Colors.white.withOpacity(0.10)),
  //             image: cleanSellerImage.isEmpty
  //                 ? null
  //                 : DecorationImage(
  //                     image: NetworkImage('$url/uploads/$cleanSellerImage'),
  //                     fit: BoxFit.cover,
  //                   ),
  //           ),
  //           child: cleanSellerImage.isEmpty
  //               ? const Icon(Icons.storefront_outlined, color: Colors.white, size: 26)
  //               : null,
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
}
