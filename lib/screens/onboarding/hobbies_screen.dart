import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/theme.dart';
import '../../constants/hobbies.dart';
import '../../widgets/hobby_chip.dart';
import 'skill_level_screen.dart';

class HobbiesScreen extends StatefulWidget {
  final String name;

  const HobbiesScreen({super.key, required this.name});

  @override
  State<HobbiesScreen> createState() => _HobbiesScreenState();
}

class _HobbiesScreenState extends State<HobbiesScreen> {
  final Set<String> _selected = {};

  void _toggle(String hobby) {
    setState(() {
      if (_selected.contains(hobby)) {
        _selected.remove(hobby);
      } else {
        _selected.add(hobby);
      }
    });
  }

  void _onContinue() {
    if (_selected.isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SkillLevelScreen(
          name: widget.name,
          hobbies: _selected.toList(),
        ),
      ),
    );
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
                        'STEP 1 OF 2',
                        style: GoogleFonts.spaceMono(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'SELECT YOUR\nDISCIPLINES',
                    style: GoogleFonts.rajdhani(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.1,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Choose at least one area to train.',
                    style: GoogleFonts.inter(
                      color: Colors.grey.shade500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selected.isEmpty ? null : _onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _selected.isEmpty ? Colors.grey.shade800 : kAccent,
                    foregroundColor: _selected.isEmpty
                        ? Colors.grey.shade600
                        : Colors.white,
                  ),
                  child: const Text('CONTINUE'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
