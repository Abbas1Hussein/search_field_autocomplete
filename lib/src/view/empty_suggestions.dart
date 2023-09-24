import 'package:flutter/material.dart';

class EmptySuggestionsBuilderWidget extends StatefulWidget {
  final String value;

  const EmptySuggestionsBuilderWidget(this.value, {Key? key}) : super(key: key);

  @override
  _EmptySuggestionsBuilderWidgetState createState() =>
      _EmptySuggestionsBuilderWidgetState();
}

class _EmptySuggestionsBuilderWidgetState
    extends State<EmptySuggestionsBuilderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // Initialize the animation controller
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    // Create a Tween for the opacity property
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // Start the animation when the widget is built
    _controller.fling();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizeTransition(
          sizeFactor: _animation,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.red.shade600, width: 2.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.search_off, size: 48.0, color: Colors.grey),
                const SizedBox(height: 8.0),
                Text(
                  'No Results Found: ${widget.value}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Try a different search term.',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose of the animation controller when it's no longer needed
    _controller.dispose();
    super.dispose();
  }
}
