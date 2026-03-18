class PartRequestDetailsModel {
  bool? action;
  String? message;
  PartsRequestData? data;

  PartRequestDetailsModel({this.action, this.message, this.data});

  PartRequestDetailsModel.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    message = json['message'];
    data = json['data'] != null
        ? new PartsRequestData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action'] = this.action;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PartsRequestData {
  int? id;
  String? ticketNo;
  int? userId;
  int? productId;
  String? title;
  String? description;
  Null? images;
  String? location;
  String? priority;
  String? status;
  String? scheduleAt;
  Null? resolutionNote;
  int? companyId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Product? product;
  List<SupportCallAssignment>? supportCallAssignment;
  List<PartsRequest>? partsRequest;
  String? employeeStatus;

  PartsRequestData({
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
    this.partsRequest,
    this.employeeStatus,
  });

  PartsRequestData.fromJson(Map<String, dynamic> json) {
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
        ? new Product.fromJson(json['product'])
        : null;
    if (json['supportCallAssignment'] != null) {
      supportCallAssignment = <SupportCallAssignment>[];
      json['supportCallAssignment'].forEach((v) {
        supportCallAssignment!.add(new SupportCallAssignment.fromJson(v));
      });
    }
    if (json['partsRequest'] != null) {
      partsRequest = <PartsRequest>[];
      json['partsRequest'].forEach((v) {
        partsRequest!.add(new PartsRequest.fromJson(v));
      });
    }
    employeeStatus = json['employeeStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticketNo'] = this.ticketNo;
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
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.supportCallAssignment != null) {
      data['supportCallAssignment'] = this.supportCallAssignment!
          .map((v) => v.toJson())
          .toList();
    }
    if (this.partsRequest != null) {
      data['partsRequest'] = this.partsRequest!.map((v) => v.toJson()).toList();
    }
    data['employeeStatus'] = this.employeeStatus;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

class SupportCallAssignment {
  int? id;
  int? isActive;
  String? createdAt;
  Employee? employee;

  SupportCallAssignment({
    this.id,
    this.isActive,
    this.createdAt,
    this.employee,
  });

  SupportCallAssignment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['image'] = this.image;
    return data;
  }
}

class PartsRequest {
  int? id;
  String? status;
  int? employeeId;
  String? requestedAt;
  String? remark;
  List<PartsRequestItems>? partsRequestItems;
  Employee? employee;

  PartsRequest({
    this.id,
    this.status,
    this.employeeId,
    this.requestedAt,
    this.remark,
    this.partsRequestItems,
    this.employee,
  });

  PartsRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    employeeId = json['employeeId'];
    requestedAt = json['requestedAt'];
    remark = json['remark'];
    if (json['partsRequestItems'] != null) {
      partsRequestItems = <PartsRequestItems>[];
      json['partsRequestItems'].forEach((v) {
        partsRequestItems!.add(new PartsRequestItems.fromJson(v));
      });
    }
    employee = json['employee'] != null
        ? Employee.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['employeeId'] = this.employeeId;
    data['requestedAt'] = this.requestedAt;
    data['remark'] = this.remark;
    if (this.partsRequestItems != null) {
      data['partsRequestItems'] = this.partsRequestItems!
          .map((v) => v.toJson())
          .toList();
    }
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    return data;
  }
}

class PartsRequestItems {
  int? id;
  int? productId;
  int? requestedQty;
  int? approvedQty;
  String? status;
  Product? product;

  PartsRequestItems({
    this.id,
    this.productId,
    this.requestedQty,
    this.approvedQty,
    this.status,
    this.product,
  });

  PartsRequestItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    requestedQty = json['requestedQty'];
    approvedQty = json['approvedQty'];
    status = json['status'];
    product = json['product'] != null
        ? new Product.fromJson(json['product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['requestedQty'] = this.requestedQty;
    data['approvedQty'] = this.approvedQty;
    data['status'] = this.status;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}
