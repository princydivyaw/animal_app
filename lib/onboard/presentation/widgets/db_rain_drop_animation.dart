import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:share_module/core/constants/app_colors.dart';

class DbRainDropAnimation extends StatefulWidget {
  final String pageScreen;

  const DbRainDropAnimation({super.key, required this.pageScreen});

  @override
  State<DbRainDropAnimation> createState() => _DbRainDropAnimationState();
}

class _DbRainDropAnimationState extends State<DbRainDropAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late StaggeredRaindropAnimation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..forward();

    animation = StaggeredRaindropAnimation(controller);

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Modular.to.pushNamed(widget.pageScreen);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return CustomPaint(
            painter: HolePainter(
              color: AppColors.primary,
              holeSize: animation.holeSize.value,
            ),
            child: Stack(
              children: [
                // Drop falling
                if (animation.dropVisible.value)
                  Positioned(
                    top:
                        animation.dropPosition.value *
                        MediaQuery.of(context).size.height,
                    left:
                        MediaQuery.of(context).size.width / 2 -
                        animation.dropSize.value / 2,
                    child: Container(
                      width: animation.dropSize.value,
                      height: animation.dropSize.value,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surface,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class StaggeredRaindropAnimation {
  StaggeredRaindropAnimation(this.controller)
    : dropSize = Tween<double>(begin: 0, end: 20).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0.0, 0.2)),
      ),
      dropPosition = Tween<double>(begin: 0, end: 0.5).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0.2, 0.5)),
      ),
      holeSize = Tween<double>(begin: 0, end: 1000).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0.5, 1.0)),
      ),
      dropVisible = TweenSequence([
        TweenSequenceItem(
          tween: ConstantTween(true),
          weight: 50,
        ), // first half visible
        TweenSequenceItem(
          tween: ConstantTween(false),
          weight: 50,
        ), // then disappear
      ]).animate(controller);

  final AnimationController controller;
  final Animation<double> dropSize;
  final Animation<double> dropPosition;
  final Animation<double> holeSize;
  final Animation<bool> dropVisible;
}

class HolePainter extends CustomPainter {
  final Color color;
  final double holeSize;

  HolePainter({required this.color, required this.holeSize});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    double radius = holeSize / 2;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final outer = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));
    final inner = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius / 2));

    final hole = Path.combine(
      PathOperation.difference,
      Path()..addRect(rect),
      outer,
    );

    final ring = Path.combine(PathOperation.difference, outer, inner);

    canvas.drawPath(hole, Paint()..color = color);

    canvas.drawPath(
      ring,
      Paint()
        ..color = Colors.white.withOpacity(0.5)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
