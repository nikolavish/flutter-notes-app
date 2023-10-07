import 'package:flutter/material.dart';

class TagComponent extends StatefulWidget {
  final String label;
  final bool active;

  const TagComponent({super.key, required this.label, required this.active});

  @override
  State<TagComponent> createState() => _TagComponentState();
}

class _TagComponentState extends State<TagComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          color: widget.active ? const Color(0xFFFE6902) : null,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
              color: widget.active ? Colors.transparent : const Color(0xFFFE6902))),
      child: Text(
        "#${widget.label}",
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: widget.active ? Colors.black : const Color(0xFFFE6902)),
      ),
    );
  }
}
