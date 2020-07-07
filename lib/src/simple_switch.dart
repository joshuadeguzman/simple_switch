// Copyright 2020 Joshua de Guzman (https://joshuadeguzman.github.io). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class SimpleSwitch extends StatefulWidget {
  static const Color _kDefaultActiveColor = Colors.blue;

  static const Color _kDefaultInactiveColor = Colors.grey;

  static const EdgeInsets _kDefaultPadding = const EdgeInsets.all(3);

  static const double _kDefaultSize = 25;

  static const double _kDefaultWidth = 50;

  static const double _kDefaultHeight = 30;

  static const double _kDefaultBorderRadius = 25;

  static const Curve _kDefaultCurve = Curves.easeInOutCubic;

  static const Duration _kDefaultDuration = Duration(milliseconds: 100);

  static const bool _kDefaultValue = false;

  final Color activeColor;

  final Color inactiveColor;

  final EdgeInsets padding;

  final double size;

  final double width;

  final double height;

  final double borderRadius;

  final Curve curve;

  final Duration duration;

  final bool value;

  final ValueChanged<bool> onChanged;

  const SimpleSwitch({
    Key key,
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
  AnimationController _controller;
  Animation _animation;

  double get _width => widget.width;
  double get _height => widget.height;
  double get _borderRadius => widget.borderRadius;
  EdgeInsets get _padding => widget.padding;
  double get _size => widget.size;
  bool get _value => widget.value;
  ValueChanged<bool> get _onChanged => widget.onChanged;
  Curve get _curve => widget.curve;
  Duration get _duration => widget.duration;
  Color get _activeColor => widget.activeColor;
  Color get _inactiveColor => widget.inactiveColor;

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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.isCompleted) {
          _controller.reverse();
        } else {
          _controller.forward();
        }

        if (_onChanged != null) {
          _onChanged(_value == false);
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
