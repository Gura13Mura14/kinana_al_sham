import 'package:get/get.dart';
import 'package:kinana_al_sham/services/course_api_service.dart';
import '../models/vote_response.dart';

class VoteController extends GetxController {
  final ApiService api = ApiService();

  var voting = false.obs;
  var votesMap = <int, RxInt>{}; // key: courseId, value: votes count

  Future<void> vote(int courseId) async {
    try {
      voting.value = true;
      final res = await api.postVote(courseId);
      if (res.success) {
        if (!votesMap.containsKey(courseId)) {
          votesMap[courseId] = res.totalVotes.obs;
        } else {
          votesMap[courseId]!.value = res.totalVotes;
        }
      }
    } finally {
      voting.value = false;
    }
  }

  RxInt getVotes(int courseId) {
    if (!votesMap.containsKey(courseId)) {
      votesMap[courseId] = 0.obs;
    }
    return votesMap[courseId]!;
  }
}
