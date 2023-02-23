class Transaction{
  int? id;
  int? wallet;
  String? transaction_type;
  String? date;
  int? amount;
  String? comment;


  Transaction.fromJason(Map<String,dynamic> json){
    id=json['id'];
    wallet=json['wallet'];
    transaction_type=json['transaction_type'];
    date=json['data'];
    amount=json['amount'];
    comment=json['comment'];

  }

}