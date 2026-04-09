import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/theme.dart';
import '../constants/hobbies.dart';
import '../providers.dart';
import '../widgets/hobby_chip.dart';
import 'onboarding/hobbies_screen.dart';
import 'onboarding/skill_level_screen.dart';

class SettingsTab extends ConsumerWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerProvider);
    final notifEnabled = ref.watch(notificationsEnabledProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '[ SETTINGS ]',
                style: GoogleFonts.spaceMono(
                  color: kAccent,
                  fontSize: 11,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),

              // ── Notifications ──────────────────────────────────────────────
              _SectionHeader(label: 'NOTIFICATIONS'),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: kSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade800),
                ),
                child: SwitchListTile(
                  value: notifEnabled,
                  onChanged: (val) async {
                    ref.read(notificationsEnabledProvider.notifier).state =
                        val;
                    final notif = ref.read(notificationServiceProvider);
                    final storage =
                        await ref.read(storageServiceProvider.future);
                    if (val) {
                      await notif.scheduleDailyReminder();
                    } else {
                      await notif.cancelReminder();
                    }
                    await storage.saveNotificationsEnabled(val);
                  },
                  title: Text(
                    'DAILY REMINDER',
                    style: GoogleFonts.rajdhani(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  subtitle: Text(
                    '09:00 daily quest notification',
                    style: GoogleFonts.inter(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // ── Disciplines ────────────────────────────────────────────────
              _SectionHeader(label: 'DISCIPLINES'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade800),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: player.hobbies.map((h) {
                        return HobbyChip(hobby: h, selected: true, readonly: true);
                      }).toList(),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => _HobbiesEditWrapper(
                                initialSelected: player.hobbies,
                              ),
                            ),
                          );
                        },
                        child: const Text('EDIT DISCIPLINES'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // ── Skill Levels ───────────────────────────────────────────────
              _SectionHeader(label: 'SKILL LEVELS'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade800),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...player.hobbies.map((h) {
                      final level =
                          (player.hobbyLevels[h] ?? 'beginner').toUpperCase();
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Text(
                              h.toUpperCase(),
                              style: GoogleFonts.rajdhani(
                                color: Colors.white,
                                fontSize: 14,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              level,
                              style: GoogleFonts.spaceMono(
                                color: kAccent,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => _SkillEditWrapper(
                                hobbies: player.hobbies,
                                currentLevels: player.hobbyLevels,
                              ),
                            ),
                          );
                        },
                        child: const Text('EDIT SKILL LEVELS'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),

              // ── Danger Zone ────────────────────────────────────────────────
              _SectionHeader(label: 'DANGER ZONE', danger: true),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kSurface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kDanger.withOpacity(0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reset all progress, XP, rank, history, and settings. This cannot be undone.',
                      style: GoogleFonts.inter(
                        color: Colors.grey.shade500,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: kDanger,
                          side: const BorderSide(color: kDanger),
                        ),
                        onPressed: () => _confirmReset(context, ref),
                        child: const Text('RESET ALL PROGRESS'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: kSurface,
        title: Text(
          'RESET ALL PROGRESS',
          style: GoogleFonts.rajdhani(
            color: kDanger,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        content: Text(
          'This will erase all your XP, rank, history, and settings. You will need to complete onboarding again.',
          style: GoogleFonts.inter(color: Colors.grey.shade400, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('CANCEL',
                style: GoogleFonts.spaceMono(color: Colors.grey.shade500)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('RESET',
                style: GoogleFonts.spaceMono(color: kDanger)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(playerProvider.notifier).resetAll();
    }
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  final bool danger;

  const _SectionHeader({required this.label, this.danger = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.spaceMono(
        color: danger ? kDanger : Colors.grey.shade600,
        fontSize: 11,
        letterSpacing: 2,
      ),
    );
  }
}

// ── Edit wrappers ──────────────────────────────────────────────────────────────

/// Wraps HobbiesScreen in edit mode (saves changes back to player on return).
class _HobbiesEditWrapper extends ConsumerWidget {
  final List<String> initialSelected;

  const _HobbiesEditWrapper({required this.initialSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We reuse HobbiesScreen; after selection, route to SkillLevel in edit mode
    return HobbiesEditScreen(initialSelected: initialSelected);
  }
}

class HobbiesEditScreen extends ConsumerStatefulWidget {
  final List<String> initialSelected;

  const HobbiesEditScreen({super.key, required this.initialSelected});

  @override
  ConsumerState<HobbiesEditScreen> createState() =>
      _HobbiesEditScreenState();
}

class _HobbiesEditScreenState extends ConsumerState<HobbiesEditScreen> {
  late Set<String> _selected;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _selected = Set.from(widget.initialSelected);
  }

  void _toggle(String hobby) {
    setState(() {
      if (_selected.contains(hobby)) {
        _selected.remove(hobby);
      } else {
        _selected.add(hobby);
      }
    });
  }

  Future<void> _save() async {
    if (_selected.isEmpty) return;
    setState(() => _saving = true);
    final player = ref.read(playerProvider);
    // Keep existing levels; remove stale hobbies, add new ones as beginner
    final newLevels = <String, String>{};
    for (final h in _selected) {
      newLevels[h] = player.hobbyLevels[h] ?? 'beginner';
    }
    await ref
        .read(playerProvider.notifier)
        .updateHobbies(_selected.toList(), newLevels);
    // Regenerate quests with new hobbies
    await ref.read(dailyQuestsProvider.notifier).regenerate(ref.read(playerProvider));
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'EDIT DISCIPLINES',
                    style: GoogleFonts.rajdhani(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: hobbyCategories.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 16),
                          child: Text(
                            entry.key.toUpperCase(),
                            style: GoogleFonts.spaceMono(
                              color: Colors.grey.shade600,
                              fontSize: 11,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        Wrap(
                          children: entry.value.map((hobby) {
                            return HobbyChip(
                              hobby: hobby,
                              selected: _selected.contains(hobby),
                              onTap: () => _toggle(hobby),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (_selected.isEmpty || _saving) ? null : _save,
                  child: _saving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('SAVE DISCIPLINES'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillEditWrapper extends ConsumerWidget {
  final List<String> hobbies;
  final Map<String, String> currentLevels;

  const _SkillEditWrapper(
      {required this.hobbies, required this.currentLevels});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SkillLevelEditScreen(
        hobbies: hobbies, currentLevels: currentLevels);
  }
}

class SkillLevelEditScreen extends ConsumerStatefulWidget {
  final List<String> hobbies;
  final Map<String, String> currentLevels;

  const SkillLevelEditScreen(
      {super.key, required this.hobbies, required this.currentLevels});

  @override
  ConsumerState<SkillLevelEditScreen> createState() =>
      _SkillLevelEditScreenState();
}

class _SkillLevelEditScreenState
    extends ConsumerState<SkillLevelEditScreen> {
  late Map<String, String> _levels;
  bool _saving = false;

  static const _options = ['beginner', 'intermediate', 'advanced'];
  static const _labels = ['BEGINNER', 'INTERMEDIATE', 'ADVANCED'];

  @override
  void initState() {
    super.initState();
    _levels = Map.from(widget.currentLevels);
    for (final h in widget.hobbies) {
      _levels[h] ??= 'beginner';
    }
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    await ref
        .read(playerProvider.notifier)
        .updateHobbies(widget.hobbies, _levels);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'SKILL LEVELS',
                    style: GoogleFonts.rajdhani(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: widget.hobbies.length,
                itemBuilder: (ctx, i) {
                  final hobby = widget.hobbies[i];
                  final cur = _levels[hobby] ?? 'beginner';
                  final sel = _options.indexOf(cur);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
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
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: List.generate(_options.length, (j) {
                            final isSel = j == sel;
                            return Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => _levels[hobby] = _options[j]),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  margin: EdgeInsets.only(
                                      right: j < _options.length - 1 ? 6 : 0),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  decoration: BoxDecoration(
                                    color: isSel
                                        ? kAccent.withOpacity(0.15)
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: isSel
                                          ? kAccent
                                          : Colors.grey.shade700,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    _labels[j],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.spaceMono(
                                      fontSize: 9,
                                      color: isSel
                                          ? kAccent
                                          : Colors.grey.shade600,
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saving ? null : _save,
                  child: _saving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('SAVE CHANGES'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
