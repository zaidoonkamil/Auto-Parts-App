import 'package:auto_parts_app/core/navigation_bar/navigation_bar.dart';
import 'package:auto_parts_app/core/navigation_bar/navigation_bar_Admin.dart';
import 'package:auto_parts_app/core/network/local/cache_helper.dart';
import 'package:auto_parts_app/core/styles/themes.dart';
import 'package:auto_parts_app/core/widgets/constant.dart';
import 'package:auto_parts_app/core/widgets/custom_text_field.dart';
import 'package:auto_parts_app/core/widgets/show_toast.dart';
import 'package:auto_parts_app/features/auth/view/forgot_password.dart';
import 'package:auto_parts_app/features/auth/view/loginCode.dart';
import 'package:auto_parts_app/features/auth/view/register.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ navigation/navigation.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final TextEditingController userNameController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          final cubit = LoginCubit.get(context);

          if (state is LoginSuccessState) {
            CacheHelper.saveData(
              key: 'token',
              value: cubit.token,
            ).then((value) {
              CacheHelper.saveData(
                key: 'id',
                value: cubit.id,
              ).then((value) {
                CacheHelper.saveData(
                  key: 'role',
                  value: cubit.role,
                ).then((value) {
                  token = cubit.token.toString();
                  id = cubit.id.toString();
                  adminOrUser = cubit.role.toString();

                  cubit.registerDevice(cubit.id.toString());

                  if (adminOrUser == 'admin') {
                    navigateAndFinish(context, BottomNavBarAdmin());
                  } else {
                    navigateAndFinish(context, BottomNavBar());
                  }
                });
              });
            });
          }

          if (state is AccountNotVerifiedState) {
            showToastError(
              text: 'الحساب غير مفعل بعد، تم تحويلك إلى صفحة التفعيل',
              context: context,
            );
            navigateTo(context, LoginCode(phone: cubit.phonee ?? userNameController.text.trim()));
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
                        const SizedBox(height: 60),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 2000),
                          curve: Curves.easeOutBack,
                          builder: (context, scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: child,
                            );
                          },
                          child: Image.asset('assets/images/$logo', width: 140, height: 200),
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          hintText: 'رقم الهاتف',
                          controller: userNameController,
                          keyboardType: TextInputType.phone,
                          validate: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'رجاءً أدخل رقم الهاتف';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          hintText: 'كلمة السر',
                          controller: passwordController,
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
                            return null;
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              navigateTo(context, const ForgotPassword());
                            },
                            child: const Text(
                              'نسيت كلمة المرور؟',
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (c) {
                            return GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.signIn(
                                    phone: userNameController.text.trim(),
                                    password: passwordController.text.trim(),
                                    context: context,
                                  );
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
                                      'تسجيل الدخول',
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
                                navigateTo(context, const Register());
                              },
                              child: const Text(
                                'إنشاء حساب ',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text(
                              'لا تمتلك حساب ؟ ',
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
