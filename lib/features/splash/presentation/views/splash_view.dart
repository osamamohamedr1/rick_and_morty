import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rick_and_morty/core/routes/routes.dart';
import 'package:rick_and_morty/core/utils/assets.dart';
import 'package:rick_and_morty/core/utils/extensions.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _animate = true;
      });
    });

    if (mounted) {
      Future.delayed(Duration(seconds: 2), () {
        navigateToNextPage();
      });
    }
  }

  void navigateToNextPage() {
    context.pushNamedAndRemoveUntil(Routes.home, predicate: (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Assets.imagesSplashBackground,
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            curve: Curves.easeOut,
            bottom: _animate ? height * .4 : 0,
            left: width / 2 - 135,
            child: SvgPicture.asset(Assets.svgsShip, width: 150, height: 150),
          ),

          AnimatedPositioned(
            duration: Duration(seconds: 2),
            curve: Curves.easeOut,
            top: _animate ? height * .1 : 0,
            left: width / 2 - 185,
            child: SvgPicture.asset(Assets.svgsRickMortyName),
          ),
        ],
      ),
    );
  }
}
