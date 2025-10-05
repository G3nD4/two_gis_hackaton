import 'package:flutter/material.dart';
import 'package:two_gis_hackaton/core/di/service_locator.dart';
import 'package:two_gis_hackaton/core/startup/startup_service.dart';
import 'package:two_gis_hackaton/features/map/ui/map_page.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/models/survey_result.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/repositories/i_prefs_repository.dart';

class InterestsSurveyWidget extends StatefulWidget {
  final List<SurveyData> interests;

  const InterestsSurveyWidget({super.key, required this.interests});

  @override
  State<InterestsSurveyWidget> createState() => _InterestsSurveyWidgetState();
}

class _InterestsSurveyWidgetState extends State<InterestsSurveyWidget> {
  late final Map<String, bool> selectedInterests;

  @override
  void initState() {
    super.initState();
    selectedInterests = {for (final e in widget.interests) e.key: false};
  }

  void _toggleInterest(SurveyData interest) {
    setState(
      () =>
          selectedInterests[interest.key] = !(selectedInterests[interest.key] ?? false),
    );
  }

  bool get _nothingSelected =>
      selectedInterests.values.every((isSelected) => !isSelected);

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
            mainAxisSpacing: 10,
            childAspectRatio: 4,
            children: widget.interests.map((interest) {
              final isSelected = selectedInterests[interest.key] ?? false;
              return OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: isSelected ? Colors.white : Colors.black,
                  backgroundColor: isSelected
                      ? const Color(0xFF2FAD00)
                      : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(
                    color: isSelected ? Colors.transparent : Colors.grey[400]!,
                    width: 1,
                  ),
                ),
                onPressed: () => _toggleInterest(interest),
                child: Text(
                  interest.value,
                  style: const TextStyle(fontSize: 14),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2FAD00),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: _nothingSelected ? null : _onContinuePressed,
            child: const Text('Продолжить', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
