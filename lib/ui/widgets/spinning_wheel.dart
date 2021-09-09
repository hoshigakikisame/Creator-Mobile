import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:meta/meta.dart';

import 'package:flutter/material.dart';

class SpinningWheel extends StatefulWidget {
  final double width;

  final double height;

  final Image image;

  final int dividers;

  final double initialSpinAngle;

  final double spinResistance;

  final bool canInteractWhileSpinning;

  final Image? secondaryImage;

  final double? secondaryImageHeight;

  final double? secondaryImageWidth;

  final double? secondaryImageTop;

  final double? secondaryImageLeft;

  final Function? onUpdate;

  final Function? onEnd;

  final Stream? shouldStartOrStop;

  SpinningWheel(
    this.image, {
    required this.width,
    required this.height,
    required this.dividers,
    this.initialSpinAngle: 0.0,
    this.spinResistance: 0.5,
    this.canInteractWhileSpinning: true,
    this.secondaryImage,
    this.secondaryImageHeight,
    this.secondaryImageWidth,
    this.secondaryImageTop,
    this.secondaryImageLeft,
    this.onUpdate,
    this.onEnd,
    this.shouldStartOrStop,
  })  : assert(width > 0.0 && height > 0.0),
        assert(spinResistance > 0.0 && spinResistance <= 1.0),
        assert(initialSpinAngle >= 0.0 && initialSpinAngle <= (2 * pi)),
        assert(secondaryImage == null ||
            (secondaryImageHeight! <= height && secondaryImageWidth! <= width));

  @override
  _SpinningWheelState createState() => _SpinningWheelState();
}

class _SpinningWheelState extends State<SpinningWheel>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;


  SpinVelocity? _spinVelocity;
  NonUniformCircularMotion? _motion;

  Offset? _localPositionOnPanUpdate;

  double _totalDuration = 0;

  double _initialCircularVelocity = 0;

  double? _dividerAngle;

  double _currentDistance = 0;

  double? _initialSpinAngle;

  int? _currentDivider;

  bool? _isBackwards;

  DateTime? _offsetOutsideTimestamp;

  RenderBox? _renderBox;

  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();

    _spinVelocity = SpinVelocity(width: widget.width, height: widget.height);
    _motion = NonUniformCircularMotion(resistance: widget.spinResistance);

    _animationController = new AnimationController(
      vsync: this,
      duration: Duration(seconds: 0),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController!, curve: Curves.linear));

    _dividerAngle = _motion!.anglePerDivision(widget.dividers);
    _initialSpinAngle = widget.initialSpinAngle;

    _animation!.addStatusListener((status) {
      if (status == AnimationStatus.completed) _stopAnimation();
    });

    if (widget.shouldStartOrStop != null) {
      _subscription = widget.shouldStartOrStop!.listen(_startOrStop);
    }
  }

  _startOrStop(dynamic velocity) {
    if (_animationController!.isAnimating) {
      _stopAnimation();
    } else {
      var pixelsPerSecondY = velocity ?? 8000.0;
      _localPositionOnPanUpdate = Offset(250.0, 250.0);
      _startAnimation(Offset(0.0, pixelsPerSecondY));
    }
  }

  double get topSecondaryImage =>
      widget.secondaryImageTop ??
      (widget.height / 2) - (widget.secondaryImageHeight! / 2);

  double get leftSecondaryImage =>
      widget.secondaryImageLeft ??
      (widget.width / 2) - (widget.secondaryImageWidth! / 2);

  double get widthSecondaryImage => widget.secondaryImageWidth ?? widget.width;

  double get heightSecondaryImage =>
      widget.secondaryImageHeight ?? widget.height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: Stack(
        children: [
          GestureDetector(
            onPanUpdate: _moveWheel,
            onPanEnd: _startAnimationOnPanEnd,
            onPanDown: (_details) => _stopAnimation(),
            child: AnimatedBuilder(
                animation: _animation!,
                child: Container(child: widget.image),
                builder: (context, child) {
                  _updateAnimationValues();
                  widget.onUpdate!(_currentDivider);
                  return Transform.rotate(
                    angle: _initialSpinAngle! + _currentDistance,
                    child: child,
                  );
                }),
          ),
          widget.secondaryImage != null
              ? Positioned(
                  top: topSecondaryImage,
                  left: leftSecondaryImage,
                  child: Container(
                    height: heightSecondaryImage,
                    width: widthSecondaryImage,
                    child: widget.secondaryImage,
                  ))
              : Container(),
        ],
      ),
    );
  }

  bool get _userCanInteract =>
      !_animationController!.isAnimating || widget.canInteractWhileSpinning;

  void _updateLocalPosition(Offset position) {
    if (_renderBox == null) {
      _renderBox = context.findRenderObject() as RenderBox;
    }
    _localPositionOnPanUpdate = _renderBox!.globalToLocal(position);
  }

  bool _contains(Offset p) => Size(widget.width, widget.height).contains(p);

  void _updateAnimationValues() {
    if (_animationController!.isAnimating) {
      var currentTime = _totalDuration * _animation!.value;
      _currentDistance =
          _motion!.distance(_initialCircularVelocity, currentTime);
      if (_isBackwards!) {
        _currentDistance = -_currentDistance;
      }
    }
    var modulo = _motion!.modulo(_currentDistance + _initialSpinAngle!);
    _currentDivider = (widget.dividers - (modulo ~/ _dividerAngle)).toInt();
    if (_animationController!.isCompleted) {
      _initialSpinAngle = modulo;
      _currentDistance = 0;
    }
  }

  void _moveWheel(DragUpdateDetails details) {
    if (!_userCanInteract) return;

    if (_offsetOutsideTimestamp != null) return;

    _updateLocalPosition(details.globalPosition);

    if (_contains(_localPositionOnPanUpdate!)) {
      var angle = _spinVelocity!.offsetToRadians(_localPositionOnPanUpdate!);
      setState(() {
        _currentDistance = angle - _initialSpinAngle!;
      });
    } else {
      _offsetOutsideTimestamp = DateTime.now();
    }
  }

  void _stopAnimation() {
    if (!_userCanInteract) return;

    _offsetOutsideTimestamp = null;
    _animationController!.stop();
    _animationController!.reset();

    widget.onEnd!(_currentDivider);
  }

  void _startAnimationOnPanEnd(DragEndDetails details) {
    if (!_userCanInteract) return;

    if (_offsetOutsideTimestamp != null) {
      var difference = DateTime.now().difference(_offsetOutsideTimestamp!);
      _offsetOutsideTimestamp = null;
      if (difference.inMilliseconds > 50) return;
    }

    if (_localPositionOnPanUpdate == null) return;

    _startAnimation(details.velocity.pixelsPerSecond);
  }

  void _startAnimation(Offset pixelsPerSecond) {
    var velocity =
        _spinVelocity!.getVelocity(_localPositionOnPanUpdate!, pixelsPerSecond);

    _localPositionOnPanUpdate = null;
    _isBackwards = velocity < 0;
    _initialCircularVelocity = pixelsPerSecondToRadians(velocity.abs());
    _totalDuration = _motion!.duration(_initialCircularVelocity);

    _animationController!.duration =
        Duration(milliseconds: (_totalDuration * 1000).round());

    _animationController!.reset();
    _animationController!.forward();
  }

  dispose() {
    _animationController!.dispose();
    if (_subscription != null) {
      _subscription!.cancel();
    }
    super.dispose();
  }
}



