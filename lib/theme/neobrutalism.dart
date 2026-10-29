import 'package:flutter/material.dart';

class NeoColors {
  static const Color background = Color(0xFFF7F4EB);
  static const Color card = Colors.white;
  static const Color black = Color(0xFF141414);
  static const Color primary = Color(0xFFFFDE59);
  static const Color secondary = Color(0xFF7EE8FA);
  static const Color accent = Color(0xFFC4B5FD);
  static const Color pink = Color(0xFFFF90B3);
  static const Color mint = Color(0xFFA7F3D0);
  static const Color red = Color(0xFFFF6B6B);

  static const List<Color> noteColors = [
    Color(0xFFFFF099),
    Color(0xFFB8F3D1),
    Color(0xFFFFB8D2),
    Color(0xFFBAE6FD),
    Color(0xFFE9D5FF),
  ];
}

class NeoBox {
  static BoxDecoration decoration({
    Color color = Colors.white,
    double radius = 10,
    double borderWidth = 2.5,
    Offset shadowOffset = const Offset(4, 4),
    Color borderColor = NeoColors.black,
    Color shadowColor = NeoColors.black,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor, width: borderWidth),
      boxShadow: shadowOffset == Offset.zero
          ? null
          : [
              BoxShadow(
                color: shadowColor,
                offset: shadowOffset,
                blurRadius: 0,
              ),
            ],
    );
  }
}

class NeoButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color color;
  final double radius;
  final EdgeInsetsGeometry padding;
  final double borderWidth;
  final bool fullWidth;

  const NeoButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color = NeoColors.primary,
    this.radius = 10,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    this.borderWidth = 2.5,
    this.fullWidth = true,
  });

  @override
  State<NeoButton> createState() => _NeoButtonState();
}

class _NeoButtonState extends State<NeoButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final offset = _isPressed ? const Offset(1, 1) : const Offset(4, 4);

    Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 60),
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(widget.radius),
        border: Border.all(color: NeoColors.black, width: widget.borderWidth),
        boxShadow: [
          BoxShadow(
            color: NeoColors.black,
            offset: offset,
            blurRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            color: NeoColors.black,
            fontWeight: FontWeight.w800,
            fontSize: 15,
            letterSpacing: 0.2,
          ),
          child: widget.child,
        ),
      ),
    );

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: widget.fullWidth ? SizedBox(width: double.infinity, child: content) : content,
    );
  }
}

class NeoBadge extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final double fontSize;

  const NeoBadge({
    super.key,
    required this.text,
    this.color = Colors.white,
    this.textColor = NeoColors.black,
    this.fontSize = 11,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: NeoColors.black, width: 1.8),
        boxShadow: const [
          BoxShadow(
            color: NeoColors.black,
            offset: Offset(2, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
