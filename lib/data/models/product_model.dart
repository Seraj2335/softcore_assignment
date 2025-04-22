


class Product {
  String? supplierName;

  String? brandName;

  String? designCategoryName;

  String? subDesignCategoryName;

  String? designCode;

  Product({
    this.supplierName,
    this.brandName,
    this.designCode,
    this.designCategoryName,
    this.subDesignCategoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        supplierName: json['SupplierName']!,
        designCode: json['DesignCode']!,
        brandName: json['BrandName']!,
        designCategoryName: json['DesignCategoryName']!,
        subDesignCategoryName: json['SubDesignCategoryName']!);
  }
}
