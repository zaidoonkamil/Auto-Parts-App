import 'package:auto_parts_app/core/styles/themes.dart';
import 'package:auto_parts_app/core/widgets/custom_text_field.dart';
import 'package:auto_parts_app/features/auth/view/reset_password.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ navigation/navigation.dart';
import '../../../core/widgets/show_toast.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'widgets/auth_shell_widgets.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          final cubit = LoginCubit.get(context);
          if (state is ForgotPasswordRequestSuccessState) {
            showToastSuccess(
              text: 'تم إرسال رمز إعادة التعيين إلى واتساب',
              context: context,
            );
            navigateTo(
              context,
              ResetPassword(phone: cubit.phonee ?? cubit.pendingPhone ?? ''),
            );
          }
        },
        builder: (context, state) {
          final cubit = LoginCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xFFF4F6F8),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AuthBackButtonHeader(),
                      const SizedBox(height: 18),
                      const AuthHeroCard(
                        icon: Icons.lock_reset_rounded,
                        title: 'نسيت كلمة المرور',
                        subtitle:
                            'أدخل رقم هاتفك، وسنرسل لك رمز OTP عبر واتساب لإعادة تعيين كلمة المرور بشكل آمن',
                      ),
                      const SizedBox(height: 10),
                      const AuthInfoStrip(
                        icon: Icons.verified_user_outlined,
                        text: 'سيصلك الكود على واتساب خلال لحظات',
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x12000000),
                              blurRadius: 28,
                              offset: Offset(0, 14),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: phoneController,
                              hintText: 'رقم الهاتف',
                              keyboardType: TextInputType.phone,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'رجاءً أدخل رقم الهاتف';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            ConditionalBuilder(
                              condition: state is! ForgotPasswordRequestLoadingState,
                              builder: (_) {
                                return AuthPrimaryButton(
                                  title: 'إرسال الكود',
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.forgotPasswordRequest(
                                        phone: phoneController.text.trim(),
                                        context: context,
                                      );
                                    }
                                  },
                                );
                              },
                              fallback: (_) => const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: CircularProgressIndicator(color: primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
