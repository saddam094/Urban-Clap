class EditProfileModel {
  final String name;
  final String age;
  final String weight;
  final String height;
  final String bloodGroup;
  final String about;
  final String email;
  final String phoneNumber;
  final String address;
  final String image;

  EditProfileModel({
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
    required this.bloodGroup,
    required this.about,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.image
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      name: json['name'] as String,
      age: json['age'] as String,
      weight: json['weight'] == null ? '' : json['weight'] as String,
      height: json['height'] == null ? '' : json['height'] as String,
      bloodGroup: json['bloodGroup'] == null ? '' : json['bloodGroup'][0] as String,
      about: json['about'] == null ? '' : json['about'] as String,
      email: json['email'] == null ? '' : json['email'] as String,
      phoneNumber: json['phoneNumber'] == null ? '' : json['phoneNumber'] as String,
      address: json['address'] == null ? '' : json['address'] as String,
      image: json['image'] == null ? '' : json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'weight': weight,
      'height': height,
      'bloodGroup': bloodGroup,
      'about': about,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'image': image
    };
  }
}
