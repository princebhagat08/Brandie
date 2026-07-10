import 'package:brandie/app/constant/theme/theme_extension.dart';
import 'package:flutter/material.dart';

class QuickShareSection extends StatelessWidget {
  const QuickShareSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 75,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Text(
              "Quick share to:",
              style: context.text.bodySmall,
            ),
            const SizedBox(width: 12),

            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final items = [
                    [Icons.camera_alt, Colors.pink],
                    [Icons.camera_alt, Colors.purple],
                    [Icons.facebook, Colors.blue],
                    [Icons.facebook, Colors.blue.shade700],
                    [Icons.message, Colors.purple],
                    [Icons.music_note, Colors.black],
                      [Icons.camera_alt, Colors.purple],
                    [Icons.facebook, Colors.blue],
                    [Icons.facebook, Colors.blue.shade700],
                    [Icons.message, Colors.purple],
                    [Icons.music_note, Colors.black],
                  ];

                  return _socialButton(
                    items[index][0] as IconData,
                    items[index][1] as Color,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon, Color color) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: color,
        child: Icon(
          icon,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}