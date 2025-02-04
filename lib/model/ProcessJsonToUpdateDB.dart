import 'Database_Models.dart';

class ProcessDataReceivedFromFromBackend {
  final List<categories> ProductCategoriesList;
  final List<products> productsList;
  final List<requestStocksAndPackageDispatch> stockRequestsList;
  final List<requestStocksAndPackageDispatch> packageDispatchList;
  final List<requestStockItems> stockRequestsProductsList;
  final List<Barcode> BarcodeList;

  ProcessDataReceivedFromFromBackend({this.productsList,
                this.ProductCategoriesList,
                this.stockRequestsList,
                this.stockRequestsProductsList,
                this.BarcodeList, this.packageDispatchList});

  factory ProcessDataReceivedFromFromBackend.fromJson(Map<String, dynamic> parsedJson){

    var list1 = parsedJson['categories'] as List;
    var list2 = parsedJson['products'] as List;
    var list3 = parsedJson['requestStocks'] as List;
    var list4 = parsedJson['requestStockItems'] as List;
    var list5 = parsedJson['barcode'] as List;
    var list6 = parsedJson['packageDispatch'] as List;



    List<categories> ProductCategoriesListParsedFromJson = list1.map((i) => categories.fromJson(i)).toList();
    List<products> productsListParsedFromJson = list2.map((i) => products.fromJson(i)).toList();
    List<requestStocksAndPackageDispatch> stockRequestsListParsedFromJson = list3.map((i) => requestStocksAndPackageDispatch.fromJson(i)).toList();
    List<requestStocksAndPackageDispatch> packageDispatchListParsedFromJson = list6.map((i) => requestStocksAndPackageDispatch.fromJson(i)).toList();
    List<requestStockItems> stockRequestsProductsListParsedFromJson = list4.map((i) => requestStockItems.fromJson(i)).toList();
    List<Barcode> BarcodeListParsedFromJson = list5.map((i) => Barcode.fromJson(i)).toList();


    return ProcessDataReceivedFromFromBackend(
        ProductCategoriesList: ProductCategoriesListParsedFromJson,
        productsList: productsListParsedFromJson,
        stockRequestsList: stockRequestsListParsedFromJson,
        stockRequestsProductsList : stockRequestsProductsListParsedFromJson,
        BarcodeList : BarcodeListParsedFromJson,
        packageDispatchList : packageDispatchListParsedFromJson
    );
  }
}



// class for send Data to Backend
class sendDataToBackend {
  var StockRequestList;
  var StockRequestsProductsList;
  var packageDispatchList;
  var OrdersList;
  var OrderProductsList;
  var CustomerList;
  var CustomerCreditList;
  var OrderRefundItemsList;
  var CustomProductsList;
  var sync_data_list;
  var orderRefundList;

  sendDataToBackend(this.packageDispatchList, this.StockRequestList, this.StockRequestsProductsList, this.OrdersList, this.OrderProductsList, this.CustomerList, this.CustomerCreditList, this.OrderRefundItemsList, this.orderRefundList, this.CustomProductsList, this.sync_data_list);

  sendDataToBackend.fromJson(Map<String, dynamic> json)
      : StockRequestList = json['requestStocks'],
        StockRequestsProductsList = json['requestStockItems'],
        OrdersList = json['orders'],
        OrderProductsList = json['orderItems'],
        CustomerList = json['customers'],
        CustomerCreditList = json['creditLogs'],
        OrderRefundItemsList = json['refund_items'],
        CustomProductsList = json['customProducts'],
        orderRefundList = json['refunds'],
        sync_data_list = json['sync_data_list'],
        packageDispatchList = json['packageDispatchList'];


  Map<String, dynamic> toJson() =>
      {
        'requestStocks' : StockRequestList,
        'requestStockItems': StockRequestsProductsList,
        'orders': OrdersList,
        'orderItems': OrderProductsList,
        'customers': CustomerList,
        'creditLogs': CustomerCreditList,
        'refund_items': OrderRefundItemsList,
        'customProducts': CustomProductsList,
        'sync_data_list' : sync_data_list,
        'orderRefundList' : orderRefundList,
        'packageDispatchList' : packageDispatchList,
      };
}



class ProcessDataSentToFromBackend {
  final List<requestStocksAndPackageDispatch> requestStocksList;
  final List<requestStocksAndPackageDispatch> packageDispatchList;
  final List<requestStockItems> requestStockItemsList;
  final List<orderItems> orderItemsList;
  final List<Orders> ordersList;
  final List<customProducts> customProductsList;
  final List<refundItems> refundItemsList;
  final List<customerCredit> creditLogsList;
  final List<customer> customerList;
  final List<refunds> orderRefundsList;

  ProcessDataSentToFromBackend({this.requestStocksList,
    this.requestStockItemsList,
    this.orderItemsList,
    this.customProductsList,
    this.refundItemsList,
    this.creditLogsList,
    this.customerList,
    this.ordersList,
    this.orderRefundsList,
    this.packageDispatchList
  });

  factory ProcessDataSentToFromBackend.fromJson(Map<String, dynamic> parsedJson){


    var list1 = parsedJson['requestStockItems'] as List;
    var list2 = parsedJson['orders'] as List;
    var list3 = parsedJson['orderItems'] as List;
    var list4 = parsedJson['customProducts'] as List;
    var list5 = parsedJson['refundItems'] as List;
    var list6 = parsedJson['creditLogs'] as List;
    var list7 = parsedJson['customers'] as List;
    var list8 = parsedJson['requestStocks'] as List;
    var list9 = parsedJson['orderRefunds'] as List;
    var list10 = parsedJson['packageDispatch'] as List;




    //print(parsedJson);
    //print(list3);
    List<requestStockItems> requestStockItemsListParsedFromJson = list1.map((i) => requestStockItems.fromJson(i)).toList();
    List<Orders> ordersListParsedFromJson = list2.map((i) => Orders.fromJson(i)).toList();
    List<orderItems> orderItemsListParsedFromJson = list3.map((i) => orderItems.fromJson(i)).toList();
    List<customProducts> customProductsListParsedFromJson = list4.map((i) => customProducts.fromJson(i)).toList();
    List<refundItems> refundsItemsListParsedFromJson = list5.map((i) => refundItems.fromJson(i)).toList();
    List<customerCredit> customerCreditListParsedFromJson = list6.map((i) => customerCredit.fromJson(i)).toList();
    List<customer> customerListParsedFromJson = list7.map((i) => customer.fromJson(i)).toList();
    List<requestStocksAndPackageDispatch> requestStocksListParsedFromJson = list8.map((i) => requestStocksAndPackageDispatch.fromJson(i)).toList();
    List<requestStocksAndPackageDispatch> packageDispatchListParsedFromJson = list10.map((i) => requestStocksAndPackageDispatch.fromJson(i)).toList();
    List<refunds> refundsListParsedFromJson = list9.map((i) => refunds.fromJson(i)).toList();


    return ProcessDataSentToFromBackend(
        requestStocksList:requestStocksListParsedFromJson,
        requestStockItemsList:requestStockItemsListParsedFromJson,
        orderItemsList:orderItemsListParsedFromJson,
        customProductsList:customProductsListParsedFromJson,
        refundItemsList:refundsItemsListParsedFromJson,
        creditLogsList:customerCreditListParsedFromJson,
        customerList:customerListParsedFromJson,
        ordersList:ordersListParsedFromJson,
        orderRefundsList:refundsListParsedFromJson,
        packageDispatchList : packageDispatchListParsedFromJson

    );
  }
}
