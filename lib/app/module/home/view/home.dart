import 'package:assignment1/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _sizeController;
  late Animation<double> _sizeAnimation;
  late Animation<double> _profileSizeAnimation;
  late Animation<Offset> _textAnimation;
  late Animation<double> _textFadeInAnimation;
  late Animation<Offset> _centerBoxAnimation;
  late Animation<Offset> _bottomBarAnimation;
  late AnimationController boxSizeController;

  @override
  void initState() {
    super.initState();
    _sizeController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    boxSizeController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _profileSizeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _sizeController,
      curve: const Interval(0.0, 0.1, curve: Curves.linear),
    ));

    _textAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: _sizeController,
      curve: const Interval(0.05, 0.2, curve: Curves.linear),
    ));
    _textFadeInAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _sizeController,
      curve: const Interval(0.18, 0.3, curve: Curves.linear),
    ));
    _sizeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _sizeController,
      curve: const Interval(0.3, 0.45, curve: Curves.linear),
    ));

    _centerBoxAnimation =
        Tween<Offset>(begin: const Offset(0, 10), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: _sizeController,
      curve: const Interval(0.29, 0.4, curve: Curves.linear),
    ));

    _bottomBarAnimation =
        Tween<Offset>(begin: const Offset(0, 5), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: _sizeController,
      curve: const Interval(0.6, 1, curve: Curves.linear),
    ));
    _sizeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxSizeController.forward();
      }
    });

    _sizeController.forward();
  }

  @override
  void dispose() {
    _sizeController.dispose();
    boxSizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      // backgroundColor: ,
      // extendBodyBehindAppBar: true,
      body: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.grey.withOpacity(0.2),
        child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 100, top: 70),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        // child: const LocationWidget(),
                      ),
                      ScaleTransition(
                        scale: _profileSizeAnimation,
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.orange,
                          child: Icon(Icons.person),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, Marina",
                        style: context.textTheme.bodyLarge!
                            .copyWith(color: Colors.grey),
                      ),
                      FadeTransition(
                        opacity: _textFadeInAnimation,
                        child: SlideTransition(
                          position: _textAnimation,
                          child: Text(
                            "Let's select your \nperfect place",
                            style: context.textTheme.bodyLarge!
                                .copyWith(height: 1.1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ScaleTransition(
                          scale: _sizeAnimation,
                          child: const AppAnimatedContainer(
                            maxValue: 1034,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: ScaleTransition(
                          scale: _sizeAnimation,
                          child: const AppAnimatedContainer(
                            maxValue: 2004,
                            circle: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                SlideTransition(
                  position: _centerBoxAnimation,
                  child: HomeBox(
                    boxSizeController: boxSizeController,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: SlideTransition(
                position: _bottomBarAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: HomeBottomNav(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeBox extends StatelessWidget {
  const HomeBox({super.key, required this.boxSizeController});

  final AnimationController boxSizeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const BoxChild(
            visibilityKey: "1",
          ),
          10.verticalSpace,
          Row(
            children: [
              const Expanded(
                  child: BoxChild(
                visibilityKey: "2",
              )),
              8.horizontalSpace,
              const Expanded(
                  child: BoxChild(
                visibilityKey: "3",
              )),
            ],
          )
        ],
      ),
    );
  }

// Widget _child(BuildContext context) {
//   return Container(
//     width: context.width,
//     height: 200,
//     padding: const EdgeInsets.all(8),
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Colors.grey.withOpacity(0.3)),
//     child: const Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         CustomAnim1Widget(
//           childMainAxisAlignment: MainAxisAlignment.spaceBetween,
//           sizeController: box,
//           fadeInChildren: [
//             Expanded(
//               child: Text(
//                 "Gladkova str,.. 34 ehehe ",
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//           children: [
//             CircleAvatar(
//               backgroundColor: Colors.white,
//               child: Icon(
//                 Icons.arrow_forward_ios,
//                 size: 15,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
}

class BoxChild extends StatelessWidget {
  const BoxChild({
    super.key,
    required this.visibilityKey,
  });

  final String visibilityKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: 200,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(0.3)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomAnim1Widget(
            visibilityKey: visibilityKey,
            childMainAxisAlignment: MainAxisAlignment.spaceBetween,
            fadeInChildren: [
              Expanded(
                child: Text(
                  "Gladkova str,.. 34 ehehe ",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.black.withOpacity(0.78)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _child(context, active: false, icon: Icons.cloud),
          _child(context, active: false, icon: Icons.messenger_outlined),
          _child(
            context,
            active: true,
            icon: Icons.home,
          ),
          _child(context, active: false, icon: Icons.heart_broken),
          _child(context, active: false, icon: Icons.person),
        ],
      ),
    );
  }

  Widget _child(BuildContext context,
      {bool active = false, required IconData icon}) {
    return Container(
      padding: EdgeInsets.all(active ? 12 : 6),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: active ? Colors.orange : Colors.black),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
