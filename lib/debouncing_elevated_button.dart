import 'dart:async';

import 'package:flutter/material.dart';

class DebouncingElevatedButton extends StatefulWidget {
  const DebouncingElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.clipBehavior,
    this.statesController,
    this.iconAlignment = IconAlignment.start,
    this.autofocus = false,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Duration debounceDuration;
  final VoidCallback? onLongPress;
  final void Function(bool)? onHover;
  final void Function(bool)? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip? clipBehavior;
  final WidgetStatesController? statesController;
  final IconAlignment iconAlignment;

  @override
  State<DebouncingElevatedButton> createState() => _DebouncingElevatedButtonState();
}

class _DebouncingElevatedButtonState extends State<DebouncingElevatedButton> {
  bool _isProcessing = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _isProcessing = widget.onPressed == null;
  }

  void _handleTap() {
    _isProcessing = true;
    if (widget.onPressed != null) {
      widget.onPressed!();
    }

    _debounceTimer = Timer(
      widget.debounceDuration,
      () {
        _isProcessing = false;
      },
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isProcessing ? null : _handleTap,
      onLongPress: widget.onLongPress,
      onFocusChange: widget.onFocusChange,
      onHover: widget.onHover,
      style: widget.style,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      clipBehavior: widget.clipBehavior,
      statesController: widget.statesController,
      iconAlignment: widget.iconAlignment,
      child: widget.child,
    );
  }
}
