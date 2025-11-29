import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/theme.dart';

class AnimatedCheckboxTile extends StatefulWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const AnimatedCheckboxTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  State<AnimatedCheckboxTile> createState() => _AnimatedCheckboxTileState();
}

class _AnimatedCheckboxTileState extends State<AnimatedCheckboxTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _checkAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _checkAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    if (widget.value) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(AnimatedCheckboxTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onChanged(!widget.value),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Animated Checkbox
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.value ? AppTheme.primaryColor : Colors.grey,
                    width: 2,
                  ),
                  color: widget.value ? AppTheme.primaryColor : Colors.transparent,
                ),
                child: widget.value
                    ? FadeTransition(
                        opacity: _checkAnimation,
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 16),
            
            // Title
            Expanded(
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      decoration: widget.value ? TextDecoration.lineThrough : null,
                      color: widget.value 
                          ? Colors.grey 
                          : Theme.of(context).textTheme.bodyLarge?.color,
                    ),
              ),
            ),
            
            // Time indicator (if task has time)
            if (widget.title.contains('min'))
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.timer, size: 14, color: AppTheme.accentColor),
                    const SizedBox(width: 4),
                    Text(
                      _extractTime(widget.title),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _extractTime(String title) {
    final match = RegExp(r'\((\d+(?:-\d+)?\s*min)\)').firstMatch(title);
    return match?.group(1) ?? '';
  }
}
