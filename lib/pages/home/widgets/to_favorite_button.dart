import 'package:flutter/material.dart';

class SaveToFavouritesWidget extends StatefulWidget {
  const SaveToFavouritesWidget({super.key});

  @override
  State<SaveToFavouritesWidget> createState() => _SaveToFavouritesWidgetState();
}

class _SaveToFavouritesWidgetState extends State<SaveToFavouritesWidget> {
  final bool isSaved = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: const BoxDecoration(
        color: Color.fromARGB(180, 255, 255, 255),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isSaved ? Icons.favorite : Icons.favorite_border,
        color: isSaved ? Colors.red : null,
        semanticLabel: isSaved ? 'Remove from saved' : 'Save',
      ),
    );
  }
}
