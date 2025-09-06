import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/WalletController.dart';
import 'package:kinana_al_sham/services/WalletService.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:kinana_al_sham/widgets/responsive_sizes.dart';

class WalletView extends StatelessWidget {
  final walletController = Get.put(WalletController(WalletService()));

  WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar( elevation: 0,
      backgroundColor: AppColors.pureWhite,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkBlue),
          onPressed: () => Navigator.pop(context),
        ),
      ],),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.pureWhite,
                AppColors.grayWhite,
                AppColors.pinkBeige,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Center(
            child: Obx(() {
              if (walletController.isLoading.value) {
                return const CircularProgressIndicator();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // أيقونة المحفظة
                  Icon(
                    Icons.account_balance_wallet_rounded,
                    color: AppColors.darkBlue,
                    size: r.wp(25),
                  ),
                  SizedBox(height: r.hp(3)),

                  // مرحباً + اسم المستخدم
                  Text(
                    "مرحباً ${walletController.userName.value}",
                    style: TextStyle(
                      fontSize: r.sp(20),
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  SizedBox(height: r.hp(2)),

                  // الرصيد الحالي
                  Text(
                    "الرصيد الحالي",
                    style: TextStyle(
                      fontSize: r.sp(16),
                      color: AppColors.bluishGray,
                    ),
                  ),
                  SizedBox(height: r.hp(1)),
                  Text(
                    "${walletController.balance.value} ل.س",
                    style: TextStyle(
                      fontSize: r.sp(26),
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBlue,
                    ),
                  ),
                  SizedBox(height: r.hp(4)),

                  // زر التحديث
                  ElevatedButton.icon(
                    onPressed: () => walletController.fetchWallet(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      padding: EdgeInsets.symmetric(
                        horizontal: r.wp(10),
                        vertical: r.hp(1.8),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    label: Text(
                      "تحديث الرصيد",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: r.sp(16),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
