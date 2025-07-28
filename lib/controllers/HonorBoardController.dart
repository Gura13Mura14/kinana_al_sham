// lib/controllers/honor_board_controller.dart
import 'package:get/get.dart';
import 'package:kinana_al_sham/models/UserRole.dart';
import 'package:kinana_al_sham/models/VolunteerDetails.dart';
import 'package:kinana_al_sham/models/user_model.dart';

class HonorBoardController extends GetxController {
  List<User> topVolunteers = [];

  @override
  void onInit() {
    super.onInit();

    // بيانات وهمية
    topVolunteers = [
      User(
        id: 1,
        name: "سليم",
        email: "salim@gmail.com",
        phoneNumber: "0911111111",
        status: "active",
        profilePictureUrl: null,
        emailVerifiedAt: null,
        role: UserRole(id: 2, name: "متطوع"),
        volunteerDetails: VolunteerDetails(totalHoursVolunteered: "120"),
        createdAt: null,
        updatedAt: null,
      ),
      User(
        id: 2,
        name: "مها",
        email: "maha@gmail.com",
        phoneNumber: "0991111222",
        status: "active",
        profilePictureUrl: null,
        emailVerifiedAt: null,
        role: UserRole(id: 2, name: "متطوع"),
        volunteerDetails: VolunteerDetails(totalHoursVolunteered: "100"),
        createdAt: null,
        updatedAt: null,
      ),
      User(
        id: 3,
        name: "كريم",
        email: "karim@gmail.com",
        phoneNumber: "0932222333",
        status: "active",
        profilePictureUrl: null,
        emailVerifiedAt: null,
        role: UserRole(id: 2, name: "متطوع"),
        volunteerDetails: VolunteerDetails(totalHoursVolunteered: "90"),
        createdAt: null,
        updatedAt: null,
      ),
      User(
        id: 4,
        name: "ليلى",
        email: "laila@gmail.com",
        phoneNumber: "0964444555",
        status: "active",
        profilePictureUrl: null,
        emailVerifiedAt: null,
        role: UserRole(id: 2, name: "متطوع"),
        volunteerDetails: VolunteerDetails(totalHoursVolunteered: "70"),
        createdAt: null,
        updatedAt: null,
      ),
      User(
        id: 5,
        name: "فريدة",
        email: "farida@gmail.com",
        phoneNumber: "0964444555",
        status: "active",
        profilePictureUrl: null,
        emailVerifiedAt: null,
        role: UserRole(id: 2, name: "متطوع"),
        volunteerDetails: VolunteerDetails(totalHoursVolunteered: "75"),
        createdAt: null,
        updatedAt: null,
      ),
      User(
        id: 6,
        name: "فوزية",
        email: "Fozia@gmail.com",
        phoneNumber: "0964444555",
        status: "active",
        profilePictureUrl: null,
        emailVerifiedAt: null,
        role: UserRole(id: 2, name: "متطوع"),
        volunteerDetails: VolunteerDetails(totalHoursVolunteered: "140"),
        createdAt: null,
        updatedAt: null,
      ),
    ];
  }
}
