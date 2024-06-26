// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lms/core/data/data_repo.dart';
import 'package:lms/core/data/internet_checker.dart';
import 'package:lms/core/local/local_controller.dart';
import 'package:lms/features/auth/controller/auth_controller.dart';
import 'package:lms/features/auth/data/remote_repo/auth_repo.dart';
import 'package:lms/features/auth/data/remote_repo/auth_repo_imp.dart';
import 'package:lms/features/comments/data/comment_repo.dart';
import 'package:lms/features/comments/data/comment_repo_imp.dart';
import 'package:lms/features/comments/controller/comment_controller.dart';
import 'package:lms/features/posts/controller/post_controller.dart';
import 'package:lms/features/posts/data/post_repo_imp.dart';
import 'package:lms/features/posts/data/post_repo.dart';
import 'package:lms/features/students/controller/student_controller.dart';
import 'package:lms/features/students/data/student_repo.dart';
import 'package:lms/features/students/data/student_repo_imp.dart';
import 'package:lms/features/supervisor/controller/advertisements_controller.dart';
import 'package:lms/features/supervisor/controller/news_controller.dart';
import 'package:lms/features/supervisor/controller/student_status_controller.dart';
import 'package:lms/features/supervisor/data/advertisements_repo.dart';
import 'package:lms/features/supervisor/data/advertisements_rpeo_imp.dart';
import 'package:lms/features/supervisor/data/news_repo.dart';
import 'package:lms/features/supervisor/data/news_repo_imp.dart';
import 'package:lms/features/supervisor/data/student_status_repo.dart';
import 'package:lms/features/supervisor/data/student_status_repo_imp.dart';
import 'package:lms/features/teacher/controller/activity_controller.dart';
import 'package:lms/features/teacher/controller/class_schedule_controller.dart';
import 'package:lms/features/teacher/controller/honor_board_controller.dart';
import 'package:lms/features/teacher/controller/week_plane_controller.dart';
import 'package:lms/features/teacher/data/activity_repo.dart';
import 'package:lms/features/teacher/data/activity_repo_imp.dart';
import 'package:lms/features/teacher/data/class_schedule_repo.dart';
import 'package:lms/features/teacher/data/class_schedule_repo_imp.dart';
import 'package:lms/features/teacher/data/homework_repo.dart';
import 'package:lms/features/teacher/data/homework_repo_imp.dart';
import 'package:lms/features/teacher/controller/homework_controller.dart';
import 'package:lms/features/teacher/controller/teacher_controller.dart';
import 'package:lms/features/teacher/data/honor_board_repo.dart';
import 'package:lms/features/teacher/data/honor_board_repo_imp.dart';
import 'package:lms/features/teacher/data/week_plane_repo.dart';
import 'package:lms/features/teacher/data/week_plane_repo_imp.dart';

class DependencyInjection {
  static Future<void> init() async {
    //Local Controller

    Get.put(LocaleController(), permanent: true);

    // HTTP Client
    Get.put<http.Client>(http.Client(), permanent: true);

    // Network Info
    Get.lazyPut<NetworkInfo>(
        () => NetworkInfoImpl(InternetConnectionChecker()));

    // Data Service
    Get.put<DataService>(DataService(Get.find(), Get.find()), permanent: true);

    // Auth Repositories
    Get.put<AuthRepo>(AuthRepoImpl(Get.find()), permanent: true);

    // Auth Controller
    Get.put(AuthController(Get.put(AuthRepoImpl(Get.find()))), permanent: true);

    // Student Repository Lazy Initialization
    Get.lazyPut<StudentRepo>(() => StudentRepoImp(Get.find()), fenix: true);

    // StudentController Lazy Initialization
    Get.lazyPut<StudentController>(() => StudentController(Get.find()),
        fenix: true);

    // HomeWork Repository Lazy Initialization
    Get.lazyPut<HomeWorkRepo>(() => HomeWorkRepoImp(Get.find()), fenix: true);

    //HomeWorkController Lazy Initialization
    Get.lazyPut<HomeWorkController>(() => HomeWorkController(Get.find()),
        fenix: true);

    //TeacherController lazy Initialization
    Get.lazyPut<TeacherController>(() => TeacherController(), fenix: true);

    // HomeWork Repository Lazy Initialization
    Get.lazyPut<PostRepo>(() => PostRepoImp(Get.find()), fenix: true);

    //PostController lazy Initialization
    Get.lazyPut<PostController>(() => PostController(Get.find(), Get.find()),
        fenix: true);

    // Comment Repository Lazy Initialization
    Get.lazyPut<CommentRepo>(() => CommentRepoImp(Get.find()), fenix: true);

    //comment lazy Initialization
    Get.lazyPut<CommentController>(() => CommentController(Get.find()),
        fenix: true);

    //classScheduel Repository lazy Initialization
    Get.lazyPut<ClassScheduleRepo>(() => ClassScheduleRepoImp(Get.find()),
        fenix: true);

    //class Schedule controller laze
    Get.lazyPut<ClassScheduleController>(
        () => ClassScheduleController(Get.find()),
        fenix: true);

    //honorBoard  Repository lazy Initialization
    Get.lazyPut<HonorBoardRepo>(() => HonorBoardRepoImp(Get.find()),
        fenix: true);

    //Honor board controller laze
    Get.lazyPut<HonorBoardController>(() => HonorBoardController(Get.find()),
        fenix: true);

    //honorBoard  Repository lazy Initialization
    Get.lazyPut<ActivityRepo>(() => ActivityRepoImp(Get.find()), fenix: true);

    //Honor board controller laze
    Get.lazyPut<ActivityController>(() => ActivityController(Get.find()),
        fenix: true);

    //weekPlane  Repository lazy Initialization
    Get.lazyPut<WeekPlaneRepo>(() => WeekPlaneRepoImp(Get.find()), fenix: true);

    //weekPlane controller laze
    Get.lazyPut<WeekPlaneController>(() => WeekPlaneController(Get.find()),
        fenix: true);

    // Ad Repo lazy Initialization;
    Get.lazyPut<AdvertisementsRepo>(() => AdvertisementsRepoImp(Get.find()), fenix: true);

    // Ad Controller lazy
    Get.lazyPut<AdvertisementsController>(() => AdvertisementsController(Get.find()),
        fenix: true);

    // studend status repo init
    Get.lazyPut<StudentStatusRepo>(() => StudentStatusRepoImp(Get.find()), fenix: true);
   // studend status controler init
    Get.lazyPut<StudentStatusController>(() => StudentStatusController(Get.find()),
        fenix: true);

         // Ad Repo lazy Initialization;
    Get.lazyPut<NewsRepo>(() => NewsRepImp(Get.find()), fenix: true);

    // Ad Controller lazy
    Get.lazyPut<NewsController>(() => NewsController(Get.find()),
        fenix: true);

  }
}
