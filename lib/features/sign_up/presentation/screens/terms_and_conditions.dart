import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 64.h),
              Text(
                'Terms and Conditions',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              const Text(
                '''Terms and conditions (T&Cs) are a legal agreement between a website or app owner and its users. They outline the rules and regulations that users must follow when using the website or app. T&Cs typically cover a variety of topics, such as: Acceptable use: This section defines what is considered acceptable behavior on the website or app. For example, it may prohibit users from posting illegal or offensive content, or from engaging in spam or phishing. Intellectual property: This section defines who owns the intellectual property rights to the website or app, and how users may use that content. For example, it may state that users cannot copy or redistribute the website's content without permission. Privacy policy: This section explains how the website or app collects and uses user data. For example, it may state that the website will not sell user data to third parties. Limitation of liability: This section limits the website or app's liability for damages caused by its use. For example, it may state that the website or app is not responsible for any lost or stolen data. Dispute resolution: This section outlines how disputes between the website or app owner and its users will be resolved. For example, it may state that disputes will be settled through arbitration.T&Cs are an important part of any website or app. They help to protect the website or app owner from liability, and they help to ensure that users understand the rules and regulations that they must follow.''',
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
