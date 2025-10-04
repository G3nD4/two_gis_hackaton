import 'package:flutter/material.dart';
import 'package:two_gis_hackaton/core/di/service_locator.dart';
import 'package:two_gis_hackaton/features/map/ui/map_page.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/models/survey_result.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/repositories/i_prefs_repository.dart';

class InterestsSurveyWidget extends StatefulWidget {
  final List<String> interests;

  const InterestsSurveyWidget({super.key, required this.interests});

  @override
  State<InterestsSurveyWidget> createState() => _InterestsSurveyWidgetState();
}

class _InterestsSurveyWidgetState extends State<InterestsSurveyWidget> {
  late final Map<String, bool> selectedInterests;

  @override
  void initState() {
    super.initState();
    selectedInterests = {for (final e in widget.interests) e: false};
  }

  void _toggleInterest(String interest) {
    setState(
      () =>
          selectedInterests[interest] = !(selectedInterests[interest] ?? false),
    );
  }

  Future<void> _onContinuePressed() async {
    final chosen = selectedInterests.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    final result = UserPreferences(chosen);

    sl
        .get<IPrefsRepository>()
        .updateUserPreferences(result)
        .then(
          (value) => {
            if (value && mounted)
              {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const MapScreen()),
                ),
              },
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Выберите ваши интересы:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 8,
            childAspectRatio: 8,
            children: widget.interests.map((interest) {
              final isSelected = selectedInterests[interest] ?? false;
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: isSelected ? Colors.white : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected
                          ? Colors.transparent
                          : const Color(0xFF2FAD00),
                      width: 2,
                    ),
                  ),
                  elevation: isSelected ? 5 : 2,
                ),
                onPressed: () => _toggleInterest(interest),
                child: Text(interest, style: const TextStyle(fontSize: 12)),
              );
            }).toList(),
          ),
        ),
        ElevatedButton(
          onPressed: _onContinuePressed,
          child: const Text('Продолжить'),
        ),
      ],
    );
  }
}
