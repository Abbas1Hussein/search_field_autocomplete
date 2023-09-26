import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/extensions.dart';
import '../translations/translation_service.dart';

class DefaultEmptySuggestionsWidget extends StatefulWidget {
  final bool isIOS;

  final String value;

  const DefaultEmptySuggestionsWidget(
    this.value, {
    Key? key,
    required this.isIOS,
  }) : super(key: key);

  @override
  _DefaultEmptySuggestionsWidgetState createState() => _DefaultEmptySuggestionsWidgetState();
}

class _DefaultEmptySuggestionsWidgetState extends State<DefaultEmptySuggestionsWidget>
    with SingleTickerProviderStateMixin {
  static const _edgeInsets = EdgeInsets.all(8.0);

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
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
    final locale = Localizations.localeOf(context).languageCode;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return SizeTransition(
          sizeFactor: _animation,
          child: Container(
            margin: _edgeInsets,
            padding: _edgeInsets,
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                stops: const [0.007, 0.007],
                colors: [CupertinoColors.destructiveRed, linearGradientColors],
              ),
              boxShadow: widget.isIOS ? null : elevations,
              borderRadius: BorderRadius.circular(_edgeInsets.horizontal),
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.search_off, size: 48.0, color: Colors.grey),
                  const SizedBox(height: 8.0),
                  Text(
                    '${TranslationService.translate('noResultsFound', locale)}: ${widget.value.trim()}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    textDirection: TranslationService.textDirection(locale),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    TranslationService.translate('tryDifferentTerm', locale),
                    style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                    textDirection: TranslationService.textDirection(locale),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color get linearGradientColors {
    if (widget.isIOS) {
      return CupertinoColors.tertiarySystemFill;
    } else {
      return Theme.of(context).cardColor;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
