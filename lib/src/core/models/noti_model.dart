class NotificaitonModel {
  String? title;
  String? body;
  String? approveOrReject;
  String? details;

  NotificaitonModel(
      {this.approveOrReject, this.body, this.details, this.title});

  factory NotificaitonModel.fromJson(Map<String, dynamic> doc) {
    if (doc.isEmpty) {}
    return NotificaitonModel(
        approveOrReject: doc['approveOrReject'],
        body: doc['body'],
        details: doc['details'],
        title: doc['title']);
  }
}
