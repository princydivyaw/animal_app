import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:share_module/core/constants/app_colors.dart';
import 'package:share_module/core/theme/text_styles.dart';

class FailureScreen extends StatelessWidget {
  const FailureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.016,
          ),
          GradientText(
            "404",
            gradient: const LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primaryShade,
              ],
            ),
            style: AppTextStyles.title(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.016,
          ),
          Text(
            "कुछ नहीं मिला.",
            style: AppTextStyles.subHeadingSubTitleNormal(
                color: AppColors.textPrimary),
          ),
          Text(
            "NOTHING FOUND",
            style: AppTextStyles.subHeadingSubTitleNormal(
                color: AppColors.textPrimary),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.016,
          ),
          Text(
            "यह पृष्ठ उपलब्ध नहीं है.",
            style:
                AppTextStyles.bodyRegularNormal(color: AppColors.textPrimary),
          ),
          Text(
            "The page you are looking for is not available.",
            style:
                AppTextStyles.bodyRegularNormal(color: AppColors.textPrimary),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.016,
          ),
          InkWell(
            child: Text(
              "होम",
              style: AppTextStyles.bodyNormal(color: AppColors.primary),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.016,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "Now no need to roam door to door, you can ",
                    style: AppTextStyles.captionNormal(
                        color: AppColors.textPrimary),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    text: "buy",
                    style:
                        AppTextStyles.captionNormal(color: AppColors.primary),
                  ),
                  TextSpan(
                    text: " and ",
                    style: AppTextStyles.captionNormal(
                        color: AppColors.textPrimary),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    text: "sell",
                    style:
                        AppTextStyles.captionNormal(color: AppColors.primary),
                  ),
                  TextSpan(
                    text: " your cow and buffaloes online.",
                    style: AppTextStyles.captionNormal(
                        color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.032,
          ),
          Divider(
            height: 1,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: AppColors.surface),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.016,
                  ),
                  Text(
                    "किसान भाइयों द्वारा, किसान भाइयों के लिए",
                    style: AppTextStyles.captionNormal(
                        color: AppColors.textSecondary),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.016,
                  ),
                  Text(
                    "भारत का",
                    style: AppTextStyles.captionBold(
                        color: AppColors.textSecondary),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.008,
                  ),
                  Text(
                    "डिजिटल पशुमेला",
                    style: AppTextStyles.captionExtraBold(
                        color: AppColors.textSecondary),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.016,
                  ),
                  Image.asset(
                    "assets/images/app_secure_banner.jpg",
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.016,
                  ),
                  Text(
                    "© 2025 Animall Technologies Pvt. Ltd.",
                    style: AppTextStyles.captionNormal(
                        color: AppColors.textSecondary),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.016,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.016,
          ),
          Text(
            "🙏 जय किसान",
            style: AppTextStyles.captionNormal(color: AppColors.textPrimary),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.008,
          ),
          Text(
            "कृपया ऐप शेयर करें",
            style: AppTextStyles.captionNormal(color: Colors.purple),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.016,
          ),
          const Center(child: ShareButtons())
        ],
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText(
    this.text, {
    required this.gradient,
    required this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style.copyWith(color: Colors.white), // overridden by gradient
      ),
    );
  }
}

class ShareButtons extends StatelessWidget {
  const ShareButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        socialButton(
          color: Colors.blue,
          icon: Icons.message_rounded,
          text: "मेसेन्जर",
          onPressed: () {},
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.008,
        ),
        socialButton(
          color: Colors.green,
          icon: Icons.messenger_outline_outlined,
          text: "वाट्सऐप",
          onPressed: () {},
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.008,
        ),
        socialButton(
          color: Colors.purple,
          icon: Icons.share,
          text: "शेयर करें",
          onPressed: () {},
        ),
      ],
    );
  }

  Widget socialButton({
    required Color color,
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 6),
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(height: 6),
          Text(
            text,
            style: AppTextStyles.captionNormal(color: AppColors.textOnPrimary),
          ),
        ],
      ),
    );
  }
}
