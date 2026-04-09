import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/theme.dart';
import 'hobbies_screen.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _controller = TextEditingController();
  bool _hasError = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onContinue() {
    if (_controller.text.trim().isEmpty) {
      setState(() => _hasError = true);
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HobbiesScreen(name: _controller.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '[ DAILY BRIEF ]',
                style: GoogleFonts.spaceMono(
                  color: kAccent,
                  fontSize: 12,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'PROFILE\nSETUP',
                style: GoogleFonts.rajdhani(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.1,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'What should we call you, operative?',
                style: GoogleFonts.inter(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 48),
              TextField(
                controller: _controller,
                onChanged: (_) {
                  if (_hasError) setState(() => _hasError = false);
                },
                onSubmitted: (_) => _onContinue(),
                style: GoogleFonts.rajdhani(
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 1,
                ),
                cursorColor: kAccent,
                decoration: InputDecoration(
                  labelText: 'YOUR NAME',
                  errorText: _hasError ? 'Enter a name to continue' : null,
                  errorStyle: GoogleFonts.spaceMono(
                      color: kDanger, fontSize: 11),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onContinue,
                  child: const Text('CONTINUE'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
