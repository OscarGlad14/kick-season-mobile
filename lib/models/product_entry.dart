import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
    String model;
    String pk;
    Fields fields;

    ProductEntry({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int? user;
    String? thumbnail;
    DateTime createdAt;
    String name;
    String description;
    int price;
    String category;
    int productViews;
    bool isFeatured;
    int stock;
    String brand;

    Fields({
        this.user,  // Hapus required karena nullable
        this.thumbnail,  // Hapus required karena nullable
        required this.createdAt,
        required this.name,
        required this.description,
        required this.price,
        required this.category,
        required this.productViews,
        required this.isFeatured,
        required this.stock,
        required this.brand,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        thumbnail: json["thumbnail"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        productViews: json["product_views"],
        isFeatured: json["is_featured"],
        stock: json["stock"],
        brand: json["brand"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "thumbnail": thumbnail,
        "created_at": createdAt.toIso8601String(),
        "name": name,
        "description": description,
        "price": price,
        "category": category,
        "product_views": productViews,
        "is_featured": isFeatured,
        "stock": stock,
        "brand": brand,
    };
}