import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kinana_al_sham/controllers/HonorBoardController.dart';
import 'package:kinana_al_sham/theme/AppColors.dart';
import 'package:confetti/confetti.dart';
import 'package:animated_background/animated_background.dart';
import 'package:kinana_al_sham/views/HonerBoard/top_bar_chart.dart';

class HonorBoardPage extends StatefulWidget {
  @override
  State<HonorBoardPage> createState() => _HonorBoardPageState();
}

class _HonorBoardPageState extends State<HonorBoardPage>
    with TickerProviderStateMixin {
  final controller = Get.put(HonorBoardController());

  final List<Color> medalColors = [
    Colors.transparent,
    Color(0xFFFFD700),
    Color(0xFFC0C0C0),
    Color(0xFFCD7F32),
  ];

  late ConfettiController confettiController;

  @override
  void initState() {
    super.initState();
    confettiController = ConfettiController(duration: Duration(seconds: 3));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      confettiController.play(); // تبدأ الزينة عند تحميل الصفحة
    });
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        body: AnimatedBackground(
          behaviour: RandomParticleBehaviour(
            options: ParticleOptions(
              baseColor: Colors.orangeAccent,
              spawnOpacity: 0.0,
              opacityChangeRate: 0.25,
              minOpacity: 0.1,
              maxOpacity: 0.4,
              particleCount: 30,
              spawnMaxRadius: 15.0,
              spawnMaxSpeed: 100.0,
              spawnMinSpeed: 30,
              spawnMinRadius: 7.0,
            ),
          ),
          vsync: this,
          child: Stack(
            children: [
              GetBuilder<HonorBoardController>(
                builder: (_) {
                  final top3 = controller.topVolunteers.take(3).toList();
                  final others = controller.topVolunteers.skip(3).toList();

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: [Colors.orange, Colors.pink, Colors.red],
                            ).createShader(bounds);
                          },
                          child: const Text(
                            'لوحة الشرف',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        if (top3.isNotEmpty)
                          TopBarChart(
                            names:
                                controller.topVolunteers
                                    .take(3)
                                    .map((v) => v.name)
                                    .toList(),
                            hours:
                                controller.topVolunteers.take(3).map((v) {
                                  final raw =
                                      v.volunteerDetails?.totalHoursVolunteered;
                                  return double.tryParse(raw ?? '0') ?? 0.0;
                                }).toList(),
                          ),

                        const SizedBox(height: 40),
                        const Divider(thickness: 1.5),
                        const SizedBox(height: 16),
                        ...others.map(
                          (user) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppColors.pinkBeige,
                                radius: 25,
                                child: Text(
                                  user.name[0],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              title: Text(user.name),
                              subtitle: Text(
                                "عدد ساعات التطوع: ${user.volunteerDetails?.totalHoursVolunteered ?? '0'} ساعة",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  maxBlastForce: 20,
                  minBlastForce: 5,
                  emissionFrequency: 0.1,
                  numberOfParticles: 20,
                  gravity: 0.3,
                  colors: const [
                    Colors.orange,
                    Colors.pink,
                    Colors.amber,
                    Colors.redAccent,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPodiumItem(user, int place) {
    final height = [0.0, 130.0, 110.0, 90.0][place];
    final color = medalColors[place];

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: color,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.pinkBeige,
                child: Text(
                  user != null ? user.name[0] : '?',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -4,
              right: 0,
              child: Icon(
                place == 1
                    ? Icons.emoji_events
                    : place == 2
                    ? Icons.emoji_events_outlined
                    : Icons.military_tech,
                color: color,
                size: 24,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: 60,
          height: height.toDouble(),
          decoration: BoxDecoration(
            color: AppColors.bluishGray,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            '$place',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          user != null ? user.name : '---',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          user != null
              ? '${user.volunteerDetails?.totalHoursVolunteered ?? 0} ساعة'
              : '',
          style: const TextStyle(color: Colors.black54),
        ),
      ],
    );
  }
}
