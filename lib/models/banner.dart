class BannerModel {
  late String id;
  late String nameImage;
  late String linkImage;
  late DateTime createdDate;

  BannerModel(this.id, this.nameImage, this.linkImage, this.createdDate);

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameImage = json['nameImage'];
    linkImage = json['linkImage'];
    createdDate = json['createdDate'].toDate();
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nameImage': nameImage,
    'linkImage': linkImage,
    'createdDate': createdDate,
  };
}
