import 'package:get/get.dart';
import 'package:lms/core/screens/setting_screen.dart';
import 'package:lms/features/auth/presentation/screens/login_sceen.dart';
import 'package:lms/features/parent/presentation/screens/parent_chat_screen.dart';
import 'package:lms/features/posts/presentation/screens/add_update_post_screen.dart';
import 'package:lms/features/supervisor/presentation/screens/add_update_adv_screen.dart';
import 'package:lms/features/supervisor/presentation/screens/advertisements_screen.dart';
import 'package:lms/features/supervisor/presentation/screens/news_screen.dart';
import 'package:lms/features/honor_board/presentation/screens/honor_board_screen.dart';
import 'package:lms/features/parent/presentation/screens/son_achievement_screen.dart';
import 'package:lms/features/parent/presentation/screens/sons_screen.dart.dart';
import 'package:lms/features/parent/presentation/screens/student_honor_board_screen.dart';
import 'package:lms/features/students/presentation/screens/student_screen.dart';
import 'package:lms/features/supervisor/presentation/screens/super_visor_chats_screen.dart';
import 'package:lms/features/comments/presentation/screens/comments_screen.dart';
import 'package:lms/features/home/presentation/screens/home_screen.dart';
import 'package:lms/features/posts/presentation/screens/posts_screen.dart';
import 'package:lms/features/supervisor/presentation/screens/super_visor_presence_screen.dart';
import 'package:lms/features/teacher/presentation/screens/activiry_screen.dart';
import 'package:lms/features/teacher/presentation/screens/add_activity_screen.dart';
import 'package:lms/features/teacher/presentation/screens/add_assign_rate.dart';
import 'package:lms/features/teacher/presentation/screens/add_homework_screen.dart';
import 'package:lms/features/honor_board/presentation/screens/add_update_honor_board_screen.dart';
import 'package:lms/features/teacher/presentation/screens/add_rate_screen.dart';
import 'package:lms/features/teacher/presentation/screens/add_to_week_plane_screen.dart';
import 'package:lms/features/teacher/presentation/screens/assigned_rates_screen.dart';
import 'package:lms/features/teacher/presentation/screens/chat_details.dart';
import 'package:lms/features/teacher/presentation/screens/chat_screen.dart';
import 'package:lms/features/teacher/presentation/screens/choose_date_screen.dart';
import 'package:lms/features/teacher/presentation/screens/class_schedule_screen.dart';
import 'package:lms/features/teacher/presentation/screens/continous_rating_screen.dart';
import 'package:lms/features/teacher/presentation/screens/teacher_week_plane_screen.dart';
import 'package:lms/features/teacher/presentation/screens/techer_class_room_screen.dart';

class AppRouter {
  static const String homeScreen = '/homeScreen';
  static const String loginScreen = '/loginScreen';
  static const String commentScreen = '/commentScreen';
  static const String postScreen = '/postsScreen';
  static const String addHomeWork = '/addHomeWorkScreen';
  static const String addActivity = '/addActivityScreen';
  static const String chooseDate = '/chooseDateScreen';
  static const String addPostScreen = '/addPostScreen';
  static const String techerClassRoomScreen = '/techerClassRoomScreen';
  static const String activityScreen = '/activityScreen';
  static const String allchatsScreen = '/allchatsScreen';
  static const String teacherWeekPlane = '/teacherWeekPlane';
  static const String parentChatScreen = '/parentChatScreen';
  static const String chatScreen = '/chatScreen';
  static const String chatDetails = '/chatDetails';
  static const String superVisorPresence = '/superVisorPresence';
  static const String addToWeekPlaneScreen = '/addToWeekPlaneScreen';
  static const String parentHonorBoardScreen = '/parentHonorBoardScreen';
  static const String studentHonorBoardScreen = '/studentHonorBoardScreen';
  static const String sonsScreen = '/sonsScreen';
  static const String sonAchievementScreen = '/sonAchievementScreen';
  static const String addHonorBoardScreen = '/addHonorBoardScreen';
  static const String updateHonorBoardScreen = '/updateHonorBoardScreen';
  static const String studentScreen = '/studentScreen';
  static const String classScheduleScreen = '/classScheduleScreen';
  static const String addUpdateAdvScreen = '/addUpdateAdvScreen';
  static const String advertisementsScreen = '/advertisementsScreen';
  static const String newsScreen = '/newsScreen';
  static const String continousRatingScreen = '/continousRatingScreen';
  static const String addRate = '/addRate';
  static const String assignRatescreen = '/assignRatescreen';
  static const String addAssignRatescreen = '/addAssignRatescreen';
  static const String settingsScreen = '/settingsScreen';

  static final List<GetPage> pages = [
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: commentScreen, page: () => const CommentsScreen()),
    GetPage(name: postScreen, page: () => const PostsScreen()),
    GetPage(name: addHomeWork, page: () => const AddHomeWorkScreen()),
    GetPage(name: addActivity, page: () => AddActivityScreen()),
    GetPage(name: chooseDate, page: () => const ChooseDateScreen()),
    GetPage(name: addPostScreen, page: () => const AddPostScreen()),
    GetPage(
        name: techerClassRoomScreen,
        page: () => const TeacherClassRoomScreen()),
    GetPage(name: activityScreen, page: () => const ActivityScreen()),
    GetPage(name: allchatsScreen, page: () => const SuperVisorChatScreen()),
    GetPage(name: teacherWeekPlane, page: () => const TeacherWeekPlaneScreen()),
    GetPage(name: parentChatScreen, page: () => const ParentChatScreen()),
    GetPage(name: chatScreen, page: () => const ChatScreen()),
    GetPage(
        name: chatDetails,
        page: () => ChatDetails(contactModel: Get.arguments)),
    GetPage(
        name: superVisorPresence, page: () => const SuperVisorPresenceScreen()),
    GetPage(
        name: addToWeekPlaneScreen, page: () => const AddToWeekPlaneScreen()),
    GetPage(name: parentHonorBoardScreen, page: () => const HonorBoardScreen()),
    GetPage(
        name: studentHonorBoardScreen,
        page: () => const StudentHonorBoardScreen()),
    GetPage(name: sonsScreen, page: () => const SonsScreen()),
    GetPage(
        name: sonAchievementScreen, page: () => const SonAchievementScreen()),
    GetPage(name: addHonorBoardScreen, page: () => const AddHonorBoardScreen()),
    GetPage(name: studentScreen, page: () => const StudentScreen()),
    GetPage(name: classScheduleScreen, page: () => const ClassScheduleScreen()),
    GetPage(name: addUpdateAdvScreen, page: () => const AddUpdateAdvScreen()),
    GetPage(
        name: advertisementsScreen, page: () => const AdvertisementsScreen()),
    GetPage(name: newsScreen, page: () => const NewsScreen()),
    GetPage(
        name: continousRatingScreen, page: () => const ContinousRatingScreen()),
    GetPage(name: addRate, page: () => const AddRate()),
    GetPage(name: assignRatescreen, page: () => const AssignedRatesScreen()),
    GetPage(name: addAssignRatescreen, page: () => const AddAsignRateScreen()),
    GetPage(name: settingsScreen, page: () => const SettingSreen()),
  ];
}
