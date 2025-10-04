import 'package:flutter/material.dart';

class InterestsSurveyWidget extends StatefulWidget {
  const InterestsSurveyWidget({super.key});

  @override
  State<InterestsSurveyWidget> createState() => _InterestsSurveyWidgetState();
}

class _InterestsSurveyWidgetState extends State<InterestsSurveyWidget> {
  final List<String> interests = [
    '💪 Спорт',
    '🚶 Прогулки',
    '☕ Кафе',
    '🍽️ Рестораны',
    '🎬 Кино',
    '🏛️ Музеи',
    '🛍️ Шоппинг',
    '🎭 Театр',
    '🌳 Парки',
    '🪩 Ночные клубы',
    '💆🏻‍♀️ Спа',
    '🏃🏻 Фитнес',
    '🎫 Концерты',
    '🖼️ Выставки',
  ];

  final Set<String> selectedInterests = {};

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
            children: interests.map((interest) {
              final isSelected = selectedInterests.contains(interest);
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isSelected
                      ? Color(0xFF2FAD00)
                      : Colors.white,
                  foregroundColor: isSelected ? Colors.white : Colors.black,
                  side: BorderSide(color: Color(0xFF2FAD00), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: isSelected ? 5 : 2,
                ),
                onPressed: () {
                  setState(() {
                    if (isSelected) {
                      selectedInterests.remove(interest);
                    } else {
                      selectedInterests.add(interest);
                    }
                  });
                },
                child: Text(interest, style: const TextStyle(fontSize: 12)),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: ElevatedButton(
            onPressed: selectedInterests.isEmpty
                ? null
                : () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Спасибо!'),
                        content: Text(
                          'Вы выбрали: ${selectedInterests.join(", ")}',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
            child: Text('Отправить'),
          ),
        ),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('2GIS Uranus')),
      body: Center(
        child: MultichoiseAnquet(choices: ['huihuihuihuihui', 'asasdakdjaski']),
      ),
    );
  }
}

class MultichoiseAnquet extends StatelessWidget {
  const MultichoiseAnquet({required this.choices});

  final List<String> choices;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: choices
            .map<Widget>((e) => ChoiseCardWidget(title: e))
            .toList(),
      ),
    );
  }
}

class ChoiseCardWidget extends StatefulWidget {
  const ChoiseCardWidget({required this.title});

  final String title;

  @override
  State<ChoiseCardWidget> createState() => _ChoiseCardWidgetState();
}

class _ChoiseCardWidgetState extends State<ChoiseCardWidget> {
  bool choosen = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            choosen ? Colors.green : Colors.red,
          ),
        ),
        onPressed: () {
          if (!mounted) return;
          setState(() {
            choosen = !choosen;
          });
        },
        child: Text(widget.title, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
