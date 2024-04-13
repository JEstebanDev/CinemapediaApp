import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      "Loading Movies 🎥️",
      "Cooking pop-corns 🍿",
      "Loading Popular Movies 📽️",
      "Calling my beyonce 💖",
      "Loading up coming movies 🎭",
    ];
    return Stream.periodic(const Duration(milliseconds: 1200),
        (computationCount) => messages[computationCount]).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Wait please...",
                style: textStyle.titleMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              const CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ],
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 30,
            child: Container(
              color: Colors.blue.shade100,
              alignment: Alignment.center,
              child: StreamBuilder(
                  stream: getLoadingMessages(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Text("Loading...",style: textStyle.bodyMedium,);
                    return Text(snapshot.data!,style: textStyle.bodyMedium,);
                  }),
            ))
      ],
    );
  }
}
