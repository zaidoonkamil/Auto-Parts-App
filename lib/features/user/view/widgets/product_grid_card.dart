import 'package:auto_parts_app/core/%20navigation/navigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/network/remote/dio_helper.dart';
import '../../../../core/styles/themes.dart';
import '../../../../core/widgets/constant.dart';
import '../../../auth/view/login.dart';
import '../../cubit/cubit.dart';
import '../details.dart';

class UserProductGridCard extends StatelessWidget {
  const UserProductGridCard({
    super.key,
    required this.cubit,
    required this.productId,
    required this.sellerId,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.isFavorite,
    required this.imageSeller,
    required this.locationSeller,
    required this.nameSeller,
  });

  final UserCubit cubit;
  final String productId;
  final String sellerId;
  final String title;
  final String description;
  final int price;
  final List<String> images;
  final bool isFavorite;
  final String imageSeller;
  final String locationSeller;
  final String nameSeller;

  @override
  Widget build(BuildContext context) {
    final String rawImageUrl = images.isNotEmpty ? images.first : '';
    final String cleanImageUrl = rawImageUrl.replaceAll(RegExp(r'[\[\]]'), '');

    return GestureDetector(
      onTap: () {
        navigateToPremium(
          context,
          Details(
            sellerId: sellerId,
            id: productId,
            tittle: title,
            description: description,
            price: price.toString(),
            images: images,
            isFavorite: isFavorite,
            imageSeller: imageSeller,
            locationSeller: locationSeller,
            nameSeller: nameSeller,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: cardSurfaceColor,
          borderRadius: BorderRadius.circular(24),
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
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Hero(
                      tag: 'product-image-$productId',
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                        child: cleanImageUrl.isEmpty
                            ? Container(
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: secondTextColor,
                                ),
                              )
                            : Image.network(
                                '$url/uploads/$cleanImageUrl',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        context.l10n.availableNow,
                        style: const TextStyle(
                          color: successColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: secondPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (token != '') {
                            cubit.addToBasket(
                              productId: productId,
                              quantity: '1',
                              context: context,
                            );
                          } else {
                            navigateTo(context, const Login());
                          }
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFD98F39), Color(0xFFBE3D2A)],
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.basketShopping,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              NumberFormat('#,###').format(price),
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                color: secondPrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              context.l10n.iraqiDinar,
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                color: secondTextColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
