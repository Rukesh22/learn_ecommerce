import 'package:cloud_firestore/cloud_firestore.dart';

class BannerMode {
  String imageUrl;
  final String targetScreen;
  final bool active;

  BannerMode(
      {required this.targetScreen,
      required this.active,
      required this.imageUrl});

  Map<String, dynamic> toJson() {
    return {
      'ImageUrl': imageUrl,
      'TargetScreen': targetScreen,
      'Active': active
    };
  }

  factory BannerMode.fromSnaphot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerMode(
      targetScreen: data['TargetScreen'] ?? '',
      active: data['Active'] ?? false,
      imageUrl: data['ImageUrl'] ?? '',
    );
  }
}
