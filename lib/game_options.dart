import 'package:flutter/material.dart';

class Options extends StatefulWidget {
  const Options(
      {Key? key,
      required this.handleOptionsChange,
      required this.savedDifficulty})
      : super(key: key);
  final Function handleOptionsChange;
  final DificultyLevels savedDifficulty;

  @override
  OptionsState createState() {
    return OptionsState();
  }
}

enum DificultyLevels { superEasy, easy, normal, hard }

extension ParseToString on DificultyLevels {
  String toShortString() {
    return toString().split('.').last;
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class OptionsState extends State<Options> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.

  @override
  Widget build(BuildContext context) {
    DificultyLevels? difficulty = widget.savedDifficulty;

    void handleChange(DificultyLevels? value) {
      widget.handleOptionsChange(value);
      setState(() {
        difficulty = value;
      });
    }

    return SafeArea(
      child: Column(
        children: <Widget>[
          const Text(
            "Options",
            style: TextStyle(fontSize: 30),
          ),
          ListTile(
            title: const Text('Super Easy'),
            leading: Radio<DificultyLevels>(
              value: DificultyLevels.superEasy,
              groupValue: difficulty,
              onChanged: handleChange,
            ),
          ),
          ListTile(
            title: const Text('Easy'),
            leading: Radio<DificultyLevels>(
              value: DificultyLevels.easy,
              groupValue: difficulty,
              onChanged: handleChange,
            ),
          ),
          ListTile(
            title: const Text('Normal'),
            leading: Radio<DificultyLevels>(
              value: DificultyLevels.normal,
              groupValue: difficulty,
              onChanged: handleChange,
            ),
          ),
          ListTile(
            title: const Text('Hard'),
            leading: Radio<DificultyLevels>(
              value: DificultyLevels.hard,
              groupValue: difficulty,
              onChanged: handleChange,
            ),
          ),
        ],
      ),
    );
  }
}