const Map<int, Offset> cuadrants = const {
  1: Offset(0.5, 0.5),
  2: Offset(-0.5, 0.5),
  3: Offset(-0.5, -0.5),
  4: Offset(0.5, -0.5),
};

const pi_0_5 = pi * 0.5;
const pi_2_5 = pi * 2.5;
const pi_2 = pi * 2;

class SpinVelocity {
  final double height;
  final double width;

  double get width_0_5 => width / 2;
  double get height_0_5 => height / 2;

  SpinVelocity({required this.height, required this.width});

  double getVelocity(Offset position, Offset pps) {
    var cuadrantIndex = _getCuadrantFromOffset(position);
    var cuadrant = cuadrants[cuadrantIndex];
    return (cuadrant!.dx * pps.dx) + (cuadrant.dy * pps.dy);
  }

  double offsetToRadians(Offset position) {
    var a = position.dx - width_0_5;
    var b = height_0_5 - position.dy;
    var angle = atan2(b, a);
    return _normalizeAngle(angle);
  }

  int _getCuadrantFromOffset(Offset p) => p.dx > width_0_5
      ? (p.dy > height_0_5 ? 2 : 1)
      : (p.dy > height_0_5 ? 3 : 4);


  double _normalizeAngle(double angle) => angle > 0
      ? (angle > pi_0_5 ? (pi_2_5 - angle) : (pi_0_5 - angle))
      : pi_0_5 - angle;

  bool contains(Offset p) => Size(width, height).contains(p);
}

class NonUniformCircularMotion {
  final double resistance;

  NonUniformCircularMotion({required this.resistance});

  double get acceleration => resistance * -7 * pi;

  distance(double velocity, double time) =>
      (velocity * time) + (0.5 * acceleration * pow(time, 2));

  duration(double velocity) => -velocity / acceleration;

  modulo(double angle) => angle % (2 * pi);

  anglePerDivision(int dividers) => (2 * pi) / dividers;
}

double pixelsPerSecondToRadians(double pps) {
  return (pps * 2 * pi) / 1000;
}
