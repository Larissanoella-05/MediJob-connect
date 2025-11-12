import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'providers/user_profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> experienceItems = [
    {
      "logo": "assets/images/netflix.png",
      "title": "Sr. UI Designer",
      "company": "Netflix • 2019",
    },
    {
      "logo": "assets/images/paypal.png",
      "title": "Junior UI Designer",
      "company": "PayPal • 2020",
    },
    {
      "logo": "assets/images/spotify.png",
      "title": "UI/UX Designer",
      "company": "Spotify • 2021",
    },
  ];

  final List<Map<String, String>> educationItems = [
    {
      "logo": "assets/images/university-of-oxford-badge-logo.png",
      "title": "University of Oxford",
      "subtitle": "Computer Science • 2020",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, profileProvider, _) {
        final profile = profileProvider.profile;
        final ThemeData theme = Theme.of(context);
        final bool isDark = theme.brightness == Brightness.dark;
        final Color accent = isDark ? const Color(0xFFF4A300) : theme.colorScheme.secondary;
        final Color iconOnAccent = isDark ? const Color(0xFF151718) : Colors.white;

        return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: theme.textTheme.bodyLarge?.color),
                        onPressed: () => Navigator.pop(context),
                        iconSize: 22,
                      ),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: accent,
                      child: IconButton(
                        icon: Icon(Icons.edit, color: iconOnAccent),
                        onPressed: () {
                          Navigator.pushNamed(context, '/edit-profile');
                        },
                        iconSize: 22,
                      ),
                    ),
                  ],
                ),
              ),

              // Profile section
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: profile.avatar != 'default' && profile.avatar.isNotEmpty
                            ? (profile.avatar.startsWith('http') 
                                ? NetworkImage(profile.avatar) 
                                : FileImage(File(profile.avatar)) as ImageProvider)
                            : const AssetImage('assets/images/profile.png'),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${profile.firstName} ${profile.lastName}",
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          text: "${profile.jobTitle} at ",
                          style: theme.textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: profile.company,
                              style: TextStyle(color: accent, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        profile.bio.isNotEmpty ? profile.bio : 'No bio yet',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),

              // About section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("About", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(profile.bio.isNotEmpty ? profile.bio : 'No bio yet', style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),

              // Contact & Personal Info section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Contact & Personal Info", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    if (profile.email.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Icon(Icons.email, size: 18, color: Colors.grey[600]),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                profile.email,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (profile.location.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, size: 18, color: Colors.grey[600]),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                profile.location,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (profile.dob.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today, size: 18, color: Colors.grey[600]),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                profile.dob,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (profile.gender.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Icon(Icons.person, size: 18, color: Colors.grey[600]),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                profile.gender,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // Experience section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Experience", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...experienceItems.map((exp) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Image.asset(exp['logo']!, width: 30, height: 30),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(exp['title']!, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                              Text(exp['company']!, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),

              // Skills section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Skills", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: profile.skills.map<Widget>((skill) {
                        bool isFirst = profile.skills.indexOf(skill) == 0;
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: isFirst ? accent : (isDark ? Colors.grey[800] : Colors.grey[200]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            skill,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: isFirst ? iconOnAccent : theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Experience level section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Experience", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      "Level: ${profile.experienceLevel.capitalize()}",
                      style: theme.textTheme.bodyLarge,
                    ),
                    Text(
                      "Years: ${profile.yearsOfExperience} ${profile.yearsOfExperience == '1' ? 'year' : 'years'}",
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),

              // Education section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Education", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...educationItems.map((edu) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Image.asset(edu['logo']!, width: 30, height: 30),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(edu['title']!, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                              Text(edu['subtitle']!, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                    )),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
        );
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() => "${this[0].toUpperCase()}${substring(1)}";
}
