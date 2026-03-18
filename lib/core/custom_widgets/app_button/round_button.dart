import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_style.dart';

class RoundButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;

  const RoundButton({
    super.key,
    required this.title,
    required this.onTap,
    this.loading = false,
  });

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  double _scale = 1.0;

  void _handleTap() {
    if (widget.loading) return;
    setState(() => _scale = 0.92);
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() => _scale = 1.0);
      widget.onTap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: Duration(milliseconds: 100),
      child: GestureDetector(
        onTap: _handleTap,
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.scrim,
            borderRadius: BorderRadius.circular(15),
          ),
          child: widget.loading
              ? SizedBox(
                  height: 25,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballClipRotatePulse,
                    colors: [AppColors.appWhite],
                  ),
                )
              : Text(
                  widget.title,
                  style: mTextStyle16(
                    textColor: AppColors.appWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
