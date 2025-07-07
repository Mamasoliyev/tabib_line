class DoctorModel {
  final String id;
  final String name;
  final String position;
  final String workplace;
  final String aboutMe;
  final String experience;
  final String image;
  final double rating;

  DoctorModel({
    required this.id,
    required this.name,
    required this.position,
    required this.workplace,
    required this.aboutMe,
    required this.experience,
    required this.image,
    required this.rating,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> map, String id) {
    return DoctorModel(
      id: id,
      name: map['name'] ?? '',
      position: map['position'] ?? '',
      workplace: map['workplace'] ?? '',
      aboutMe: map['aboutMe'] ?? '',
      experience: map['experience'] ?? '',
      image: map['image'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'position': position,
      'workplace': workplace,
      'aboutMe': aboutMe,
      'experience': experience,
      'image': image,
      'rating': rating,
    };
  }
}
