import 'package:flutter/material.dart';
import 'package:two_gis_hackaton/features/map/ui/map_page.dart';
import 'package:two_gis_hackaton/features/questionnary/data/questionnary_repository_mock.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/models/survey_result.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/usecases/send_survey_usecase.dart';

class InterestsSurveyWidget extends StatefulWidget {
  const InterestsSurveyWidget({super.key, required this.interests});

  final List<String> interests;

  @override
  State<InterestsSurveyWidget> createState() => _InterestsSurveyWidgetState();
}

class _InterestsSurveyWidgetState extends State<InterestsSurveyWidget> {
  final Map<String, bool> selectedInterests = {};

  @override
  void initState() {
    super.initState();
    selectedInterests.addEntries(
      widget.interests.map((e) => MapEntry(e, false)),
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
                  // side: BorderSide(color: Color(0xFF2FAD00), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isSelected
                          ? Colors.transparent
                          : Color(0xFF2FAD00),
                      width: 2,
                    ),
                  ),
                  elevation: isSelected ? 5 : 2,
                ),
                onPressed: () {
                  if (selectedInterests[interest] == null) return;
                  setState(() {
                    selectedInterests[interest] =
                        !(selectedInterests[interest]!);
                  });
                },
                child: Text(interest, style: const TextStyle(fontSize: 12)),
              );
            }).toList(),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            SendSurveyUseCase(QuestionnaryRepositoryMock())
                .execute(
                  SurveyResult(
                    selectedInterests.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList(),
                  ),
                )
                .then((success) {
                  if (success && context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => MapScreen()),
                    );
                  }
                });
          },
          child: Text('Продолжить'),
        ),
      ],
    );
  }
}
