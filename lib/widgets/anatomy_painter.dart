class AnatomyPainter extends CustomPainter {
  final Color color;

  AnatomyPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final center = Offset(size.width / 2, size.height / 2);
    
    // Draw abstract anatomy shapes based on "math code" request
    // Lungs/Chest area
    final path = Path();
    path.moveTo(center.dx - 40, center.dy - 30);
    path.quadraticBezierTo(center.dx - 60, center.dy, center.dx - 40, center.dy + 40);
    path.quadraticBezierTo(center.dx, center.dy + 50, center.dx + 40, center.dy + 40);
    path.quadraticBezierTo(center.dx + 60, center.dy, center.dx + 40, center.dy - 30);
    path.close();
    
    canvas.drawPath(path, paint);
    
    // Diaphragm line
    final diaphragmPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
      
    canvas.drawArc(
      Rect.fromCenter(center: Offset(center.dx, center.dy + 20), width: 100, height: 40),
      3.14,
      3.14,
      false,
      diaphragmPaint,
    );

    // Activity indicators (circles)
    final circlePaint = Paint()
      ..color = color.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(center.dx, center.dy + 40), 4, circlePaint);
    canvas.drawCircle(Offset(center.dx - 30, center.dy + 10), 3, circlePaint);
    canvas.drawCircle(Offset(center.dx + 30, center.dy + 10), 3, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
