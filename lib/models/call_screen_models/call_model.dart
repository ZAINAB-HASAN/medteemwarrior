
/*class CallModel {
  bool? action;
  String? message;
  CallResponseData? data;

  CallModel({this.action, this.message, this.data});

  CallModel.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    message = json['message'];
    data = json['data'] != null
        ? CallResponseData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['action'] = action;
    json['message'] = message;
    if (data != null) {
      json['data'] = data!.toJson();
    }
    return json;
  }
}

class CallResponseData {
  List<CallItem>? calls;
  int? totalCount;

  CallResponseData({this.calls, this.totalCount});

  CallResponseData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      calls = <CallItem>[];
      json['data'].forEach((v) {
        calls!.add(CallItem.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    if (calls != null) {
      json['data'] = calls!.map((v) => v.toJson()).toList();
    }
    json['totalCount'] = totalCount;
    return json;
  }
}

class CallItem {
  int? id;
  String? ticketNo;
  int? userId;
  int? productId;
  String? title;
  String? description;
  dynamic images;
  String? location;
  String? priority;
  String? status;
  String? scheduleAt;
  dynamic resolutionNote;
  int? companyId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Product? product;
  List<SupportCallAssignment>? supportCallAssignment;
  String? employeeStatus;

  CallItem({
    this.id,
    this.ticketNo,
    this.userId,
    this.productId,
    this.title,
    this.description,
    this.images,
    this.location,
    this.priority,
    this.status,
    this.scheduleAt,
    this.resolutionNote,
    this.companyId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.product,
    this.supportCallAssignment,
    this.employeeStatus
  });

  CallItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketNo = json['ticketNo'];
    userId = json['userId'];
    productId = json['productId'];
    title = json['title'];
    description = json['description'];
    images = json['images'];
    location = json['location'];
    priority = json['priority'];
    status = json['status'];
    scheduleAt = json['scheduleAt'];
    resolutionNote = json['resolutionNote'];
    companyId = json['companyId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deleted_at'];
    product = json['product'] != null
        ? Product.fromJson(json['product'])
        : null;

    if (json['supportCallAssignment'] != null) {
      supportCallAssignment = <SupportCallAssignment>[];
      json['supportCallAssignment'].forEach((v) {
        supportCallAssignment!.add(SupportCallAssignment.fromJson(v));
      });
    }
    employeeStatus = json['employeeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['id'] = id;
    json['ticketNo'] = ticketNo;
    json['userId'] = userId;
    json['productId'] = productId;
    json['title'] = title;
    json['description'] = description;
    json['images'] = images;
    json['location'] = location;
    json['priority'] = priority;
    json['status'] = status;
    json['scheduleAt'] = scheduleAt;
    json['resolutionNote'] = resolutionNote;
    json['companyId'] = companyId;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    json['deleted_at'] = deletedAt;

    if (product != null) {
      json['product'] = product!.toJson();
    }
    if (supportCallAssignment != null) {
      json['supportCallAssignment'] = supportCallAssignment!
          .map((v) => v.toJson())
          .toList();
    }

    json['employeeStatus']=employeeStatus;
    return json;
  }
}

class Product {
  int? id;
  String? title;

  Product({this.id, this.title});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title};
  }
}

class SupportCallAssignment {
  int? id;
  Employee? employee;

  SupportCallAssignment({this.id, this.employee});

  SupportCallAssignment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {'id': id, if (employee != null) 'employee': employee!.toJson()};
  }
}

class Employee {
  int? id;
  String? name;
  String? email;
  String? mobileNo;
  String? image;

  Employee({this.id, this.name, this.email, this.mobileNo, this.image});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobileNo': mobileNo,
      'image': image,
    };
  }
}*/

class CallModel {
  bool? action;
  String? message;
  CallResponseData? data;

  CallModel({this.action, this.message, this.data});

  CallModel.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    message = json['message'];
    data = json['data'] != null ? CallResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['action'] = this.action;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CallResponseData {
  List<CallItem>? calls;
  int? totalCount;

  CallResponseData({this.calls, this.totalCount});

  CallResponseData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      calls = <CallItem>[];
      json['data'].forEach((v) {
        calls!.add(CallItem.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.calls != null) {
      data['data'] = this.calls!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    return data;
  }
}

class CallItem {
  int? id;
  String? ticketNo;
  int? customerId;
  int? userId;
  int? productId;
  String? title;
  String? description;
  Null images;
  String? location;
  String? priority;
  String? status;
  String? scheduleAt;
  Null resolutionNote;
  int? companyId;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  Customer? customer;
  Product? product;
  List<SupportCallAssignment>? supportCallAssignment;
  String? employeeStatus;

  CallItem(
      {this.id,
        this.ticketNo,
        this.customerId,
        this.userId,
        this.productId,
        this.title,
        this.description,
        this.images,
        this.location,
        this.priority,
        this.status,
        this.scheduleAt,
        this.resolutionNote,
        this.companyId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.customer,
        this.product,
        this.supportCallAssignment,
        this.employeeStatus});

  CallItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketNo = json['ticketNo'];
    customerId = json['customerId'];
    userId = json['userId'];
    productId = json['productId'];
    title = json['title'];
    description = json['description'];
    images = json['images'];
    location = json['location'];
    priority = json['priority'];
    status = json['status'];
    scheduleAt = json['scheduleAt'];
    resolutionNote = json['resolutionNote'];
    companyId = json['companyId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deleted_at'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    if (json['supportCallAssignment'] != null) {
      supportCallAssignment = <SupportCallAssignment>[];
      json['supportCallAssignment'].forEach((v) {
        supportCallAssignment!.add(SupportCallAssignment.fromJson(v));
      });
    }
    employeeStatus = json['employeeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['ticketNo'] = this.ticketNo;
    data['customerId'] = this.customerId;
    data['userId'] = this.userId;
    data['productId'] = this.productId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['images'] = this.images;
    data['location'] = this.location;
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['scheduleAt'] = this.scheduleAt;
    data['resolutionNote'] = this.resolutionNote;
    data['companyId'] = this.companyId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.supportCallAssignment != null) {
      data['supportCallAssignment'] =
          this.supportCallAssignment!.map((v) => v.toJson()).toList();
    }
    data['employeeStatus'] = this.employeeStatus;
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? email;
  String? mobileNo;
  String? companyName;

  Customer({this.id, this.name, this.email, this.mobileNo, this.companyName});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['companyName'] = this.companyName;
    return data;
  }
}

class Product {
  int? id;
  String? title;

  Product({this.id, this.title});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

class SupportCallAssignment {
  int? id;
  int? isActive;
  String? createdAt;
  String? status;
  Employee? employee;

  SupportCallAssignment(
      {this.id, this.isActive, this.createdAt, this.status, this.employee});

  SupportCallAssignment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    status = json['status'];
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['status'] = this.status;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    return data;
  }
}

class Employee {
  int? id;
  String? name;
  String? email;
  String? mobileNo;
  String? image;

  Employee({this.id, this.name, this.email, this.mobileNo, this.image});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['image'] = this.image;
    return data;
  }
}
