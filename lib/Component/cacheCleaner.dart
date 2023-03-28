import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walla/configs/constants.dart';

import '../Theme/theme_cubit.dart';
import '../configs/colors.dart';

class CacheCleaner extends StatefulWidget {
  const CacheCleaner({Key key}) : super(key: key);

  @override
  State<CacheCleaner> createState() => _CacheCleanerState();
}

class _CacheCleanerState extends State<CacheCleaner>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var isDark = themeCubit.isDark;

    return Container(
      margin: EdgeInsets.only(bottom: 125, right: 15),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: FloatingActionButton(
          backgroundColor: isDark ? AppColors.black : Colors.white,
          foregroundColor: isDark ? Colors.white : AppColors.black,
          onPressed: () {
            TickerFuture tickerFuture =
                _animationController.repeat(reverse: true);
            tickerFuture.timeout(Duration(milliseconds: 500 * 4),
                onTimeout: () {
              AppConstants().deleteCache(context);
              _animationController.forward(from: 0);
              _animationController.stop(canceled: true);
            });
          },
          child: Icon(Icons.cleaning_services),
        ),
      ),
    );
  }
}
