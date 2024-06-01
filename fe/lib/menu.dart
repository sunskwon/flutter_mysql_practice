class Menu {
  final int menuCode;
  final String menuName;
  final int menuPrice;
  final int categoryCode;
  final String orderableStatus;

  Menu({
    required this.menuCode,
    required this.menuName,
    required this.menuPrice,
    required this.categoryCode,
    required this.orderableStatus,
  });

  factory Menu.fromJson(var jsonData){

    return Menu(
      menuCode:jsonData['menuCode'],
      menuName:jsonData['menuName'],
      menuPrice:jsonData['menuPrice'],
      categoryCode:jsonData['categoryCode'],
      orderableStatus:jsonData['orderableStatus'],
    );
  }
}
