import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool showLogoutConfirm = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final Color backgroundColor = theme.scaffoldBackgroundColor;
    final Color surfaceColor = theme.cardColor;
    final Color iconColor = theme.iconTheme.color ?? (isDarkMode ? Colors.white : Colors.black87);
    final Color borderColor = theme.dividerColor;
    final Color dialogOverlayColor = isDarkMode
        ? Colors.black.withOpacity(0.7)
        : Colors.black.withOpacity(0.5);
    final Color brandColor = const Color(0xFF046A38);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_back_ios_new, color: iconColor, size: 20),
                        ),
                      ),
                      Text(
                        'Settings',
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 36), // placeholder
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Appearance Section
                        _buildSection(
                          title: 'Appearance',
                          surfaceColor: surfaceColor,
                          borderColor: borderColor,
                          children: [
                            _buildSettingItem(
                              icon: Icons.palette,
                              label: 'Theme',
                              iconColor: iconColor,
                              trailing: IconButton(
                                onPressed: () => themeProvider.toggleTheme(),
                                icon: Icon(
                                  isDarkMode ? Icons.dark_mode : Icons.light_mode,
                                  color: iconColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Account Section
                        _buildSection(
                          title: 'Account',
                          surfaceColor: surfaceColor,
                          borderColor: borderColor,
                          children: [
                            _buildNavigationItem(
                                icon: Icons.person,
                                label: 'Profile',
                                iconColor: iconColor,
                                onTap: () {
                                  Navigator.of(context).pushNamed('/profile');
                                }),
                            _buildNavigationItem(
                                icon: Icons.edit,
                                label: 'Edit Profile',
                                iconColor: iconColor,
                                onTap: () {
                                  Navigator.of(context).pushNamed('/edit-profile');
                                }),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Preferences Section
                        _buildSection(
                          title: 'Preferences',
                          surfaceColor: surfaceColor,
                          borderColor: borderColor,
                          children: [
                            _buildNavigationItem(
                              icon: Icons.notifications_none,
                              label: 'Notifications',
                              iconColor: iconColor,
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Logout Section
                        _buildSection(
                          title: 'Logout',
                          surfaceColor: surfaceColor,
                          borderColor: borderColor,
                          children: [
                            _buildNavigationItem(
                              icon: Icons.logout,
                              label: 'Log Out',
                              iconColor: Colors.red,
                              labelColor: Colors.red,
                              onTap: () => setState(() => showLogoutConfirm = true),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Logout confirmation dialog
          if (showLogoutConfirm)
            Positioned.fill(
              child: Container(
                color: dialogOverlayColor,
                child: Center(
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: surfaceColor,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () => setState(() => showLogoutConfirm = false),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isDarkMode ? Colors.white12 : Colors.black12,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.close, size: 18, color: iconColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Are you sure you want to logout?',
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () => setState(() => showLogoutConfirm = false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: brandColor,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () {
                            setState(() => showLogoutConfirm = false);
                            // Navigate to login screen and clear navigation stack
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login',
                              (route) => false,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            side: const BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: const Text('Log Out', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Color surfaceColor,
    required Color borderColor,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String label,
    required Color iconColor,
    Widget? trailing,
    Color? labelColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 12),
            Text(label, style: TextStyle(fontSize: 15, color: labelColor ?? iconColor)),
          ],
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _buildNavigationItem({
    required IconData icon,
    required String label,
    required Color iconColor,
    Color? labelColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 20),
                const SizedBox(width: 12),
                Text(label, style: TextStyle(fontSize: 15, color: labelColor ?? iconColor)),
              ],
            ),
            Icon(Icons.chevron_right, color: iconColor),
          ],
        ),
      ),
    );
  }
}
