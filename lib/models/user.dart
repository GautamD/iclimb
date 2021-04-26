class User {
  User(
      {this.profileImage,
      this.name,
      this.mobile,
      this.firmName,
      this.firmImage,
      this.address,
      this.expiryDate,
      this.email});

  String profileImage,
      name,
      mobile,
      firmName,
      firmImage,
      address,
      expiryDate,
      email;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      profileImage: json['user_data']['ProfileImage'],
      name: json['user_data']['Name'],
      mobile: json['user_data']['Mobile'],
      firmName: json['user_data']['FirmName'],
      firmImage: json['user_data']['FirmImage'],
      address: json['user_data']['Address'],
      expiryDate: json['user_data']['ExpiryDate'],
      email: json['user_data']['Email'],
    );
  }
}
