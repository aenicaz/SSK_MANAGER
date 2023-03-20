final String computersTableName = 'Computers';

class ComputerFields {
  static final List<String> values = [
    id, model, buhName, serialNumber, productNumber, 
    buhNumber, invNumber, userName, storage, sealNumber, cleanDate, comment
  ];

  static final String id = '_id';
  static final String model = 'model';
  static final String buhName = 'buhName';
  static final String serialNumber = 'serialNumber';
  static final String productNumber = 'productNumber';
  static final String buhNumber = 'buhNumber';
  static final String invNumber = 'invNumber';
  static final String userName = 'userName';
  static final String storage = 'storage';
  static final String sealNumber = 'sealNumber';
  static final String cleanDate = 'cleanDate';
  static final String comment = 'comment';
}

class Computer{
  int? id;
  String? buhName /*= "undefined"*/;
  String? model /*= "undefined"*/;
  String? serialNumber /*= "undefined"*/;
  String? productNumber /*= "undefined"*/;
  String? buhNumber /*= "undefined"*/;
  String? invNumber /*= "undefined"*/;
  String? userName /*= "undefined"*/;
  String? storage /*= "undefined"*/;
  String? sealNumber /*= "undefined"*/;
  String? cleanDate /*= "undefined"*/;
  String? comment /*= "undefined"*/;

  Computer({
    this.id,
    this.model,
    this.buhName,
    this.serialNumber,
    this.productNumber,
    this.buhNumber,
    this.invNumber,
    this.userName,
    this.storage,
    this.sealNumber,
    this.cleanDate,
    this.comment,
  });

  @override
  String toString() {
    return '''Recod: {id: $id, name: $model, buhName: $buhName, serial number: $serialNumber, product number: $productNumber, 
      inventory number: $invNumber, user name: $userName, storage: $storage, seal number: $sealNumber, clean date: $cleanDate,
      comment: $comment
    }''';
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'model' : model,
      'buhName' : buhName,
      'serialNumber' : serialNumber,
      'productNumber' : productNumber,
      'buhNumber' : buhNumber,
      'invNumber' : invNumber,
      'userName' : userName,
      'storage' : storage,
      'sealNumber' : sealNumber,
      'cleanDate' : cleanDate,
      'comment' : comment
    };
  }

  Map<String, Object?> toJson() => {
    ComputerFields.id : id,
    ComputerFields.model : model,
    ComputerFields.buhName : buhName,
    ComputerFields.serialNumber : serialNumber,
    ComputerFields.productNumber : productNumber,
    ComputerFields.buhNumber : buhNumber,
    ComputerFields.invNumber : invNumber,
    ComputerFields.userName : userName,
    ComputerFields.storage : storage,
    ComputerFields.sealNumber : sealNumber,
    ComputerFields.cleanDate : cleanDate,
    ComputerFields.comment : comment,
  };

  static Computer fromJson(Map<String, Object?> json) => Computer(
        id : json[ComputerFields.id] as int?,
        model : json[ComputerFields.model] as String,
        buhName : json[ComputerFields.buhName] as String,
        serialNumber : json[ComputerFields.serialNumber] as String,
        productNumber : json[ComputerFields.productNumber] as String,
        buhNumber : json[ComputerFields.buhNumber] as String,
        invNumber : json[ComputerFields.invNumber] as String,
        userName : json[ComputerFields.userName] as String,
        storage : json[ComputerFields.storage] as String,
        sealNumber : json[ComputerFields.sealNumber] as String,
        cleanDate : json[ComputerFields.cleanDate] as String,
        comment : json[ComputerFields.comment] as String,
      );
}