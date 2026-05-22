import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../widgets/app_logo.dart';
import '../widgets/profile_widgets.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          Container(
            height: 400,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF5C8973),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70),
                bottomRight: Radius.circular(70),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  22,
                  20,
                  22,
                  100,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          size: 32,
                        ),
                        onPressed: () {},
                      ),
                    ),

                    const CircleAvatar(
                      radius: 47,
                      backgroundColor: Color(0xFF9CFF9B),
                      child: Text(
                        'A',
                        style: TextStyle(
                          fontSize: 52,
                          color: Color(0xFF2E1748),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Nazriel Ilham',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 22),

                    const AppLogo(size: 65),

                    const SizedBox(height: 16),

                    Container(
                      width: 298,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.22),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ProfileMenu(
                            icon: Icons.account_circle_outlined,
                            title: 'Edit Profile',
                            onTap: () {},
                          ),

                          const Divider(height: 18),

                          ProfileMenu(
                            icon: Icons.logout_rounded,
                            title: 'Logout',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}