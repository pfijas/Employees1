class Dinning {
  String? status;
  String? responseMessage;
  Data? data;
  String? message;

  Dinning({this.status, this.responseMessage, this.data, this.message});

  Dinning.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    responseMessage = json['ResponseMessage'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['ResponseMessage'] = this.responseMessage;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    data['Message'] = this.message;
    return data;
  }
}

class Data {
  SQLMessage? sQLMessage;
  List<Category>? category;
  List<Items>? items;
  List<ExtraAddOn>? extraAddOn;
  List<Tables>? tables;
  List<Voucher>? voucher;

  Data(
      {this.sQLMessage,
        this.category,
        this.items,
        this.extraAddOn,
        this.tables,
        this.voucher});

  Data.fromJson(Map<String, dynamic> json) {
    sQLMessage = json['SQLMessage'] != null
        ? new SQLMessage.fromJson(json['SQLMessage'])
        : null;
    if (json['Category'] != null) {
      category = <Category>[];
      json['Category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['Items'] != null) {
      items = <Items>[];
      json['Items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    if (json['ExtraAddOn'] != null) {
      extraAddOn = <ExtraAddOn>[];
      json['ExtraAddOn'].forEach((v) {
        extraAddOn!.add(new ExtraAddOn.fromJson(v));
      });
    }
    if (json['Tables'] != null) {
      tables = <Tables>[];
      json['Tables'].forEach((v) {
        tables!.add(new Tables.fromJson(v));
      });
    }

    if (json['Voucher'] != null) {
      voucher = <Voucher>[];
      json['Voucher'].forEach((v) {
        voucher!.add(new Voucher.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sQLMessage != null) {
      data['SQLMessage'] = this.sQLMessage!.toJson();
    }
    if (this.category != null) {
      data['Category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.items != null) {
      data['Items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.extraAddOn != null) {
      data['ExtraAddOn'] = this.extraAddOn!.map((v) => v.toJson()).toList();
    }
    if (this.tables != null) {
      data['Tables'] = this.tables!.map((v) => v.toJson()).toList();
    }
    if (this.voucher != null) {
      data['Voucher'] = this.voucher!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SQLMessage {
  Null? level;
  String? status;
  String? code;
  String? message;

  SQLMessage({this.level, this.status, this.code, this.message});

  SQLMessage.fromJson(Map<String, dynamic> json) {
    level = json['Level'];
    status = json['Status'];
    code = json['Code'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Level'] = this.level;
    data['Status'] = this.status;
    data['Code'] = this.code;
    data['Message'] = this.message;
    return data;
  }
}

class Category {
  int? catId;
  String? catName;

  Category({this.catId, this.catName});

  Category.fromJson(Map<String, dynamic> json) {
    catId = json['CatId'];
    catName = json['CatName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CatId'] = this.catId;
    data['CatName'] = this.catName;
    return data;
  }
}

class Items {
  int? itemId;
  int? catId;
  String? name;
  double? sRate;
  String? printer;

  Items({this.itemId, this.catId, this.name, this.sRate, this.printer});

  Items.fromJson(Map<String, dynamic> json) {
    itemId = json['ItemId'];
    catId = json['CatId'];
    name = json['Name'];
    sRate = json['SRate'];
    printer = json['Printer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemId'] = this.itemId;
    data['CatId'] = this.catId;
    data['Name'] = this.name;
    data['SRate'] = this.sRate;
    data['Printer'] = this.printer;
    return data;
  }
}

class ExtraAddOn {
  int? itemId;
  int? catId;
  String? name;
  double? sRate;
  String? printer;

  ExtraAddOn({this.itemId, this.catId, this.name, this.sRate, this.printer});

  ExtraAddOn.fromJson(Map<String, dynamic> json) {
    itemId = json['ItemId'];
    catId = json['CatId'];
    name = json['Name'];
    sRate = json['SRate'];
    printer = json['Printer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemId'] = this.itemId;
    data['CatId'] = this.catId;
    data['Name'] = this.name;
    data['SRate'] = this.sRate;
    data['Printer'] = this.printer;
    return data;
  }
}

class Tables {
  int? tableId;
  String? tableName;
  int? chair;
  String? guest;
  String? tableStatus;

  Tables(
      {this.tableId, this.tableName, this.chair, this.guest, this.tableStatus});

  Tables.fromJson(Map<String, dynamic> json) {
    tableId = json['TableId'];
    tableName = json['TableName'];
    chair = json['Chair'];
    guest = json['Guest'];
    tableStatus = json['TableStatus'];
    chair = chair ?? 0;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TableId'] = this.tableId;
    data['TableName'] = this.tableName;
    data['Chair'] = this.chair;
    data['Guest'] = this.guest;
    data['TableStatus'] = this.tableStatus;
    return data;
  }
}

class Voucher {
  int? ledId;
  String? ledgerName;
  int? tax;
  int? cashDisc;
  Null? selected;

  Voucher(
      {
        this.ledId, this.ledgerName, this.tax, this.cashDisc, this.selected});

  Voucher.fromJson(Map<String, dynamic> json) {
    ledId = json['LedId'];
    ledgerName = json['LedgerName'];
    tax = json['Tax'];
    cashDisc = json['CashDisc'];
    selected = json['Selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LedId'] = this.ledId;
    data['LedgerName'] = this.ledgerName;
    data['Tax'] = this.tax;
    data['CashDisc'] = this.cashDisc;
    data['Selected'] = this.selected;
    return data;
  }
}
