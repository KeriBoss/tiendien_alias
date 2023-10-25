
class DinhMuc{
  String? id;
  int soBo;
  double soM;
  double soMGa;
  double soMMen;


  DinhMuc(this.id, this.soBo, this.soM, this.soMGa, this.soMMen);

  DinhMuc.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        soBo = json['soBo'],
        soM = json['soM'],
        soMGa = json['soMGa'],
        soMMen = json['soMMen'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'soBo': soBo,
        'soM': soM,
        'soMGa': soMGa,
        'soMMen': soMMen,
      };
}