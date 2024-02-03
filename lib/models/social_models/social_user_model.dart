class SocialUserModel
{
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? bio;
  String? image;
  String? cover;
  SocialUserModel({
      this.uId,
     required this.name,
     required this.email,
     required this.phone,
     required this.bio,
     required this.image,
      this.cover,
   });
  SocialUserModel.fromJson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    bio=json['bio'];
    image=json['image'];
    cover=json['cover'];
  }
  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'bio':bio,
      'image':image,
      'cover':cover,
  };
}
}