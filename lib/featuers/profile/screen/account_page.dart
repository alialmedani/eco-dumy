 
import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/classes/cashe_helper.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        title: Text(
        "Account_Information".tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            // color: dark ? ColorsManager.light : ColorsManager.gray,
            color: AppColors.lighta
          ),
        ),
        centerTitle: true,
        elevation: 4,
        iconTheme: IconThemeData(
          // color: dark ? ColorsManager.light : ColorsManager.gray,
          color: AppColors.lighta
        ),
      ),
      body:
      
        
  SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileDetailCard(
                      context: context,
                      label: "Username".tr(),
                      value:CacheHelper.userInfo?.username ?? "",
                    ),
                    _buildProfileDetailCard(
                      context: context,
                      label: "Email1".tr(),
                      value: CacheHelper.userInfo?.email ?? "",
                    ),
                    _buildProfileDetailCard(
                      context: context,
                      label: "First_Name".tr(),
                      value: CacheHelper.userInfo?.firstName ?? "",
                    ),
                    _buildProfileDetailCard(
                      context: context,
                      label: "Last_Name".tr(),
                      value: CacheHelper.userInfo?.lastName ?? "",
                    ),
                    _buildProfileDetailCard(
                      context: context,
                      label: "Gender".tr(),
                      value: CacheHelper.userInfo?.gender ?? "",
                    ),
                  ],
                ),
              ),
            );
  }
      
        } 
  
 

  Widget _buildProfileDetailCard({
    required BuildContext context,
    required String label,
    required String value,
  }) {
    return Card(
      // color: dark ? ColorsManager.darkerGrey : ColorsManager.light,
      color: AppColors.darkerGreya,
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                // color: dark ? ColorsManager.light : ColorsManager.dark,
                color: AppColors.lighta,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  // color: dark ? AppColors.lightGraya : Colors.black87,
                  color: AppColors.lightGraya,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
 