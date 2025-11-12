import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/user_profile_provider.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newSkillController = TextEditingController();
  
  late _EditFormState _form;
  bool _showImageSheet = false;
  bool _showDobPicker = false;
  DateTime _tempDob = DateTime.now();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    final userProfile = context.read<UserProfileProvider>().profile;
    _form = _EditFormState(
      firstName: userProfile.firstName,
      lastName: userProfile.lastName,
      jobTitle: userProfile.jobTitle,
      company: userProfile.company,
      email: userProfile.email,
      dob: userProfile.dob,
      gender: userProfile.gender,
      location: userProfile.location,
      bio: userProfile.bio,
      avatar: userProfile.avatar,
      skills: List.from(userProfile.skills),
      experienceLevel: userProfile.experienceLevel,
      yearsOfExperience: userProfile.yearsOfExperience,
    );
    
    _tempDob = _parseDobString(_form.dob) ?? DateTime.now().subtract(const Duration(days: 365 * 25));
  }

  DateTime? _parseDobString(String value) {
    if (value.isEmpty) return null;
    try {
      return DateTime.parse(value);
    } catch (e) {
      return null;
    }
  }

  String _formatDob(DateTime? date) {
    if (date == null) return '';
    final day = date.day.toString().padLeft(2, '0');
    final month = _getMonthAbbreviation(date.month);
    final year = date.year;
    return '$day $month $year';
  }

  String _getMonthAbbreviation(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  void _handleInputChange(String key, String value) {
    setState(() {
      switch (key) {
        case 'firstName':
          _form = _form.copyWith(firstName: value);
          break;
        case 'lastName':
          _form = _form.copyWith(lastName: value);
          break;
        case 'jobTitle':
          _form = _form.copyWith(jobTitle: value);
          break;
        case 'company':
          _form = _form.copyWith(company: value);
          break;
        case 'email':
          _form = _form.copyWith(email: value);
          break;
        case 'dob':
          _form = _form.copyWith(dob: value);
          break;
        case 'gender':
          _form = _form.copyWith(gender: value);
          break;
        case 'location':
          _form = _form.copyWith(location: value);
          break;
        case 'bio':
          _form = _form.copyWith(bio: value);
          break;
        case 'yearsOfExperience':
          _form = _form.copyWith(yearsOfExperience: value);
          break;
      }
    });
  }

  void _handleAvatarChange(String uri) {
    setState(() {
      _form = _form.copyWith(avatar: uri);
    });
  }

  Future<void> _handleSave() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final provider = context.read<UserProfileProvider>();
        await provider.updateProfile({
          'firstName': _form.firstName,
          'lastName': _form.lastName,
          'jobTitle': _form.jobTitle,
          'company': _form.company,
          'email': _form.email,
          'dob': _form.dob,
          'gender': _form.gender,
          'location': _form.location,
          'bio': _form.bio,
          'avatar': _form.avatar,
          'skills': _form.skills,
          'experienceLevel': _form.experienceLevel,
          'yearsOfExperience': _form.yearsOfExperience,
        });
        Navigator.of(context).pop();
      } catch (error) {
        _showErrorDialog('Failed to save profile. Please try again.');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleAddSkill() {
    final trimmed = _newSkillController.text.trim();
    if (trimmed.isNotEmpty && !_form.skills.contains(trimmed)) {
      setState(() {
        _form = _form.copyWith(skills: [..._form.skills, trimmed]);
      });
      _newSkillController.clear();
    }
  }

  void _handleRemoveSkill(String skillToRemove) {
    setState(() {
      _form = _form.copyWith(
        skills: _form.skills.where((skill) => skill != skillToRemove).toList(),
      );
    });
  }

  Future<void> _onChooseFromLibrary() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );
      
      if (image != null) {
        _handleAvatarChange(image.path);
      }
    } catch (error) {
      _showErrorDialog('Something went wrong while selecting an image.');
    } finally {
      setState(() => _showImageSheet = false);
    }
  }

  Future<void> _onTakePhoto() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );
      
      if (image != null) {
        _handleAvatarChange(image.path);
      }
    } catch (error) {
      _showErrorDialog('Something went wrong while taking a photo.');
    } finally {
      setState(() => _showImageSheet = false);
    }
  }

  void _onDeletePhoto() {
    _handleAvatarChange('default');
    setState(() => _showImageSheet = false);
  }

  void _handleDobChange(DateTime date) {
    _handleInputChange('dob', _formatDob(date));
  }

  void _openDobPicker() {
    setState(() {
      _tempDob = _parseDobString(_form.dob) ?? DateTime.now().subtract(const Duration(days: 365 * 25));
      _showDobPicker = true;
    });
  }

  void _handleDobConfirm() {
    _handleDobChange(_tempDob);
    setState(() => _showDobPicker = false);
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context);
    final isDark = palette.brightness == Brightness.dark;
    final styles = _createStyles(isDark, palette);

    return Scaffold(
      backgroundColor: styles.backgroundColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header
              _buildHeader(styles),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Profile Image
                      _buildProfileImage(styles),
                      const SizedBox(height: 20),
                      // Form Fields
                      _buildFormFields(styles),
                      const SizedBox(height: 20),
                      // Save Button
                      _buildSaveButton(styles),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(_UserInfoStyles styles) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: styles.backButtonBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back, size: 24, color: styles.textColor),
            ),
          ),
          const SizedBox(width: 16),
          // Title
          Expanded(
            child: Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: styles.textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 36), // For balance
        ],
      ),
    );
  }

  Widget _buildProfileImage(_UserInfoStyles styles) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: _form.avatar != 'default' && _form.avatar.isNotEmpty
              ? FileImage(File(_form.avatar)) as ImageProvider
              : const AssetImage('assets/images/profile.png'),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => setState(() => _showImageSheet = true),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: styles.accentColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.edit, size: 12, color: styles.saveTextColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields(_UserInfoStyles styles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField('First Name', 'firstName', 'Enter first name'),
        const SizedBox(height: 16),
        _buildTextField('Last Name', 'lastName', 'Enter last name'),
        const SizedBox(height: 16),
        _buildTextField('Job Title', 'jobTitle', 'Enter job title'),
        const SizedBox(height: 16),
        _buildTextField('Company', 'company', 'Enter company'),
        const SizedBox(height: 16),
        _buildTextField('E-mail', 'email', 'Enter email', TextInputType.emailAddress),
        const SizedBox(height: 16),
        _buildDobField(styles),
        const SizedBox(height: 16),
        _buildGenderField(styles),
        const SizedBox(height: 16),
        _buildTextField('Location', 'location', 'Enter location', null, 3),
        const SizedBox(height: 16),
        _buildTextField('Bio', 'bio', 'Tell us about yourself', null, 4),
        const SizedBox(height: 16),
        _buildSkillsField(styles),
        const SizedBox(height: 16),
        _buildExperienceLevelField(styles),
        const SizedBox(height: 16),
        _buildTextField('Years of Experience', 'yearsOfExperience', 'Enter years of experience', TextInputType.number),
      ],
    );
  }

  Widget _buildTextField(String label, String key, String hint, 
                        [TextInputType? keyboardType, int maxLines = 1]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: _getSecondaryTextColor(Theme.of(context).brightness == Brightness.dark),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: _getFieldValue(key),
          onChanged: (value) => _handleInputChange(key, value),
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: _getPlaceholderColor(Theme.of(context).brightness == Brightness.dark)),
            filled: true,
            fillColor: _getSurfaceColor(Theme.of(context).brightness == Brightness.dark),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _getBorderColor(Theme.of(context).brightness == Brightness.dark)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _getBorderColor(Theme.of(context).brightness == Brightness.dark)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ],
    );
  }

  Widget _buildDobField(_UserInfoStyles styles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date of Birth',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: styles.secondaryTextColor,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: _openDobPicker,
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: styles.surfaceColor,
              border: Border.all(color: styles.borderColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _form.dob.isNotEmpty ? _form.dob : 'Select date',
                    style: TextStyle(
                      fontSize: 14,
                      color: _form.dob.isNotEmpty ? styles.textColor : styles.placeholderColor,
                    ),
                  ),
                ),
                Icon(Icons.calendar_today, size: 20, color: styles.accentColor),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderField(_UserInfoStyles styles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: styles.secondaryTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: ['Male', 'Female'].map((gender) {
            final isSelected = _form.gender == gender;
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _handleInputChange('gender', gender),
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? styles.accentColor : styles.surfaceColor,
                        border: Border.all(color: styles.borderColor),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isSelected)
                            Icon(Icons.check_circle, size: 18, color: styles.saveTextColor),
                          if (isSelected) const SizedBox(width: 5),
                          Text(
                            gender,
                            style: TextStyle(
                              color: isSelected ? styles.saveTextColor : styles.textColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSkillsField(_UserInfoStyles styles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: styles.secondaryTextColor,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _newSkillController,
                decoration: InputDecoration(
                  hintText: 'Add a skill (e.g., React, Python, Design)',
                  hintStyle: TextStyle(color: styles.placeholderColor),
                  filled: true,
                  fillColor: styles.surfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: styles.borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: styles.borderColor),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                style: TextStyle(
                  fontSize: 14,
                  color: styles.textColor,
                ),
                onSubmitted: (_) => _handleAddSkill(),
              ),
            ),
            const SizedBox(width: 8),
            Material(
              color: styles.accentColor,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: _handleAddSkill,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  child: Icon(Icons.add, size: 20, color: styles.saveTextColor),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _form.skills.map((skill) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: styles.surfaceColor,
                border: Border.all(color: styles.borderColor),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    skill,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: styles.textColor,
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => _handleRemoveSkill(skill),
                    child: Icon(Icons.close, size: 16, color: styles.textColor),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildExperienceLevelField(_UserInfoStyles styles) {
    const levels = ['entry', 'mid', 'senior', 'executive'];
    const levelLabels = {
      'entry': 'Entry Level',
      'mid': 'Mid Level',
      'senior': 'Senior Level',
      'executive': 'Executive',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience Level',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: styles.secondaryTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: levels.map((level) {
            final isSelected = _form.experienceLevel == level;
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _handleInputChange('experienceLevel', level),
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? styles.accentColor : styles.surfaceColor,
                    border: Border.all(color: styles.borderColor),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected)
                        Icon(Icons.check_circle, size: 18, color: styles.saveTextColor),
                      if (isSelected) const SizedBox(width: 5),
                      Text(
                        levelLabels[level]!,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? styles.saveTextColor : styles.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSaveButton(_UserInfoStyles styles) {
    return Material(
      color: styles.accentColor,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: _handleSave,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          child: Text(
            'Save Changes',
            style: TextStyle(
              color: styles.saveTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  String _getFieldValue(String key) {
    switch (key) {
      case 'firstName': return _form.firstName;
      case 'lastName': return _form.lastName;
      case 'jobTitle': return _form.jobTitle;
      case 'company': return _form.company;
      case 'email': return _form.email;
      case 'location': return _form.location;
      case 'bio': return _form.bio;
      case 'yearsOfExperience': return _form.yearsOfExperience;
      default: return '';
    }
  }

  Color _getSecondaryTextColor(bool isDark) => isDark ? const Color(0xFFD0D4DA) : const Color(0xFF333333);
  Color _getPlaceholderColor(bool isDark) => isDark ? const Color(0xFF8A8F98) : const Color(0xFFA1A5AD);
  Color _getSurfaceColor(bool isDark) => isDark ? const Color(0xFF1F2022) : const Color(0xFFFFFCF5);
  Color _getBorderColor(bool isDark) => isDark ? const Color(0xFF2F3133) : const Color(0xFF046A38);
  Color _getBackButtonBackground(bool isDark) => isDark ? const Color(0xFF2A2C31) : const Color(0xFFF2F3F7);

  _UserInfoStyles _createStyles(bool isDark, ThemeData theme) {
    return _UserInfoStyles(
      backgroundColor: theme.scaffoldBackgroundColor,
      textColor: theme.textTheme.bodyLarge?.color ?? Colors.black,
      secondaryTextColor: _getSecondaryTextColor(isDark),
      placeholderColor: _getPlaceholderColor(isDark),
      surfaceColor: _getSurfaceColor(isDark),
      borderColor: _getBorderColor(isDark),
      accentColor: const Color(0xFF046A38),
      saveTextColor: isDark ? const Color(0xFF151718) : Colors.white,
      backButtonBackground: _getBackButtonBackground(isDark),
    );
  }
}

class _UserInfoStyles {
  final Color backgroundColor;
  final Color textColor;
  final Color secondaryTextColor;
  final Color placeholderColor;
  final Color surfaceColor;
  final Color borderColor;
  final Color accentColor;
  final Color saveTextColor;
  final Color backButtonBackground;

  const _UserInfoStyles({
    required this.backgroundColor,
    required this.textColor,
    required this.secondaryTextColor,
    required this.placeholderColor,
    required this.surfaceColor,
    required this.borderColor,
    required this.accentColor,
    required this.saveTextColor,
    required this.backButtonBackground,
  });
}

// Supporting classes
class _EditFormState {
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String company;
  final String email;
  final String dob;
  final String gender;
  final String location;
  final String bio;
  final String avatar;
  final List<String> skills;
  final String experienceLevel;
  final String yearsOfExperience;

  const _EditFormState({
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.company,
    required this.email,
    required this.dob,
    required this.gender,
    required this.location,
    required this.bio,
    required this.avatar,
    required this.skills,
    required this.experienceLevel,
    required this.yearsOfExperience,
  });

  _EditFormState copyWith({
    String? firstName,
    String? lastName,
    String? jobTitle,
    String? company,
    String? email,
    String? dob,
    String? gender,
    String? location,
    String? bio,
    String? avatar,
    List<String>? skills,
    String? experienceLevel,
    String? yearsOfExperience,
  }) {
    return _EditFormState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      jobTitle: jobTitle ?? this.jobTitle,
      company: company ?? this.company,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      bio: bio ?? this.bio,
      avatar: avatar ?? this.avatar,
      skills: skills ?? this.skills,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
    );
  }
}
