import 'package:flutter/material.dart';
import 'package:two_gis_hackaton/features/questionnary/domain/usecases/send_survey_usecase.dart';
import 'package:two_gis_hackaton/survey_widget.dart';

class QuestionnaryPage extends StatelessWidget {
  final List<String> interests;
  final SendSurveyUseCase sendSurveyUseCase;

  const QuestionnaryPage({
    super.key,
    required this.interests,
    required this.sendSurveyUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Опрос')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InterestsSurveyWidget(
          interests: interests,
          sendSurveyUseCase: sendSurveyUseCase,
        ),
      ),
    );
  }
}
