/// status : true
/// message : "success"
/// data : [{"date":"2021-09-10 12:03:00","amount":"500","remark":"deposit"},{"date":"2021-09-10 12:04:00","amount":"50","remark":"Withdrawal"},{"date":"2021-09-15 15:10:00","amount":"50","remark":"Withdrawal"},{"date":"2021-09-15 15:11:00","amount":"100","remark":"Withdrawal"},{"date":"2021-09-15 15:17:00","amount":"100","remark":"deposit"},{"date":"2021-09-15 19:00:00","amount":"20.00","remark":"Withdrawal"},{"date":"2021-09-15 19:23:00","amount":"80","remark":"deposit"},{"date":"2021-09-15 19:26:00","amount":"1000","remark":"deposit"},{"date":"2021-09-15 19:29:00","amount":"1000","remark":"deposit"},{"date":"2021-09-15 19:29:00","amount":"490","remark":"deposit"},{"date":"2021-09-15 19:32:00","amount":"190","remark":"deposit"},{"date":"2021-09-16 10:45:00","amount":"190","remark":"deposit"}]

class TransactionModel {
  bool? _status;
  String? _message;
  List<Data>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  TransactionModel({bool? status, String? message, List<Data>? data}) {
    _status = status;
    _message = message;
    _data = data;
  }

  TransactionModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// date : "2021-09-10 12:03:00"
/// amount : "500"
/// remark : "deposit"

class Data {
  String? _date;
  String? _amount;
  String? _remark;

  String? get date => _date;
  String? get amount => _amount;
  String? get remark => _remark;

  Data({String? date, String? amount, String? remark}) {
    _date = date;
    _amount = amount;
    _remark = remark;
  }

  Data.fromJson(dynamic json) {
    _date = json['date'];
    _amount = json['amount'];
    _remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['date'] = _date;
    map['amount'] = _amount;
    map['remark'] = _remark;
    return map;
  }
}
