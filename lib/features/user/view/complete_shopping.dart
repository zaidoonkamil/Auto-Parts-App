import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:auto_parts_app/core/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ navigation/navigation.dart';
import '../../../core/localization/localization_extension.dart';
import '../../../core/navigation_bar/navigation_bar.dart';
import '../../../core/styles/themes.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class CompleteShopping extends StatelessWidget {
  const CompleteShopping({super.key, required this.items});

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

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController phoneController = TextEditingController();
  static TextEditingController locationController = TextEditingController();
  final List<Map<String, dynamic>> items;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is AddOrderSuccessState) {
            phoneController.text = '';
            locationController.text = '';
            showSuccessSnackBar(context, context.l10n.orderCreatedSuccess);
            navigateAndFinish(context, const BottomNavBar());
          }
        },
        builder: (context, state) {
          final cubit = UserCubit.get(context);

          return SafeArea(
            child: Scaffold(
              backgroundColor: pageBackgroundColor,
              body: Column(
                children: [
                  CustomAppBarBack(
                    title: context.l10n.completeShoppingTitle,
                    subtitle: context.l10n.completeShoppingSubtitle,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 120),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            _OrderSummaryCard(itemsCount: items.length),
                            const SizedBox(height: 14),
                            const _PaymentCard(),
                            const SizedBox(height: 14),
                            _AddressForm(
                              phoneController: phoneController,
                              locationController: locationController,
                            ),
                            const SizedBox(height: 14),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        cubit.addOrder(
                          context: context,
                          phone: phoneController.text.trim(),
                          location: locationController.text.trim(),
                          products: items,
                        );
                      }
                    },
                    child: Container(
                      height: 60,
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
                      child: ConditionalBuilder(
                        condition: state is! AddOrderLoadingState,
                        builder: (context) => Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.check_circle_outline_rounded,
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
                                    context.l10n.confirmOrder,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    context.l10n.prepareItemsCount(items.length),
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
                        fallback: (context) => const Center(
                          child: SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  const _OrderSummaryCard({required this.itemsCount});

  final int itemsCount;

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
            context.l10n.reviewOrderInfo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            context.l10n.reviewOrderInfoSubtitle(itemsCount),
            textAlign: TextAlign.end,
            style: TextStyle(
              color: Colors.white.withOpacity(0.74),
              fontSize: 13,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: mutedSurfaceColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.payments_outlined, color: primaryColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  context.l10n.paymentMethod,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: secondPrimaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Cash on Delivery',
                  style: TextStyle(
                    fontSize: 13,
                    color: secondTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  context.l10n.cashOnDelivery,
                  style: const TextStyle(
                    fontSize: 12,
                    color: secondTextColor,
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

class _AddressForm extends StatelessWidget {
  const _AddressForm({
    required this.phoneController,
    required this.locationController,
  });

  final TextEditingController phoneController;
  final TextEditingController locationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            context.l10n.shippingInfo,
            style: const TextStyle(
              fontSize: 16,
              color: secondPrimaryColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            context.l10n.phoneNumber,
            style: const TextStyle(
              fontSize: 12,
              color: secondTextColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            hintText: context.l10n.enterPhoneNumber,
            controller: phoneController,
            keyboardType: TextInputType.phone,
            validate: (String? value) {
              if (value == null || value.isEmpty) {
                return context.l10n.pleaseEnterPhoneNumber;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.detailedAddress,
            style: const TextStyle(
              fontSize: 12,
              color: secondTextColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            hintText: context.l10n.enterDetailedAddress,
            controller: locationController,
            keyboardType: TextInputType.text,
            maxLines: 3,
            validate: (String? value) {
              if (value == null || value.isEmpty) {
                return context.l10n.pleaseEnterDetailedAddress;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
