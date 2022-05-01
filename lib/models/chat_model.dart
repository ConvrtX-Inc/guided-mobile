///Model For Chat
class ChatModel {
  ///Constructor
  ChatModel({this.userId, this.roomId, this.receiver, this.messages,this.isBlocked});

  ///Initialization for user id
  String? userId;

  ///Initialization for room id
  String? roomId;

  ///Initialization for receiver
  Receiver? receiver;

  ///Initialization for messages
  List<Message>? messages;

  ///Initialization for is blocked
  bool? isBlocked;

  ///initialization for usermessageblockedid
  String? userMessageBlockedId;

  ///initialization for user message block from
  String? userMessageBlockFrom;
  ///Map Data
  ChatModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    roomId = json['room_id'];
    receiver =
        json['receiver'] != null ? Receiver.fromJson(json['receiver']) : null;
    if (json['messages'] != null) {
      messages = <Message>[];
      json['messages'].forEach((v) {
        messages!.add(Message.fromJson(v));
      });
    }
    isBlocked = json['is_blocked'] ?? false;
    userMessageBlockedId = json['user_message_block_id'] ?? '';
    userMessageBlockFrom = json['user_message_block_from'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = userId;
    data['room_id'] = roomId;
    if (receiver != null) {
      data['receiver'] = receiver!.toJson();
    }
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    data['is_blocked'] = isBlocked;
    data['user_message_block_id'] = userMessageBlockedId;
    return data;
  }
}

///Receiver Model
class Receiver {
  ///Constructor
  Receiver({this.id, this.fullName, this.avatar, this.isOnline});

  ///Initialization for id
  String? id;

  ///Initialization for full name
  String? fullName;

  ///Initialization for avatar
  String? avatar;

  ///Initialization for isOnline
  bool? isOnline;

  ///Map Data
  Receiver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'] ?? '';
    avatar = json['avatar'] ?? '';
    isOnline = json['isOnline'];
  }

  ///Map Data
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['full_name'] = fullName;
    data['avatar'] = avatar;
    data['isOnline'] = isOnline;
    return data;
  }
}

///Message Model
class Message {
  ///Constructor
  Message({
    this.id,
    this.messageId,
    this.userId,
    this.senderId,
    this.receiverId,
    this.message,
    this.isRead,
    this.isSpam,
    this.isSent,
    this.isArchive,
    this.createdDate,
    this.updatedDate,
    this.messageType = 'text'
  });

  ///Initialization for strings
  String? id,
      messageId,
      userId,
      senderId,
      receiverId,
      message,
      createdDate,
      updatedDate, messageType;

  ///Initialization for booleans
  bool? isRead, isSpam, isSent, isArchive;

  ///Map Data
  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageId = json['message_id'];
    userId = json['user_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    message = json['message'];
    isRead = json['is_read'];
    isSpam = json['is_spam'];
    isSent = json['is_sent'];
    isArchive = json['is_archive'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    messageType = json['message_type'] ?? 'text';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['message_id'] = messageId;
    data['user_id'] = userId;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['message'] = message;
    data['is_read'] = isRead;
    data['is_spam'] = isSpam;
    data['is_sent'] = isSent;
    data['is_archive'] = isArchive;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    data['message_type'] = messageType;

    return data;
  }
}
