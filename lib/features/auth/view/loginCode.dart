import 'package:auto_parts_app/core/styles/themes.dart';
import 'package:auto_parts_app/core/widgets/custom_text_field.dart';
import 'package:auto_parts_app/core/widgets/show_toast.dart';
import 'package:auto_parts_app/features/auth/view/login.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ navigation/navigation.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'widgets/auth_shell_widgets.dart';

class LoginCode extends StatelessWidget {
  const LoginCode({super.key, required this.phone});

  final String phone;
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          LoginCubit()..sendOtp(phone: phone, context: context),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is VerifyOtpSuccessState) {
            showToastSuccess(
              text: "تم تفعيل الحساب بنجاح",
              context: context,
            );
            navigateAndFinish(context, const Login());
          }
        },
        builder: (context, state) {
          final cubit = LoginCubit.get(context);
          return SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0xFFF4F6F8),
              body: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AuthBackButtonHeader(),
                      const SizedBox(height: 18),
                      const AuthHeroCard(
                        icon: Icons.mark_chat_read_rounded,
                        title: 'تفعيل الحساب',
                        subtitle:
                            'أدخل رمز التحقق المرسل إلى واتساب المرتبط برقم هاتفك لإكمال إنشاء الحساب.',
                      ),
                      const SizedBox(height: 16),
                      AuthInfoStrip(
                        icon: Icons.phone_android_rounded,
                        text: 'رقم التفعيل الحالي: $phone',
                      ),
                      const SizedBox(height: 18),
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
                              controller: codeController,
                              hintText: 'أدخل كود التفعيل',
                              keyboardType: TextInputType.number,
                              validate: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'رجاءً أدخل كود التفعيل';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton.icon(
                                onPressed: state is SendOtpLoadingState
                                    ? null
                                    : () {
                                        cubit.sendOtp(phone: phone, context: context);
                                      },
                                icon: const Icon(Icons.refresh, color: primaryColor, size: 18),
                                label: const Text(
                                  'إعادة إرسال الكود',
                                  style: TextStyle(color: primaryColor),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ConditionalBuilder(
                              condition: state is! VerifyOtpLoadingState,
                              builder: (context) {
                                return AuthPrimaryButton(
                                  title: 'التحقق',
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.verifyOtp(
                                        phone: phone,
                                        code: codeController.text.trim(),
                                        context: context,
                                      );
                                    }
                                  },
                                );
                              },
                              fallback: (c) => const Center(
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
