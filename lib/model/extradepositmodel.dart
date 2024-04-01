class ExtraDepositModel {
  final String? addon;
  final String? name;
  final String? totalamount;
  final String? status;



  ExtraDepositModel({
    required this.addon,
    required this.name,
    required this.totalamount,
    required this.status,

  });
  factory ExtraDepositModel.fromJson(Map<String, dynamic> json) {
    return ExtraDepositModel(
      addon: json['addon'],
      name: json['name'],
      totalamount: json['totalamount'],
      status: json['status'],

    );
  }
}