import 'dart:math';

import 'package:flutter/material.dart';
import 'package:woniu_creative/widgets/state_extension.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var count = (constraints.maxWidth / 180).floor();
        count = max(1, min(count, context.isPC ? 4 : 3));
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                crossAxisCount: count,
                shrinkWrap: true,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  _buildFeatureCard(
                    context,
                    title: '设备注册',
                    icon: Icons.qr_code,
                    onTap:
                        () => Navigator.popAndPushNamed(context, '/device/register'),
                  ),
                  _buildFeatureCard(
                    context,
                    title: '创建角色',
                    icon: Icons.people,
                    onTap: () => Navigator.pushNamed(context, '/roles-1'),
                  ),
                  _buildFeatureCard(
                    context,
                    title: '频道管理',
                    icon: Icons.list,
                    onTap: () => Navigator.pushNamed(context, '/channel/list'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    Function()? onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48),
            SizedBox(height: 16),
            Text(title, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
