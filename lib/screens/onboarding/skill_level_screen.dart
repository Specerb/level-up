import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/theme.dart';
import '../../providers.dart';

class SkillLevelScreen extends ConsumerStatefulWidget {
  final String name;
  final List<String> hobbies;

  const SkillLevelScreen({
    super.key,
    required this.name,
    required this.hobbies,
  });

  @override
  ConsumerState<SkillLevelScreen> createState() => _SkillLevelScreenState();
}

class _SkillLevelScreenState extends ConsumerState<SkillLevelScreen> {
  late Map<String, String> _levels;
  bool _loading = false;

  static const _options = ['beginner', 'intermediate', 'advanced'];
  static const _labels = ['BEGINNER', 'INTERMEDIATE', 'ADVANCED'];

  @override
  void initState() {
    super.initState();
    _levels = {for (final h in widget.hobbies) h: 'beginner'};
  }

  Future<void> _onGetStarted() async {
    setState(() => _loading = true);

    await ref.read(playerProvider.notifier).completeOnboarding(
          name: widget.name,
          hobbies: widget.hobbies,
          hobbyLevels: _levels,
        );

    final notif = ref.read(notificationServiceProvider);
    await notif.requestPermission();
    await notif.scheduleDailyReminder();

    final player = ref.read(playerProvider);
    await ref.read(dailyQuestsProvider.notifier).regenerate(player);

    // Routing gate in main.dart handles navigation automatically
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '[ ONBOARDING ]',
                        style: GoogleFonts.spaceMono(
                          color: kAccent,
                          fontSize: 11,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'STEP 2 OF 2',
                        style: GoogleFonts.spaceMono(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'SKILL LEVELS',
                    style: GoogleFonts.rajdhani(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Rate your current level in each discipline.',
                    style: GoogleFonts.inter(
                      color: Colors.grey.shade500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                itemCount: widget.hobbies.length,
                itemBuilder: (context, index) {
                  final hobby = widget.hobbies[index];
                  final currentLevel = _levels[hobby] ?? 'beginner';
                  final selectedIndex = _options.indexOf(currentLevel);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kSurface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade800),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hobby.toUpperCase(),
                          style: GoogleFonts.rajdhani(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: List.generate(_options.length, (i) {
                            final isSelected = i == selectedIndex;
                            return Expanded(
                              child: GestureDetector(
                                onTap: () => setState(
                                    () => _levels[hobby] = _options[i]),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  margin: EdgeInsets.only(
                                      right: i < _options.length - 1 ? 6 : 0),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? kAccent.withOpacity(0.15)
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: isSelected
                                          ? kAccent
                                          : Colors.grey.shade700,
                                      width: isSelected ? 1.5 : 1,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    _labels[i],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.spaceMono(
                                      fontSize: 9,
                                      color: isSelected
                                          ? kAccent
                                          : Colors.grey.shade600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _onGetStarted,
                  child: _loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('GET STARTED'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
