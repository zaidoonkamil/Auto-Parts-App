import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:auto_parts_app/core/%20navigation/navigation.dart';
import 'package:auto_parts_app/core/widgets/app_bar.dart';
import 'package:auto_parts_app/features/user/view/complete_shopping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/localization/localization_extension.dart';
import '../../../core/network/remote/dio_helper.dart';
import '../../../core/styles/themes.dart';
import '../../../core/widgets/circular_progress.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class Basket extends StatelessWidget {
  const Basket({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit()..getBasket(context: context),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = UserCubit.get(context);
          final bool hasItems = cubit.basketModel.isNotEmpty;

          return SafeArea(
            child: Scaffold(
              backgroundColor: pageBackgroundColor,
              body: Column(
                children: [
                  CustomAppBarBack(
                    title: context.l10n.basketTitle,
                    subtitle: context.l10n.basketSubtitle,
                  ),
                  Expanded(
                    child: ConditionalBuilder(
                      condition: state is! GetBasketLoadingState,
                      builder: (context) {
                        if (!hasItems) {
                          return const _EmptyBasket();
                        }

                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 120),
                          child: Column(
                            children: [
                              _SummaryCard(cubit: cubit),
                              const SizedBox(height: 14),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: cubit.basketModel.length,
                                separatorBuilder: (context, index) => const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  final item = cubit.basketModel[index];
                                  final image = item.product.images.isNotEmpty
                                      ? item.product.images.first.replaceAll(RegExp(r'[\[\]]'), '')
                                      : '';

                                  return Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(22),
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
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      cubit.deleteBasket(
                                                        idItem: item.id.toString(),
                                                        context: context,
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 36,
                                                      height: 36,
                                                      decoration: BoxDecoration(
                                                        color: const Color(0xFFF9E7E6),
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                      child: const Icon(
                                                        Icons.delete_outline_rounded,
                                                        color: accentColor,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Expanded(
                                                    child: Text(
                                                      item.product.title,
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.end,
                                                      style: const TextStyle(
                                                        color: secondPrimaryColor,
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w800,
                                                        height: 1.35,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  Text(
                                                    NumberFormat('#,###').format(
                                                      item.product.price * item.quantity,
                                                    ),
                                                    style: const TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w900,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    context.l10n.currencyShort,
                                                    style: const TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    context.l10n.unitPriceLabel(
                                                      NumberFormat('#,###').format(item.product.price),
                                                    ),
                                                    style: const TextStyle(
                                                      color: secondTextColor,
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  _QtyButton(
                                                    icon: Icons.add,
                                                    color: primaryColor,
                                                    iconColor: Colors.white,
                                                    onTap: () {
                                                      cubit.addBasket(index: index);
                                                    },
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(14),
                                                      border: Border.all(color: borderColor),
                                                    ),
                                                    child: Text(
                                                      '${item.quantity}',
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        color: secondPrimaryColor,
                                                        fontWeight: FontWeight.w800,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  _QtyButton(
                                                    icon: Icons.remove,
                                                    color: mutedSurfaceColor,
                                                    iconColor: secondPrimaryColor,
                                                    onTap: () {
                                                      cubit.minusBasket(index: index, context: context);
                                                    },
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    context.l10n.quantity,
                                                    style: const TextStyle(
                                                      color: secondTextColor,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Container(
                                          width: 96,
                                          height: 124,
                                          decoration: BoxDecoration(
                                            color: containerColor,
                                            borderRadius: BorderRadius.circular(18),
                                            image: image.isEmpty
                                                ? null
                                                : DecorationImage(
                                                    image: NetworkImage('$url/uploads/$image'),
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                          child: image.isEmpty
                                              ? const Icon(
                                                  Icons.image_not_supported_outlined,
                                                  color: secondTextColor,
                                                )
                                              : null,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      fallback: (context) => const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: CircularProgressBasket(),
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: hasItems
                  ? SafeArea(
                      top: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                        child: _CheckoutBar(cubit: cubit),
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.cubit});

  final UserCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xFF131C25), Color(0xFF253444)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            context.l10n.basketItemsSummary(cubit.basketModel.length),
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                NumberFormat('#,###').format(cubit.getTotalPrice()),
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                context.l10n.currencyShort,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Text(
                context.l10n.totalLabel,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CheckoutBar extends StatelessWidget {
  const _CheckoutBar({required this.cubit});

  final UserCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final List<Map<String, dynamic>> itemsMap = cubit.basketModel.map((item) {
          return {
            'productId': item.productId,
            'quantity': item.quantity,
          };
        }).toList();

        navigateTo(context, CompleteShopping(items: itemsMap));
      },
      child: Container(
        height: 64,
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
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: primaryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    context.l10n.checkout,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    context.l10n.orderTotalLabel(
                      NumberFormat('#,###').format(cubit.getTotalPrice()),
                    ),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.72),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
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

class _QtyButton extends StatelessWidget {
  const _QtyButton({
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
    );
  }
}

class _EmptyBasket extends StatelessWidget {
  const _EmptyBasket();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                color: mutedSurfaceColor,
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 42,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              context.l10n.basketEmptyTitle,
              style: const TextStyle(
                color: secondPrimaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.basketEmptySubtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: secondTextColor,
                fontSize: 13,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
