import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class DetailBeasiswaScreen extends StatelessWidget {
  final String title;
  final String desc;
  final String detail;
  final String region;
  final String imageUrl;

  const DetailBeasiswaScreen({
    super.key,
    required this.title,
    required this.desc,
    required this.detail,
    required this.region,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: AppColors.bg,
      body: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          minHeight: double.infinity,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF72C386),
              Color(0xFFEFFFF6),
              Colors.white,
            ],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(32, 14, 32, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    size: 32,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),

                const SizedBox(height: 14),

                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          width: double.infinity,
                          height: 315,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: double.infinity,
                          height: 315,
                          color: Colors.white.withOpacity(0.6),
                          child: const Icon(
                            Icons.image_outlined,
                            size: 70,
                            color: Colors.black38,
                          ),
                        ),
                ),

                const SizedBox(height: 20),

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.15,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.15,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  detail,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}