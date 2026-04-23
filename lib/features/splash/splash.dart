import 'package:flutter/material.dart';

import '../../core/ navigation/navigation.dart';
import '../../core/navigation_bar/navigation_bar.dart';
import '../../core/navigation_bar/navigation_bar_Admin.dart';
import '../../core/network/local/cache_helper.dart';
import '../../core/widgets/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      Widget? widget;
      classId = CacheHelper.getData(key: 'classId') ?? 1;
      className = CacheHelper.getData(key: 'class') ?? 'السادس العلمي';
      if(CacheHelper.getData(key: 'token') == null){
        token='';
          widget = BottomNavBar();
      }else{
        if(CacheHelper.getData(key: 'role') == null){
          widget = BottomNavBar();
          adminOrUser='user';
        }else{
          adminOrUser = CacheHelper.getData(key: 'role');
          if (adminOrUser == 'admin') {
            widget = BottomNavBarAdmin();
          }else{
            widget = BottomNavBar();
          }
        }
        token = CacheHelper.getData(key: 'token') ;
        id = CacheHelper.getData(key: 'id') ??'' ;
      }

      navigateAndFinish(context, widget);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xFF131C25), Color(0xFF253444)],
                  ),
                ),
                child: Center(child:
                Image.asset('assets/images/$logo',width: 150,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
