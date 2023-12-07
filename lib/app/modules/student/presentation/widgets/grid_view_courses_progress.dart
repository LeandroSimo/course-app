import 'package:flutter/material.dart';

class GridViewCoursesProgress extends StatelessWidget {
  const GridViewCoursesProgress({
    super.key,
    required this.size,
    required this.coursesProgress,
  });

  final Size size;
  final List coursesProgress;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: coursesProgress.length,
        itemBuilder: (_, index) {
          final course = coursesProgress[index];

          final color = coursesProgress[index].isNotEmpty
              ? int.parse(course['color'].toString().replaceAll('#', '0xFF'))
              : 0xFF000000;
          final _coursesProgress = _checkCourseName(course['name'].toString());
          final _percent = course['percent'];
          final progress = course['progress'].toString();

          return Card(
            elevation: 4,
            child: Container(
              width: size.width * 0.22,
              height: size.height * 0.12,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    _coursesProgress,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Color(color),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Progresso",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple.shade900,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text.rich(
                        TextSpan(
                          text: progress,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange.shade700,
                          ),
                          children: [
                            TextSpan(
                              text: "/35",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.purple.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    value: _percent,
                    minHeight: 10,
                    backgroundColor: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.orange.shade400,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _checkCourseName(String originalName) {
    if (originalName.contains(' ')) {
      final parts = originalName.split(' ');
      if (parts.length >= 2) {
        return '${parts[0][0]}${parts[1][0]}';
      }
    }
    return originalName;
  }
}
