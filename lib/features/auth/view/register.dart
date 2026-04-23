import 'package:auto_parts_app/core/styles/themes.dart';
import 'package:auto_parts_app/core/widgets/custom_text_field.dart';
import 'package:auto_parts_app/core/widgets/show_toast.dart';
import 'package:auto_parts_app/features/auth/view/login.dart';
import 'package:auto_parts_app/features/auth/view/loginCode.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ navigation/navigation.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final TextEditingController userNameController = TextEditingController();
  static final TextEditingController phoneController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();
  static final TextEditingController rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          final cubit = LoginCubit.get(context);
          if (state is SignUpSuccessState) {
            userNameController.clear();
            phoneController.clear();
            passwordController.clear();
            rePasswordController.clear();
            showToastSuccess(
              text: 'تم إنشاء الحساب، أدخل رمز التفعيل المرسل عبر واتساب',
              context: context,
            );
            navigateAndFinish(
              context,
              LoginCode(phone: cubit.phonee ?? cubit.pendingPhone ?? ''),
            );
          }
        },
        builder: (context, state) {
          final cubit = LoginCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigateBack(context);
                              },
                              child: const Icon(Icons.arrow_back_ios_new_rounded, size: 24),
                            ),
                            const Text(
                              'حساب جديد',
                              style: TextStyle(
                                color: secondPrimaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                        const SizedBox(height: 70),
                        CustomTextField(
                          hintText: 'الاسم الثلاثي',
                          controller: userNameController,
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'رجاءً أدخل الاسم الثلاثي';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Stack(
                          children: [
                            CustomTextField(
                              controller: phoneController,
                              hintText: 'رقم الهاتف',
                              keyboardType: TextInputType.phone,
                              validate: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'رجاءً أدخل رقم الهاتف';
                                }
                                return null;
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              height: 48,
                              width: 80,
                              decoration: BoxDecoration(
                                color: secondPrimaryColor,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withOpacity(0.4),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 0),
                                  )
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  '+964',
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'كلمة السر',
                          obscureText: cubit.isPasswordHidden,
                          suffixIcon: GestureDetector(
                            onTap: cubit.togglePasswordVisibility,
                            child: Icon(
                              cubit.isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'رجاءً أدخل كلمة السر';
                            }
                            if (value.length < 6) {
                              return 'كلمة السر يجب أن تكون 6 أحرف على الأقل';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: rePasswordController,
                          hintText: 'أعد كتابة كلمة السر',
                          obscureText: cubit.isPasswordHidden2,
                          suffixIcon: GestureDetector(
                            onTap: cubit.togglePasswordVisibility2,
                            child: Icon(
                              cubit.isPasswordHidden2 ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'رجاءً أعد إدخال كلمة السر';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 60),
                        ConditionalBuilder(
                          condition: state is! SignUpLoadingState,
                          builder: (c) {
                            return GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  if (passwordController.text == rePasswordController.text) {
                                    cubit.signUp(
                                      name: userNameController.text.trim(),
                                      phone: phoneController.text.trim(),
                                      location: 'بغداد',
                                      password: passwordController.text.trim(),
                                      role: 'user',
                                      context: context,
                                    );
                                  } else {
                                    showToastError(
                                      text: 'كلمة السر غير متطابقة',
                                      context: context,
                                    );
                                  }
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: 56,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.2),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                  color: secondPrimaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(width: 50),
                                    const Text(
                                      'إنشاء الحساب',
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(6),
                                      height: double.maxFinite,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white,
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 22,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          fallback: (c) => const CircularProgressIndicator(color: primaryColor),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigateAndFinish(context, const Login());
                              },
                              child: const Text(
                                'تسجيل الدخول ',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text(
                              'أمتلك حساب ؟ ',
                              style: TextStyle(color: secondTextColor),
                            ),
                          ],
                        ),
                      ],
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
