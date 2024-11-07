import 'package:flutter/material.dart';
import 'package:assignment1/app/app.dart';

class AppAnimatedContainer extends StatelessWidget {
  const AppAnimatedContainer({
    super.key,
    this.maxValue = 0,
    this.circle = true,
  });

  final int maxValue;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 200,
      width: 200,
      duration: const Duration(seconds: 2),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: circle ? Colors.orange : Colors.white,
        borderRadius: circle ? null : BorderRadius.circular(30),
        shape: circle ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: TweenAnimationBuilder<int>(
        tween: IntTween(begin: 0, end: maxValue),
        duration: const Duration(seconds: 2),
        builder: (context, int i, Widget? child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                circle ? "Buy" : "Rent",
                style: context.textTheme.bodySmall!.copyWith(
                  color: circle ? Colors.white : Colors.grey,
                ),
              ),
              Column(
                children: [
                  20.verticalSpace,
                  Text(
                    "$i",
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodySmall!.copyWith(
                      color: circle ? Colors.white : Colors.grey,
                    ),
                  ),
                  Text(
                    "Offers",
                    style: context.textTheme.bodySmall!.copyWith(
                      color: circle ? Colors.white : Colors.grey,
                    ),
                  ),
                ],
              ),
              const Text('')
            ],
          );
        },
      ),
    );
  }
}
