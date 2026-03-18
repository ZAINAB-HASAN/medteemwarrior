class UserModel {
  int? id;
  String? employeeId;
  String? fullName;
  String? email;
  String? mobileNo;
  String? contact; // Added to match user requirement
  String? image;
  String? address;
  String? designation;
  String? token;
  bool? isLogin;

  UserModel({
    this.id,
    this.employeeId,
    this.fullName,
    this.email,
    this.mobileNo,
    this.contact,
    this.image,
    this.address,
    this.designation,
    this.token,
    this.isLogin,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    isLogin = json['isLogin']; 
    
    if (json['data'] != null) {
      final userData = json['data'];
      id = userData['id'];
      employeeId = userData['employeeId'];
      fullName = userData['name'];
      email = userData['email'];
      mobileNo = userData['mobileNo'];
      contact = userData['mobileNo']; // Mapping contact to mobileNo from response
      image = userData['image'];
      address = userData['address'];
      designation = userData['designation'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['employeeId'] = employeeId;
    data['fullName'] = fullName;
    data['email'] = email;
    data['mobileNo'] = mobileNo;
    data['contact'] = contact;
    data['image'] = image;
    data['address'] = address;
    data['designation'] = designation;
    data['token'] = token;
    data['isLogin'] = isLogin;
    return data;
  }
}
