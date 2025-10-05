import 'package:flutter/material.dart';
import 'package:two_gis_hackaton/core/startup/startup_service.dart';
import 'package:two_gis_hackaton/features/questionnary/ui/survey_widget.dart';

class QuestionnaryPage extends StatelessWidget {
  final List<SurveyData> interests;

  const QuestionnaryPage({super.key, required this.interests});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выберите ваши интересы:')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InterestsSurveyWidget(interests: interests),
      ),
    );
  }
}
