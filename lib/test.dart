// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lms/core/utils/app_color.dart';
// import 'package:lms/features/comments/presentation/screens/comments_screen.dart';
// import 'package:lms/features/home/presentation/screens/home_screen.dart';

// import 'package:lms/features/parent/presentation/screens/parent_honor_board_screen.dart';
// import 'package:lms/features/parent/presentation/screens/son_achievement_screen.dart';
// import 'package:lms/features/parent/presentation/screens/sons_screen.dart.dart';
// import 'package:lms/features/parent/presentation/screens/student_honor_board_screen.dart';
// import 'package:lms/features/posts/presentation/screens/add_post_screen.dart';
// import 'package:lms/features/posts/presentation/screens/first_class_post_screen.dart';
// import 'package:lms/features/students/presentation/screens/prepare_tajweed_subject_screen.dart';

// import 'package:lms/features/supervisor/presentation/screens/super_visor_presence_screen.dart';
// import 'package:lms/features/teacher/controller/teacher_controller.dart';
// import 'package:lms/features/teacher/presentation/screens/activiry_screen.dart';
// import 'package:lms/features/teacher/presentation/screens/add_activity_screen.dart';
// import 'package:lms/features/teacher/presentation/screens/add_homework_screen.dart';
// import 'package:lms/features/teacher/presentation/screens/add_honor_board_screen.dart';
// import 'package:lms/features/teacher/presentation/screens/add_to_week_plane_screen.dart';
// import 'package:lms/features/teacher/presentation/screens/chat_details.dart';
// import 'package:lms/features/teacher/presentation/screens/chat_screen.dart';
// import 'package:lms/features/teacher/presentation/screens/choose_date_screen.dart';

// class TestScreen extends StatelessWidget {
//   const TestScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     TeacherController teacherController = Get.put(TeacherController());
//     return Scaffold(
//       appBar: AppBar(
        
//         bottom: PreferredSize(

//           preferredSize: const Size.fromHeight(0),
//           child: TabBar(
//             indicatorColor: AppColor.primaryColor,
//             labelColor: AppColor.primaryColor,
//             controller: teacherController.tabController2,
//             tabs: teacherController.test,
//           ),
//         ),
//       ),
//       body: TabBarView(
//         controller: teacherController.tabController2,
//         children: [
//           const HomeScreen(),
//           const ChatScreen(),
//           const ParentHonorBoardScreen(),
//           const SonAchievementScreen(),
//           const SonsScreen(),
//           const StudentHonorBoardScreen(),
//           const AddPostScreen(),
//           const FirstClassPostScreen(),
//           const PrepareTajweedSugjectScreen(),
//           const SuperVisorPresenceScreen(),
//           const ActivityScreen(),
//           AddActivityScreen(),
//           const AddHomeWorkScreen(),
//           const AddHonorBoardScreen(),
//           const AddToWeekPlaneScreen(),
//           const ChatDetails(),
//           const ChooseDateScreen(),
//           const CommentsScreen(),

//         ],
//       ),
//     );
//   }
// }
