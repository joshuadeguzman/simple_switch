// Copyright 2020 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class SimpleSwitch extends StatefulWidget {
  /// Sets the default [value] for the [activeColor].
  static const Color _kDefaultActiveColor = Colors.blue;

  /// Sets the default [value] for the [inactiveColor].
  static const Color _kDefaultInactiveColor = Colors.grey;

  /// Sets the default [value] for the [padding].
  static const EdgeInsets _kDefaultPadding = const EdgeInsets.all(3);

  /// Sets the default [value] for the [size] of the toggle knob.
  static const double _kDefaultSize = 25;

  /// Sets the default [value] for the [width].
  static const double _kDefaultWidth = 50;

  /// Sets the default [value] for the [height].
  static const double _kDefaultHeight = 30;

  /// Sets the default [value] for the [borderRadius].
  static const double _kDefaultBorderRadius = 25;

  /// Sets the default [value] for the animation [curve].
  static const Curve _kDefaultCurve = Curves.easeInOutCubic;

  /// Sets the default [value] for the animation [duration].
  static const Duration _kDefaultDuration = Duration(milliseconds: 100);

  /// Sets the default [value] for the toggle [value].
  static const bool _kDefaultValue = false;

  /// Sets the optional [color] for the active background color of this [component].
  final Color activeColor;

  /// Sets the optional [color] for the inactive background color of this [component].
  final Color inactiveColor;

  /// Sets the optional [padding] for the container of the toggle knob.
  final EdgeInsets padding;

  /// Sets the optional [size] for the toggle knob.
  final double size;

  /// Sets the optional [width] for the container of this [component].
  final double width;

  /// Sets the optional [height] for the container of this [component].
  final double height;

  /// Sets the optional [borderRadius] for the container of this [component].
  final double borderRadius;

  /// Sets the optional [curve] for the slide transition [animation].
  final Curve curve;

  /// Sets the optional [duration] for the slide transition [animation].
  final Duration duration;

  /// Sets the optional [value] of this [component] whether it's toggled or not.
  final bool value;

  /// Sets the optional [onChanged] callback of this [component] whenver it's toggled.
  final ValueChanged<bool>? onChanged;

  const SimpleSwitch({
    Key? key,
    this.activeColor = _kDefaultActiveColor,
    this.inactiveColor = _kDefaultInactiveColor,
    this.padding = _kDefaultPadding,
    this.size = _kDefaultSize,
    this.width = _kDefaultWidth,
    this.height = _kDefaultHeight,
    this.borderRadius = _kDefaultBorderRadius,
    this.curve = _kDefaultCurve,
    this.duration = _kDefaultDuration,
    this.value = _kDefaultValue,
    this.onChanged,
  }) : super(key: key);

  @override
  _SimpleSwitchState createState() {
    return _SimpleSwitchState();
  }
}

class _SimpleSwitchState extends State<SimpleSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  Color get _activeColor => widget.activeColor;
  Color get _inactiveColor => widget.inactiveColor;
  EdgeInsets get _padding => widget.padding;
  double get _size => widget.size;
  double get _width => widget.width;
  double get _height => widget.height;
  double get _borderRadius => widget.borderRadius;
  Curve get _curve => widget.curve;
  Duration get _duration => widget.duration;
  bool get _value => widget.value;
  ValueChanged<bool>? get _onChanged => widget.onChanged;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _animation = AlignmentTween(
      begin: _value ? Alignment.centerRight : Alignment.centerLeft,
      end: _value ? Alignment.centerLeft : Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: _curve,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.isCompleted) {
          _controller.reverse();
        } else {
          _controller.forward();
        }

        if (_onChanged != null) {
          _onChanged!(_value == false);
        }
      },
      child: AnimatedContainer(
        duration: _duration,
        curve: _curve,
        width: _width,
        height: _height,
        padding: _padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius),
          color: _value ? _activeColor : _inactiveColor,
        ),
        child: Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Align(
                  alignment: _animation.value,
                  child: Container(
                    width: _size,
                    height: _size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
