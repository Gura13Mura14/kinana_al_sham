import 'package:get/get.dart';
import '../services/course_api_service.dart';

class VoteController extends GetxController {
  var votesMap = <int, RxInt>{};
  RxInt getVotes(int courseId) {
    votesMap.putIfAbsent(courseId, () => 0.obs);
    return votesMap[courseId]!;
  }

  Future<void> vote(int courseId) async {
    final data = await ApiService.postRequest("$courseId/vote");
    if (data['success']) {
      getVotes(courseId).value = data['total_votes'];
    }
  }
}
