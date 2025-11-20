class User {
  final String id;
  final String email;
  final String name;
  final String? profilePicture;
  final String? phoneNumber;
  final String? location;
  final String? bio;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.profilePicture,
    this.phoneNumber,
    this.location,
    this.bio,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}