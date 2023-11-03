import 'package:flutter/material.dart';

class SavePrintButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  SavePrintButton({required this.text, required this.onPressed});

  @override
  _SavePrintButtonState createState() => _SavePrintButtonState();
}

class _SavePrintButtonState extends State<SavePrintButton>
    with TickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.green, // Change the end color as needed
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: _isPressed ? 60.0 : double.infinity,
          decoration: BoxDecoration(
            color: _colorAnimation.value,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _isPressed = !_isPressed;
              });
              if (_isPressed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
              widget.onPressed();
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              primary: Colors.transparent, // Button background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: _isPressed
                ? Icon(
              Icons.check,
              color: Colors.white,
            )
                : Text(
              widget.text,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
