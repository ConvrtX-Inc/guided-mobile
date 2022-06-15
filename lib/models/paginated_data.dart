///Model for Paginated Data
class PaginatedData {
  ///Constructor
  PaginatedData(
      {this.count = 0,
      this.total = 0,
      this.page = 0,
      this.pageCount = 0,
      this.data});

  ///Serialize data
  PaginatedData.fromJson(Map<String, dynamic> json)
      : count = int.parse(json['count'].toString()),
        pageCount = int.parse(json['pageCount'].toString()),
        page = int.parse(json['page'].toString()),
        total = int.parse(json['total'].toString()),
        data = json['data'];

  ///Initialization for count, total, page and page count
  int count, total, page, pageCount;

  ///Initialization for data
  dynamic data;
}
