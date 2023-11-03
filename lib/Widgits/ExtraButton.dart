import 'package:flutter/material.dart';

class ExtraButton extends StatefulWidget {
  final IconData icon;
  final String text;
  final Function()? onPressed;

  ExtraButton({
    required this.icon,
    required this.text,
    this.onPressed,
  });

  @override
  _ExtraButtonState createState() => _ExtraButtonState();
}

class _ExtraButtonState extends State<ExtraButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        width: _isPressed ? 40.0 : 50.0, // Adjust the size as needed
        height: _isPressed ? 80.0 : 70.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: _isPressed
              ? Theme.of(context).primaryColor.withOpacity(0.8)
              : Theme.of(context).primaryColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              size: _isPressed ? 35.0 : 30.0, // Adjust the size as needed
              color: Colors.white,
            ),
            SizedBox(height: 10.0),
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
