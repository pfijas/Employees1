class Settings {
  String? status;
  String? responseMessage;
  Data? data;
  String? message;

  Settings({this.status, this.responseMessage, this.data, this.message});

  Settings.fromJson(Map<String, dynamic> json) {
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
  List<TableClass>? tableClass;
  List<KOTVoucher>? kOTVoucher;
  List<TAVoucher>? tAVoucher;
  List<PrintArea>? printArea;

  Data({this.sQLMessage, this.tableClass, this.kOTVoucher, this.tAVoucher, this.printArea});

  Data.fromJson(Map<String, dynamic> json) {
    sQLMessage = json['SQLMessage'] != null
        ? new SQLMessage.fromJson(json['SQLMessage'])
        : null;
    if (json['TableClass'] != null) {
      tableClass = <TableClass>[];
      json['TableClass'].forEach((v) {
        tableClass!.add(new TableClass.fromJson(v));
      });
    }
    if (json['KOTVoucher'] != null) {
      kOTVoucher = <KOTVoucher>[];
      json['KOTVoucher'].forEach((v) {
        kOTVoucher!.add(new KOTVoucher.fromJson(v));
      });
    }
    if (json['TAVoucher'] != null) {
      tAVoucher = <TAVoucher>[];
      json['TAVoucher'].forEach((v) {
        tAVoucher!.add(new TAVoucher.fromJson(v));
      });
    }
    if (json['PrintArea'] != null) {
      printArea = <PrintArea>[];
      json['PrintArea'].forEach((v) {
        printArea!.add(new PrintArea.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sQLMessage != null) {
      data['SQLMessage'] = this.sQLMessage!.toJson();
    }
    if (this.tableClass != null) {
      data['TableClass'] = this.tableClass!.map((v) => v.toJson()).toList();
    }
    if (this.kOTVoucher != null) {
      data['KOTVoucher'] = this.kOTVoucher!.map((v) => v.toJson()).toList();
    }
    if (this.tAVoucher != null) {
      data['TAVoucher'] = this.tAVoucher!.map((v) => v.toJson()).toList();
    }
    if (this.printArea != null) {
      data['PrintArea'] = this.printArea!.map((v) => v.toJson()).toList();
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

class TableClass {
  String? className;
  Null? description;
  String? selected;

  TableClass({this.className, this.description, this.selected});

  TableClass.fromJson(Map<String, dynamic> json) {
    className = json['ClassName'];
    description = json['Description'];
    selected = json['Selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassName'] = this.className;
    data['Description'] = this.description;
    data['Selected'] = this.selected;
    return data;
  }
}

class KOTVoucher {
  int? ledId;
  String? ledgerName;
  int? tax;
  int? cashDisc;
  String? selected;

  KOTVoucher(
      {this.ledId, this.ledgerName, this.tax, this.cashDisc, this.selected});

  KOTVoucher.fromJson(Map<String, dynamic> json) {
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

class TAVoucher {
  int? ledId;
  String? ledgerName;
  int? tax;
  int? cashDisc;
  String? selected;

  TAVoucher(
      {this.ledId, this.ledgerName, this.tax, this.cashDisc, this.selected});

  TAVoucher.fromJson(Map<String, dynamic> json) {
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



class PrintArea {
  String? printAreaName;
  int? printAreaId;

  PrintArea({this.printAreaName, this.printAreaId});

  PrintArea.fromJson(Map<String, dynamic> json) {
    printAreaName = json['PrintAreaName'];
    printAreaId = json['PrintAreaId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PrintAreaName'] = this.printAreaName;
    data['PrintAreaId'] = this.printAreaId;
    return data;
  }
}
