class BankDetails {
  int? id;
  String? accountHolderName;
  String? bankName;
  String? accountNmuber;
  String? swiftCOde;
  String? isActive;
  String? createdDate;
  String? updatedDate;

  BankDetails(
      {this.id,
        this.accountHolderName,
        this.bankName,
        this.accountNmuber,
        this.swiftCOde,
        this.isActive,
        this.createdDate,
        this.updatedDate});

  BankDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountHolderName = json['accountHolderName'];
    bankName = json['bankName'];
    accountNmuber = json['accountNmuber'];
    swiftCOde = json['swiftCOde'];
    isActive = json['isActive'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['accountHolderName'] = this.accountHolderName;
    data['bankName'] = this.bankName;
    data['accountNmuber'] = this.accountNmuber;
    data['swiftCOde'] = this.swiftCOde;
    data['isActive'] = this.isActive;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}