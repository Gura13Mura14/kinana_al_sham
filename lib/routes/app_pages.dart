import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/opportunity_controller.dart';
import 'package:kinana_al_sham/controllers/register_controller.dart';
import 'package:kinana_al_sham/controllers/volunteering_opportunity_controller.dart';
import 'package:kinana_al_sham/views/beneficiary_home_view.dart';
import 'package:kinana_al_sham/views/beneficiary_profile_view.dart';
import 'package:kinana_al_sham/views/opportunity_view.dart';
import 'package:kinana_al_sham/views/register_view.dart';
import 'package:kinana_al_sham/views/HonerBoard/HonorBoardPage.dart';
import 'package:kinana_al_sham/views/views/inquiry_details_view.dart';
import 'package:kinana_al_sham/views/views/inquiry_list_view.dart';
import 'package:kinana_al_sham/views/views/profile_details_view.dart';
import 'package:kinana_al_sham/views/views/volunteer_home_calendar.dart';
import 'package:kinana_al_sham/views/volunteer_home_view.dart';
import 'package:kinana_al_sham/views/volunteering_opportunity_list_view.dart';
import '../views/login_view.dart';
import '../bindings/login_binding.dart';

class AppPages {
  static final routes = [
    GetPage(name: '/', page: () => LoginView(), binding: LoginBinding()),

    GetPage(
      name: '/register',
      page: () => const RegisterView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => RegisterController());
      }),
    ),
    GetPage(
      name: '/jobs',
      page: () => OpportunityView(), // صفحة عرض فرص العمل
      binding: BindingsBuilder(() {
        Get.lazyPut(() => OpportunityController());
      }),
    ),
    GetPage(
      name: '/volunteering',
      page: () => VolunteeringOpportunityListView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => VolunteeringOpportunityController());
      }),
    ),
    GetPage(name: '/home', page: () => VolunteerHomeView()),
    GetPage(name: '/home2', page: () => BeneficiaryHomeView()),
    GetPage(name: '/profile-details', page: () => ProfileDetailsView()),
    GetPage(name: '/HonorBoard', page: () => HonorBoardPage()),
    GetPage(name: '/Inquiry', page: () => InquiryListView()),
    GetPage(name: '/beneficiary-profile', page: () => BeneficiaryProfileView()),
  ];
}
