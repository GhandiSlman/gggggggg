import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lms/core/utils/app_color.dart';

import 'package:lms/core/widgets/custom_drawer.dart';


import 'package:lms/features/home/presentation/widgets/home_grid_view.dart';
import 'package:lms/features/home/presentation/widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      backgroundColor: AppColor.scaffoldColor,
      body: const Column(
        children: [
          HomeHeader(),
          HomeGridView(),
        ],
      ),
    );
  }
}
