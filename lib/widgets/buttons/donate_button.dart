import 'dart:async';
import 'package:app_manager/utils/localization.dart';
import 'package:app_manager/utils/url.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DonateButton extends StatefulWidget {
  const DonateButton({super.key});

  @override
  _DonateButtonState createState() => _DonateButtonState();
}

class _DonateButtonState extends State<DonateButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _shine;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reset();
              _timer = Timer(const Duration(seconds: 8), () {
                if (mounted) _controller.forward();
              });
            }
          });
    _shine = Tween<double>(begin: -1.5, end: 1.5)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: Localization.languageNotifier,
      builder: (context, languageCode, child) {
        return FadeIn(
          duration: const Duration(milliseconds: 300),
          child: AnimatedBuilder(
            animation: _shine,
            builder: (context, child) => Tooltip(
              message: Localization.translate('support_tooltip'),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => UrlUtils.launchUrlOrShow(
                      context, 'https://buymeacoffee.com/blassgo'),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                      gradient: LinearGradient(
                        begin: Alignment(_shine.value - 1, 0),
                        end: Alignment(_shine.value + 1, 0),
                        colors: [
                          Colors.transparent,
                          Colors.white.withOpacity(0.2),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.favorite,
                            color: Colors.white, size: 16),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            Localization.translate('support'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
