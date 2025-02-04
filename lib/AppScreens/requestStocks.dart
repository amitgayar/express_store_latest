import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:express_store/model/app_state_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart';
import '../model/queryForUI.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:express_store/Databases/Database.dart';
import 'drawer_express_store.dart';


NewAppStateModel requestStocksModel = new NewAppStateModel();
final formatter = NumberFormat.simpleCurrency(name: 'INR', decimalDigits: 2,);




class RequestStocks extends StatefulWidget {
  @override
  _RequestStocks createState() => _RequestStocks();
}

class _RequestStocks extends State<RequestStocks> {



  @override
  Widget build(BuildContext context) {

    requestStocksModel.getStockRequestsFromDatabase('delivered');
    return Scaffold(
      body: SafeArea(

        child: ScopedModel<NewAppStateModel>(
          model: requestStocksModel,
          child: RequestStocksMenu(),
          ),
        ),
      );
  }

}

class RequestStocksMenu extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerExpress(),

        appBar: AppBar(
          title: Text('Request Stocks'),
          backgroundColor: Color(0xff429585),
          //          bottom: TabBar(
          //            // These are the widgets to put in each tab in the tab bar.
          //            tabs: _tabs.map((String name) => Tab(text: name)).toList(),
          //            ),
          ),
        body: RequestStocksDescendant()

        );
  }
}

class RequestStocksDescendant extends StatefulWidget {

  @override
  _RequestStocksDescendant createState() => _RequestStocksDescendant ();
}


class _RequestStocksDescendant extends State<RequestStocksDescendant> {

//class RequestStocksDescendant extends StatelessWidget {

  bool barSelection = false;
  bool acceptStocks = false;
  bool acceptRequestTile = false;
  bool requestHistoryTile = false;
  bool requestNewStocks = false;
  bool requestSent = false;

  final List<Map> productList = [{
    'name': 'product_name',
    'sp': '30',
    'mrp': '90',
    'qty': '9',
    'total' : '810'
  },
    {
      'name': 'product_name2',
      'sp': '90',
      'mrp': '90',
      'qty': '3',
      'total' : '810'
    }
  ];

  final List<Map> productListSentPage = [{
    'name': 'product_name',
    'sp': '30',
    'mrp': '90',
    'qty': '9',
    'total' : '810'
  },
    {
      'name': 'product_name2',
      'sp': '90',
      'mrp': '90',
      'qty': '3',
      'total' : '810'
    },
    {
      'name': 'product_name2',
      'sp': '90',
      'mrp': '90',
      'qty': '3',
      'total' : '810'
    },
    {
      'name': 'product_name2',
      'sp': '90',
      'mrp': '90',
      'qty': '3',
      'total' : '810'
    },
    {
      'name': 'product_name2',
      'sp': '90',
      'mrp': '90',
      'qty': '3',
      'total' : '810'
    },
    {
      'name': 'product_name2',
      'sp': '90',
      'mrp': '90',
      'qty': '3',
      'total' : '810'
    },
    {
      'name': 'product_name2',
      'sp': '90',
      'mrp': '90',
      'qty': '3',
      'total' : '810'
    },
    {
      'name': 'product_name2',
      'sp': '90',
      'mrp': '90',
      'qty': '3',
      'total' : '810'
    },
    {
      'name': 'product_name2',
      'sp': '90',
      'mrp': '90',
      'qty': '3',
      'total' : '810'
    },
    {
      'name': 'product_name2',
      'sp': '90',
      'mrp': '90',
      'qty': '3',
      'total' : '810'
    },
  ];
  final List<Map> productListRequestNewStockPage = [{
    'name': 'product_name',
    'sp': '30',
    'mrp': '90',
    'qty': '9',
    'total' : '810'
  },
    {
      'name': 'product_name2',
      'sp': '90',
      'mrp': '90',
      'qty': '3',
      'total' : '810'
    }
  ];

  final List<Map> acceptRequestList = [
    {
      'request_time' : '12:1:2019 12:03',
      'status' : 'Delivered',
      'no_of_items' : 3,
      'total_amount' : 259
    },
    {
      'request_time' : '12:3:2019 02:03',
      'status' : 'Delivered',
      'no_of_items' : 30,
      'total_amount' : 2590
    },

  ];

  final List<Map> requestHistoryList = [
    {
      'request_time' : '12:1:2019 12:03',
      'status' : 'Delivered',
      'no_of_items' : 3,
      'total_amount' : 259
    },
    {
      'request_time' : '12:3:2019 02:03',
      'status' : 'In-Transit',
      'no_of_items' : 30,
      'total_amount' : 2590
    },

  ];


  final formatter = NumberFormat.simpleCurrency(name: 'INR', decimalDigits: 0,);


  List<Container> buildFirstScreenTiles(BuildContext context, List<Map> requestList, String type, NewAppStateModel model) {
    return List.generate(requestList.length, (index){
      print(requestList[index]);
      double amount  = (requestList[index]['${DatabaseHelper.total_amount}'].toString() == 'null') ? 0.0
          : double.parse(requestList[index]['${DatabaseHelper.total_amount}'].toString());
      return Container(
        child: ListTile(
          onTap: () async {

            setState(() {
              if (type == 'accept'){acceptRequestTile = true;}
              else{requestSent = true;}

              if(requestList[index]['${DatabaseHelper.status}'] == 'accepted') {
                acceptStocks = true;
              }
              else{
                acceptStocks = false;
              }
            });
            if (acceptRequestTile) {
              await model.getStockRequestItemsFromDatabase(int.parse(requestList[index]['id'].toString()), 'dispatch', requestList[index]);
            }
            else {
              await model.getStockRequestItemsFromDatabase(int.parse(requestList[index]['id'].toString()), 'request', requestList[index]);
            }
          },
          title: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Request Time : ${requestList[index]['${DatabaseHelper.created_at}']}'),
                    flex: 2,
                    ),
                  Spacer(),
                  Expanded (
                    child: Text('Status : ${requestList[index]['${DatabaseHelper.status}']}',
                                  style: TextStyle(color: Color(0xff81c784)),
                                ),
                    flex: 2,
                    ),

                ],
                ),

              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('${requestList[index]['${DatabaseHelper.total_items}']} items'),
                    flex: 2,
                    ),
                  Spacer(),
                  Expanded(
                    child: Text('Total Amount : ${formatter.format(amount)}'),
                    flex: 2,
                    )

                ],

                ),
              Divider(color: Colors.black12,thickness: 1,height: 30,),
            ],
            ),
          ),
        );
    }).toList();
  }


  List<Container> buildRows(BuildContext context, List<Map> productList) {
    return List.generate(productList.length, (index){
      return Container(
        child: StockRow(product: productList[index]),
        );
    }).toList();
  }

  List<Container> buildEditableRows(BuildContext context, List<Map> productList) {
    return List.generate(productList.length, (index){
      return Container(
        child: StockRowEditable(product: productList[index]),
        );
    }).toList();
  }

  List<Container> buildRowsSentPage(BuildContext context, List<Map> productList) {
    return List.generate(productList.length, (index){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: StockRowSentPage(product: productList[index]),
        );
    }).toList();
  }

  List<Container> buildRowsNewStockPage(BuildContext context, List<Map> productList) {
    return List.generate(productList.length, (index){
      return Container(
        child: StockRowNewStockEditable(product: productList[index]),
        );
    }).toList();
  }

  List<Widget> _createShoppingCartRows(NewAppStateModel model) {
//    return model.productsInCart.keys
//        .map(
//            (id) => NewShoppingCartRow(id: id)
//            ).toList();


    List<NewShoppingCartRow> newCartListtype2 = [];
    if (model.editableListOfProductsInCart.length > 0) {
      for (var i = 0; i < model.editableListOfProductsInCart.length; i++) {
        newCartListtype2.add(NewShoppingCartRow(id: model.editableListOfProductsInCart[i]['id']));
      }
    }


    //print("Checking what is returned from _createShoppingCartRows : ${newCartListtype2[0].id}");
    return newCartListtype2;


  }




  @override
  Widget build(BuildContext context) {

    Widget shoppingCartRowSection = Container(
      color: Colors.white,
      child: ScopedModelDescendant<NewAppStateModel>(
        builder: (context, child, model) {
          return Column (
            children: _createShoppingCartRows(model),
            );
        },
        ),
      );

    return ScopedModelDescendant<NewAppStateModel> (
        builder: (context, child, model) {

          return Stack(
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[

                    Container(
                        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                        child: RaisedButton(
                          color: Color(0xff81c784),
                          child: Text('Request New Stocks'),
                          onPressed: (){
                            setState(() {
                              requestNewStocks = true;
                            });
                          },
                          )

                        ),
                    Divider(color: Colors.black12,thickness: 1,),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child:  RaisedButton(
                            color: !barSelection?Color(0xff64b5f6):Colors.white70,
                            child: Text('Accept Request'),
                            onPressed: () async {
                              await model.getStockRequestsFromDatabase('delivered');
                              setState(() {
                                barSelection = false;
                              });
                            },
                            ),
                          ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            color: barSelection?Color(0xff64b5f6):Colors.white70,
                            child: Text('Request History'),
                            onPressed: () async {
                              await model.getStockRequestsFromDatabase('all');
                              setState(() {
                                barSelection = true;
                              });
                            },
                            ),
                          ),

                      ],
                      ),

                    Divider(color: Colors.black12,thickness: 1,),
                    !barSelection?
                    Column(
                      children:  buildFirstScreenTiles(context, model.tempRequestStocksToDisplay, 'accept', model)
                      ,
                      )
                        :
                    Column(
                      children:  buildFirstScreenTiles(context, model.tempRequestStocksToDisplay, 'history', model),
                      ),


                  ],
                  ),
                ),
              acceptRequestTile?
              Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: <Widget>[
                      Container(
                          color: Colors.white,
                          child: Stack(
                            children: <Widget>[
                              ListView(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          icon: Icon(Icons.arrow_back_ios),
                                          onPressed: (){
                                            setState(() {
                                              acceptRequestTile = false;
                                            });
                                          },
                                          ),
                                        ),

                                      Expanded(
                                        flex: 20,
                                        child: Text('Accept Stocks',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontSize: 20)
                                                    ),
                                        ),
//
                                    ],
                                    ),

                                  Container(
                                      height: 40,
                                      color:
//          Color(0xffe48181),
                                      Color(0xff68d8c2),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Row(

                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                'Product',
//                                          textAlign: TextAlign.center,
                                                style: TextStyle(fontWeight: FontWeight.w500),
                                                ),
                                              flex: 5,
                                              ),
                                            Expanded(
                                              child: Text(
                                                'Quantity',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontWeight: FontWeight.w500),
                                                ),
                                              flex: 3,
                                              ),
                                            Expanded(
                                              child: Text(
                                                'Unit Price',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(fontWeight: FontWeight.w500),
                                                ),
                                              flex: 3,
                                              ),

                                          ],
                                          ),
                                        )

                                      ),

                                  Column(
                                      children:
                                      buildEditableRows(context, model.finalRequestStockItemsToDisplay)

                                      ),

                                ],

                                ),
                              Align(alignment: Alignment.bottomCenter,
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        height: 160,
                                        color: Colors.white,
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Divider(color: Colors.black,thickness: 1,height: 30,),
                                            Text('Total Amount : ${formatter.format(model.finalTotalStockRequestAmount)}',
                                                   style: TextStyle(fontSize: 20),
                                                 ),
                                            RaisedButton(
                                              color: Color(0xff81c784),
                                              child: Text('Accept Stocks'),
                                              onPressed: () async {
                                                await model.updateDatabaseOnAcceptStock();
                                                setState(() {
                                                  acceptStocks = true;
                                                });
                                              },
                                              )
                                          ],
                                          ),
                                        ),
                                    )
                            ],
                            )
                          ),

                      acceptStocks?
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          color: Colors.white,
                          child: Container(
                              child: Stack(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              icon: Icon(Icons.arrow_back_ios),
                                              onPressed: (){
                                                setState(() {
                                                  acceptStocks = false;
                                                  acceptRequestTile = false;
                                                });
                                              },
                                              ),
                                            ),
                                          Expanded(
                                            flex: 20,
                                            child: Text('Stocks Accepted',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(color: Colors.green,
                                                                               fontWeight: FontWeight.bold,fontSize: 20),
                                                        ),
                                            ),

                                        ],
                                        ),
                                      Text('Stocks Added to your inventory!',
                                             textAlign: TextAlign.center,
                                             style: TextStyle(color: Colors.green,
                                                                  fontSize: 15),
                                           ),
                                      Divider(height: 40,color: Colors.white,),
                                      Container(
                                          height: 40,
                                          color:
//          Color(0xffe48181),
                                          Color(0xff68d8c2),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            child: Row(

                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    'Product',
//                                          textAlign: TextAlign.center,
                                                    style: TextStyle(fontWeight: FontWeight.w500),
                                                    ),
                                                  flex: 5,
                                                  ),
                                                Expanded(
                                                  child: Text(
                                                    'Quantity',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontWeight: FontWeight.w500),
                                                    ),
                                                  flex: 3,
                                                  ),
                                                Expanded(
                                                  child: Text(
                                                    'Unit Price',
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(fontWeight: FontWeight.w500),
                                                    ),
                                                  flex: 3,
                                                  ),

                                              ],
                                              ),
                                            )

                                          ),


                                      Column(
                                          children:
                                          buildRows(context, model.tempRequestStockItemsToDisplay)

                                          ),


                                    ],
                                    ),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                                        height: 180,
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Divider(color: Colors.green,thickness: 2,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Text("Total : ${formatter.format(double.parse('${model.finalSelectedStock
                                                ['${DatabaseHelper.total_amount}']}'))}",textAlign: TextAlign.end,
                                                       style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,
                                                                            color: Colors.green),
                                                     ),
                                              ],
                                              ),
                                            Text("Order Time : ${model.finalSelectedStock['${DatabaseHelper.created_at}']}",
                                                   style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,),
                                                 ),
                                            Text("Accepted Time : ${model.finalSelectedStock['${DatabaseHelper.accepted_at}']}",
                                                   style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                                                 ),
                                          ],
                                          ),
                                        )
                                      )
                                ],
                                )
                              ),

                          ),
                        )
                          :
                      new Container(),
                    ],
                    )
                  )
                  :
              new Container(),

              requestNewStocks?
              Container(
                  color:Colors.white,
                  child: Stack(children: <Widget>[
                    ListView(
                      children: <Widget>[
                        QuickLinks(),
                        Container(
                            height: 40,
                            color:
//          Color(0xffe48181),
                            Color(0xff68d8c2),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Product',
                                      style: TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                    flex: 6,
                                    ),
                                  Expanded(
                                    child: Text(
                                      'QTY',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.w500),
                                      ),
                                    flex: 3,
                                    ),

                                ],
                                ),
                              )

                            ),
                        Container(
                            child: shoppingCartRowSection
                            ),
                      ],
                      ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 70, vertical: 40),
                        child:  RaisedButton(
                          color: Colors.greenAccent,
                          child: Text('Request Stocks'),
                          onPressed: () async {
                            await model.saveStockRequestToDatabase();
                            setState(() {
                              requestSent = true;
                            });
                          },
                          ),
                        ),
                      )
                  ])
                  )
                  :
              new Container(),
              requestSent?
              Container(
                  color: Colors.white,
                  child: Stack(
                    children: <Widget>[
                      ListView(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: (){
                                    model.getStockRequestsFromDatabase('delivered');
                                    setState(() {
                                      barSelection = false;
                                      requestSent = false;
                                      requestNewStocks = false;
                                    });
                                  },
                                  ),

                                ),
                              Expanded(
                                flex: 20,
                                child: Text('Request Stocks',textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 20),
                                            ),
                                ),
                            ],
                            ),
                          Divider(color: Colors.black,),
                          Container(
                            height: 20,
                            ),
                          Text('Request ${model.tempSelectedStock['${DatabaseHelper.status}']}',
                                 textAlign: TextAlign.center,
                                 style: TextStyle(color: Colors.green,fontSize: 17, fontWeight: FontWeight.bold),
                               ),
                          Container(
                            height: 20,
                            ),
                          Text('${model.tempSelectedStock['${DatabaseHelper.status}']} at ${model.tempSelectedStock['${DatabaseHelper.updated_at}']}',
                                 textAlign: TextAlign.center,
                                 style: TextStyle(fontSize: 16),
                               ),
                          Container(
                            height: 30,
                            ),
                          Column(
                            children: buildRowsSentPage(context, model.tempRequestStockItemsToDisplay),
                            ),

                        ],
                        ),
                      Align(alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: EdgeInsets.all(40),
                                  child: (model.tempSelectedStock['${DatabaseHelper.status}'].toString() != 'canceled') ?
                                  RaisedButton(
                                    child: Text('Cancel Request'),
                                    color: Color(0xffe48181),
                                    onPressed: () async {
                                      await model.cancelStockRequest(model.finalSelectedStock['id']);
                                      setState(() {
                                        requestSent = true;
                                        acceptStocks = false;
                                        requestNewStocks = false;
                                      });
                                    },
                                    ) :
                                  Text(""),
                                  )
                            )
                    ],
                    )
                  )
                  :
              model.currentDisplayCustomProductPage
                  ?
              Align(
                child: CustomItem(),
                alignment: Alignment.center,
                )
                  :
              new Container(),



            ],
            );
        }
        );




  }
}





class Item {
  Item({
    this.isExpanded = false,
  });
  bool isExpanded;
}
List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
    );
  });
}
List<Item> _data = generateItems(1);
class QuickLinks extends StatefulWidget {
  _QuickLinks createState() => _QuickLinks();
}

class _QuickLinks extends State<QuickLinks> {
  TextEditingController tc;
  @override
  Widget build(BuildContext context) {


    Widget _queryBox(NewAppStateModel model) {

      return Container(
          color: Colors.white,
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  model.selectedCategory != ''
                      ? Row(
                    children: <Widget>[
                      IconButton(

                          icon: Icon(Icons.navigate_before,
                                       size: 15,
                                     ),
                          onPressed: () {
                            goToParentCategory(model);
                          }
                          ),
                      Text(model.selectedCategory+'   ',
                             style: TextStyle(fontSize: 15),
                           ),


                    ],
                    )
                      : new Container(),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        child: SizedBox(
                          height: 40,
                          width: 280,
                          child: TextField(
                            controller: tc,
                            onChanged: (text) async{
                              searchCatalogue(model, text);
                            },
                            decoration: InputDecoration(
                              hintText: 'search',
                              filled: false,
                              prefixIcon: Icon(
                                Icons.search,
                                size: 18.0,
                                ),
                              ),

                            ),
                          ),
                        ),
                      SizedBox(
                        width: 1,
                        ),
                      OutlineButton(
                          color: Colors.white,
                          child: Container(
                            child: Row(children: <Widget>[
                              Icon(Icons.add,
                                       size: 14),
                              Text('Custom Item'),
                            ],
                                       ),
                            ),
                          onPressed: (){
                            model.getListOfCategories();
                            model.getListOfBrands();
                            setState(() {
                              model.updateFlagOfAddCustomItem(true);
                            });

                          },
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(19.0))
                          )
                    ],
                    )
                ],
                ),

            ],
            )
          );
    }



    Widget _buildPanel(NewAppStateModel model) {
      return ExpansionPanelList(
        expansionCallback: (int index,bool isExpanded) async{
          model.emptyStack();
          await queryForAll(model, 'initStack', '', '');
          setState(() {
            _data[index].isExpanded = !isExpanded;
          });
        },
        children: _data.map<ExpansionPanel>((Item item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Quick Links',
                                style: TextStyle(
//                                      fontWeight: FontWeight.bold,
fontSize: 16,color: Colors.black
)
                            ),
                );
            },
            body: Container(
//            height: 300,
//            width: 100,
child:Column(
  children:  <Widget>[
    _queryBox(model),
    NewProductPage(),
  ],
  )
),
            isExpanded: item.isExpanded,
            );
        }).toList(),
        );
    }
    return ScopedModelDescendant<NewAppStateModel>(
        builder: (context, child, model)
        {
          return Container(
            child: _buildPanel(model),
            );

        });
  }
}


final Map productDummy = {"id": 1, "name": "custom dal"};

class NewShoppingCartRow extends StatefulWidget {
  NewShoppingCartRow({@required this.id}
      );
  final String id;
  @override
  _NewShoppingCartRow createState() => _NewShoppingCartRow();
}

class _NewShoppingCartRow extends State<NewShoppingCartRow> {



  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.simpleCurrency(name: 'INR',decimalDigits: 2,);
    final localTheme = Theme.of(context);


    return ScopedModelDescendant<NewAppStateModel> (
        builder: (context, child, model) {

          final Map product =  model.getProductById(widget.id);
          final int quantity =  (model.editableListOfProductsInCart[model.editableListOfProductsInCart.indexWhere((p) => p['id'] == widget.id)]['quantity'].runtimeType.toString() == 'String') ?
          double.parse(model.editableListOfProductsInCart[model.editableListOfProductsInCart.indexWhere((p) => p['id'] == widget.id)]['quantity'].toString())
              :
          model.editableListOfProductsInCart[model.editableListOfProductsInCart.indexWhere((p) => p['id'] == widget.id)]['quantity'];

          TextEditingController quantityController = TextEditingController(text: '${quantity.toString()}');
          final _amountValidator = RegExInputFormatter.withRegex('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$');
          bool hasQuantityOnChangeAnalysisDone = false;


          return Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right:10),
                  child: Row(
                    children: <Widget>[
                      Text(product['name'].toString(),),
                      Spacer(),
                      InkWell(
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.clear,
                              size: 13.0,
                              ),
                            height: 25,width:40),


                        onTap: () async {
                          await model.removeEditableItemFromCart(product,  'remove_row');
                        },
                        ),


                    ],
                    ),
                  ),
                Row(
                  key: ValueKey(product['id'].toString()),
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [


                    const SizedBox(width: 30.0),
                    Expanded(
                      child: Container(

                      ),
                      flex: 2,
                      ),

                    Expanded(
                      child: Center(
                        child: Container(
                          width: 60.0,

                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  autofocus: false,
                                  controller: quantityController,
                                  inputFormatters: [_amountValidator],
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: false,
                                    ),
                                  onChanged: (text){print("\n\n Entered into on change Quantity\n\n");
                                  if (!hasQuantityOnChangeAnalysisDone) {
                                    hasQuantityOnChangeAnalysisDone = true;

                                    Future.delayed(const Duration(milliseconds: 45), () async{
                                      //Future.delayed(const Duration(milliseconds: 70), (){

                                      print("\n\n flagToCheckBarcodeState after 1 ms = ${model.flagToCheckBarcodeState}\n\n");
//                              print("\n\n oldSpValue = ${oldSpValue}\n\n");
                                      if (model.flagToCheckBarcodeState) {
                                        quantityController.text = product['quantity'].toString();
                                        print("\n\n quantityController inside if = ${quantityController.hashCode} :::: quantityController = ${quantityController.value}");
                                        print("\n\n\nChecking product in widget = $product\n\n\n");
                                      }
                                      else {
                                        print("\n\n mrpController inside else = ${quantityController.hashCode} :::: mrpController = ${quantityController.value}");
                                        print("\n\n\nChecking product in widget = $product\n\n\n");
                                      }
//                              print("\n\n spController = ${spController.value}\n\n");
                                      hasQuantityOnChangeAnalysisDone = false;
                                    });
                                  }

                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '${product['quantity'].toString()}'
                                      ),
                                  ),
                                ),
                              Container(
                                height: 48.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 0.5,
                                            ),
                                          ),
                                        ),
                                      child: InkWell(
                                        child: Icon(
                                          Icons.arrow_drop_up,
                                          size: 22.0,
                                          ),
                                        onTap: () async {
                                          await model.addEditableProductToCart(product);
                                        },
                                        ),
                                      ),
                                    InkWell(
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 22.0,
                                        ),
                                      onTap: () async {
                                        await model.removeEditableItemFromCart(product, "reduce_quantity");
                                      },
                                      ),
                                  ],
                                  ),
                                ),
                            ],
                            ),
                          ),
                        ),
                      flex: 4,
                      ),

                  ],
                  ),
                Divider(color: Color(0xff429585),thickness: 1,height: 4,)

              ],
              ),
            );
        });
  }
}



class RegExInputFormatter implements TextInputFormatter {
  final RegExp _regExp;

  RegExInputFormatter._(this._regExp);

  factory RegExInputFormatter.withRegex(String regexString) {
    try {
      final regex = RegExp(regexString);
      return RegExInputFormatter._(regex);
    } catch (e) {
      // Something not right with regex string.
      assert(false, e.toString());
      return null;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final oldValueValid = _isValid(oldValue.text);
    final newValueValid = _isValid(newValue.text);
    if (oldValueValid && !newValueValid) {
      return oldValue;
    }
    return newValue;
  }

  bool _isValid(String value) {
    try {
      final matches = _regExp.allMatches(value);
      for (Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }
}


class CustomItem extends StatefulWidget {
//  CustomItem({this.id});
//  final bool id;
  @override
  _CustomItem createState() => _CustomItem();
}

class _CustomItem extends State<CustomItem> {
  final customProductNameController  = TextEditingController();
  final customMRPController  = TextEditingController();
  final customSPController  = TextEditingController();
  final customQTYController  = TextEditingController();
  final customSGSTController  = TextEditingController();
  final customCGSTController  = TextEditingController();
  final customCESSController  = TextEditingController();
  final customCategoryController = TextEditingController();
  final customBrandController = TextEditingController();

  @override
  void initState() {
    super.initState();
//    customProductNameController.addListener();
  }

  @override
  void dispose() {
    customProductNameController.dispose();
    super.dispose();
  }
  String _selectedCategory;
  String _selectedBrand;

  final _amountValidator = RegExInputFormatter.withRegex('^\$|^(0|([1-9][0-9]{0,}))(\\.[0-9]{0,})?\$');

  @override
  Widget build(BuildContext context) {
//    _print(category, msg:'category in product_grid_view.dart');
    return ScopedModelDescendant<NewAppStateModel> (
        builder: (context, child, model)
        {

          List categories = (model.finalListOfCategories.length > 0) ? model.finalListOfCategories : ["Select Category"];
          List brands = (model.finalListOfBrands.length > 0) ? model.finalListOfBrands : ["Select Brand"];

          print("$categories :::: $brands");
          return Stack(
            children: <Widget>[
              Opacity(
                  opacity: .8,
                  child: InkWell(
                    onTap: (){
                      model.updateFlagOfAddCustomItem(false);
                    },
                    child: Container(
                      height: 5000,
                      width: 3000,
                      color: Colors.black,
                      ),
                    )
                  ),
              Align(
                alignment: Alignment.center,
                child: Card(
                  borderOnForeground: false,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: 500,
                    width: 370,
                    child: ListView(
                      //                              crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: <Widget>[
                            Text('Add Custom Item',
                                 ),
                            Spacer(),
                            InkWell(
                              child: Icon(
                                Icons.clear,
                                size: 22.0,
                                ),
                              onTap: () {
                                setState(() {
                                  model.updateFlagOfAddCustomItem(false);
                                });

                              },
                              ),
                          ],
                          ),
                        Divider(color: Color(0xff429585),thickness: 1,height: 10,),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10, right:10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text('Name',
                                            ),
                                flex: 1,
                                ),
                              Expanded(
                                child: Container(
                                  width: 150,
                                  child: TextField(
                                    controller: customProductNameController,
                                    //                              decoration: InputDecoration(
                                    //                                focusedBorder: UnderlineInputBorder(
                                    //                                  borderSide: BorderSide(color: Colors.black),
                                    //                                  ),
                                    //                                ),
                                    ),
                                  ),
                                flex: 4,
                                ),

                            ],
                            ),
                          ),

                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10, right:10),
                          child:
                          Row(
                            children: <Widget>[

                              Expanded(
                                child:Text('MRP ',
                                           ),
                                flex: 1,
                                ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: TextField(
                                    controller: customMRPController,
                                    inputFormatters: [_amountValidator],
//
                                    keyboardType: TextInputType.numberWithOptions(
                                      decimal: true,
                                      signed: false,
                                      ),
                                    onChanged: (text){
                                      //                                          model.changeProductValue(text, product, 'mrp');
                                      setState(() {
                                      });

                                    },
                                    ),
                                  ),
                                flex: 2,
                                ),
                              Expanded(
                                child: Text(''),
                                flex: 1,
                                ),
                              Expanded(
                                child:Text('SP   ',
                                           ),
                                flex: 1,
                                ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: TextField(
                                    controller: customSPController,
                                    inputFormatters: [_amountValidator],
                                    keyboardType: TextInputType.numberWithOptions(
                                      decimal: true,
                                      signed: false,
                                      ),
                                    onChanged: (text){
                                      //                                          model.changeProductValue(text, product, 'mrp');

                                    },

                                    ),
                                  ),
                                flex: 2,
                                ),




                            ],
                            ),
                          ),

                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10, right:10),
                          child:
                          Row(
                            children: <Widget>[

                              Expanded(
                                child: Text('SGST   ',
                                            ),
                                flex: 1,
                                ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  child: TextField(

                                    inputFormatters: [_amountValidator],
                                    controller: customSGSTController,
                                    keyboardType: TextInputType.numberWithOptions(
                                      decimal: true,
                                      signed: false,
                                      ),
                                    onChanged: (text){
                                      //                                          model.changeProductValue(text, product, 'mrp');

                                    },

                                    ),
                                  ),
                                flex: 2,
                                ),
                              Expanded(
                                child:Text('',
                                           ),
                                flex: 1,
                                ),
                              Expanded(
                                child:Text('CGST   ',
                                           ),
                                flex: 1,
                                ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  child: TextField(
                                    inputFormatters: [_amountValidator],
                                    controller: customCGSTController,
                                    keyboardType: TextInputType.numberWithOptions(
                                      decimal: true,
                                      signed: false,
                                      ),
                                    onChanged: (text){
                                      //                                          model.changeProductValue(text, product, 'mrp');

                                    },
                                    ),
                                  ),
                                flex: 2,
                                ),




                            ],
                            ),
                          ),

                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10, right:10),
                          child:



                          Row(
                            children: <Widget>[

                              Expanded(
                                child:Text('CESS',
                                           ),
                                flex: 1,
                                ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  width: 15,
                                  child: TextField(
                                    inputFormatters: [_amountValidator],
                                    controller: customCESSController,
                                    keyboardType: TextInputType.numberWithOptions(
                                      decimal: true,
                                      signed: false,
                                      ),
                                    onChanged: (text){
                                      //                                          model.changeProductValue(text, product, 'mrp');

                                    },

                                    ),
                                  ),
                                flex: 2,
                                ),
                              Expanded(
                                child:Text(' ',
                                           ),
                                flex: 4,
                                ),




                            ],
                            ),
                          ),

                        Padding(
                            padding: EdgeInsets.only(top: 10, left: 10, right:10),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: new DropdownButton<String>(
                                    items: categories.map((var value) {
                                      print("\n\n value dropdown = $value");
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                        );
                                    }).toList(),
                                    value: _selectedCategory,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedCategory = newValue;
                                      });
                                    },
                                    hint: Text('Select Category'),
                                    ),
                                  flex: 4,
                                  ),

                              ],
                              )
                            ),
                        Padding(
                            padding: EdgeInsets.only(top: 10, left: 10, right:10),
                            child: Row(
                              children: <Widget>[

                                Expanded(
                                  child: new DropdownButton<String>(
                                    items: brands.map((var value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                        );
                                    }).toList(),
                                    value: _selectedBrand,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedBrand = newValue;
                                      });
                                    },
                                    hint: Text('Select Brand'),
                                    ),
                                  flex: 4,
                                  )
                              ],
                              )
                            ),


                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10, right:10),
                          child:

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              RaisedButton(
                                //                                                    height: 50,
                                //                                                    width: 150,
                                child: Text('SUBMIT'),
                                  onPressed: ()async{
                                    if (customCESSController.text == ''){
                                      customCESSController.text = '0.0';
                                    }
                                    if (customCGSTController.text == ''){
                                      customCGSTController.text = '0.0';
                                    }
                                    if (customSGSTController.text == ''){
                                      customSGSTController.text = '0.0';
                                    }
                                    if(_selectedBrand == null){
                                      _selectedBrand = '';
                                    }
                                    if (_selectedCategory == null){_selectedCategory = '';
                                    }



                                    if (
                                    customProductNameController.text != '' &&
                                        customMRPController.text != '' &&
                                        customSPController.text != ''
                                    ){
                                      await model.addCustomItem(
                                        customProductNameController.text,
                                        customMRPController.text,
                                        customSPController.text,
                                        customCESSController.text,
                                        customCGSTController.text,
                                        customSGSTController.text,
                                        _selectedCategory,
                                        _selectedBrand,
                                        );
                                      await queryForAll(model, 'initStack', '', '');
                                      await model.updateFlagOfAddCustomItem(false);
                                    }
                                    else{
                                      Fluttertoast.showToast(
                                          msg: "!! Name, Mrp, SP must not be Empty",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIos: 1,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                          );
                                    }
                                  },

                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22.0)),
                                )
                            ],
                            ),
                          ),

                      ],
                      ),
                    ),
                  ),

                )
            ],
            );

        });
  }
}

class SelectCustomer extends StatefulWidget {


  @override
  _SelectCustomer createState() => _SelectCustomer ();
}



class _SelectCustomer extends State<SelectCustomer> {

  TextEditingController _customerNameController;
  TextEditingController _phoneController;
  TextEditingController _searchKeyController;
  String searchKey;
  @override
  Widget build(BuildContext context) {




    return ScopedModelDescendant<NewAppStateModel> (

        builder: (context, child, model) {

          List<Container> _buildCustomerTiles(BuildContext context) {

            List<Map> customerList = model.tempCustomersInDatabaseToDisplay;
            if (customerList == null || customerList.isEmpty) {
              print('build tiles : $customerList');
              return const <Container>[];
            }
            print('build tiles : ' + customerList.toString());
            return List.generate(customerList.length, (index) {
              return Container(
                child: ListTile (
                  title: Text(customerList[index]['name']),
                  subtitle: Column(crossAxisAlignment:CrossAxisAlignment.start,
                                     children: <Widget>[
                                       Text(customerList[index]['phone_number']),
                                       Divider(color: Color(0xff429585), thickness: 1,height: 30,)
                                     ],),
                  onTap: () async {
                    print("\n\ncustomerList[index]['id'] = ${customerList[index]['id']}");
                    int id = int.parse(customerList[index]['id'].toString());
                    await model.selectCustomerById(int.parse(customerList[index]['id'].toString()), "cart");
                    var selectedCustomer =  await model.selectedCustomer;
                    print('\nSelected Customer from Select Customer stack  :   ... $selectedCustomer');
                    await model.setSelectCustomerForCartFlag(false);


                  },
                  ),
                );
            }).toList() ;
          }

          return Stack(
            children: <Widget>[
              Container(
//                  height:440,
//            width: 5000,
color: Colors.white,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: <Widget>[


          Container(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: SizedBox(
                  height: 40,
                  width: 380,
                  child: TextField(
                    controller: _searchKeyController,

                    decoration: InputDecoration(
                      hintText: 'search by name or phone number',
                      filled: false,
                      prefixIcon: Icon(
                        Icons.search,
                        size: 14.0,
                        ),
                      ),
                    onChanged: (text) async{
                      await model.queryCustomerInDatabase("all", text);
                      await model.setAddCustomerForCartFlag(true);


                      //_buildCustomerTiles(context);
                    },

                    ),
                  ),
                )
              ),
          Container(height: 20,),
          Text('Select Customer',style: TextStyle(fontWeight: FontWeight.bold),),
          Divider(color: Colors.black12, thickness: 1, height: 20,),

          Column(
            children: _buildCustomerTiles(context),

            )


        ],
        ),
      )
),
              (model.tempCustomersInDatabaseToDisplay.length<=0) && model.addCustomerForCartFlag
                  ?
              Align(alignment: Alignment.centerRight,
                      child: Container(
//                  height:440,
//            width: 5000,
color: Colors.white,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: <Widget>[


          Container(
              height: 40,
              alignment: Alignment.centerLeft,
              child: Text('Create New', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),)
              ),
          Divider(color: Colors.black12, thickness: 1, height: 20,),
          Container(height: 20,),
          Text('Customer Phone Number', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          TextFormField(
            initialValue: model.prefillField == 'phone'? model.PrefillFieldContentCustomer:'',
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.phone)
                ),
            controller: _phoneController,
            maxLength: 10,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
            ),
          Container(height: 20,),
          Text('Customer Name', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          TextFormField(
            initialValue: model.prefillField == 'name'? model.PrefillFieldContentCustomer:'',
            controller: _customerNameController,

            ),
          Container(height: 20,),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
//                  width: 50,
child: RaisedButton(
  child: Text('CANCEL', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
  color: Color(0xffe48181),
  onPressed: ()async {
    await model.setAddCustomerForCartFlag(false);
//            addCustomer(_customerNameController.text, _phoneController.text);
  },
  ),
  flex: 2,
),

                Expanded(
                  child: Container(
                    width: 20,
                    ),
                  flex: 1,
                  ),
                Expanded(
//                  width: 50,
child: RaisedButton(
  child: Text('ADD', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
  color: Color(0xff81c784),
  onPressed: ()async {
    await model.addNewCustomer(_phoneController.text, _customerNameController.text, 'cart');
    print('customer added from the cart ... fkhgkhg');
//            addCustomer(_customerNameController.text, _phoneController.text);
  },
  ),
  flex: 2,
),

              ],
              ),
            )

        ],
        ),
      )
),)
                  :
              new Container()



            ],
            );
        }
        );



  }
}

class NewProductPage extends StatelessWidget {
//  final Category category;
//  const ProductPage({this.category = Category.all});
  @override
  Widget build(BuildContext context) {
//    _print(category, msg:'category in product_grid_view.dart');
    return ScopedModelDescendant<NewAppStateModel> (
        builder: (context, child, model) {

          return ProductGridView(
            products: model.getProducts(),
            categories: model.getCategories(),
            customProducts: model.getCustomProducts(),


            );
        });
  }
}
class ProductGridView extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final List<Map<String, dynamic>> categories;
  final List<Map<String, dynamic>> customProducts;

  const ProductGridView({Key key, this.products, this.categories, this.customProducts});

  List<Container> _buildProductCards(BuildContext context) {
    if (products == null || products.isEmpty) {
      return const <Container>[];
    }
    return List.generate(products.length, (index) {
      return Container(
        child: ProductCard(product: products[index]),
        );
    }).toList() ;
  }

  List<Container> _buildCategoryCards(BuildContext context) {
    if (categories == null || categories.isEmpty) {
      return const <Container>[];
    }
    return List.generate(categories.length, (index) {
      return Container(
        child: CategoryCard(category: categories[index]),
        );
    }).toList() ;
  }

  List<Container> _buildCustomProductsCards(BuildContext context) {
    if (customProducts == null || customProducts.isEmpty) {
      print(customProducts);
      return const <Container>[];
    }
    return List.generate(customProducts.length, (index) {
      return Container(
        child: ProductCard(product: customProducts[index]),
        );
    }).toList() ;
  }


  @override
  Widget build(BuildContext context) {

    return new Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 180.0,
            child: new GridView.count(
              scrollDirection: Axis.horizontal,
              primary: false,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children:
              _buildCustomProductsCards(context)
                  +
                  _buildCategoryCards(context)
                  +
                  _buildProductCards(context)
              ,

              ),
            ),
          ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
      );



  }
}

class ProductCard extends StatelessWidget {
  ProductCard({this.imageAspectRatio = 33 / 49, this.product})
      : assert(imageAspectRatio == null || imageAspectRatio > 0);

  final double imageAspectRatio;
  final Map<String, dynamic> product;




  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat.simpleCurrency(name: 'INR',
                                                                   decimalDigits: 0, locale: Localizations.localeOf(context).toString());
    final ThemeData theme = Theme.of(context);



    return ScopedModelDescendant<NewAppStateModel>(
        builder: (context, child, model) => GestureDetector(
          onTap: () {
            final discount = (model.Discount == null) ? 0.0 : model.Discount;
//          addProductToCart(model, product);
            model.addEditableProductToCart(product);
//            model.calculateCartTotalValue(discount.toString());


            Fluttertoast.showToast(
                msg: "Product Added",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
                );

          },
          child: child,
          ),
        child:
        Container(
          padding: EdgeInsets.all(7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                product == null ? '  ' : product['name'].toString(),
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
//                        theme.textTheme.button,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                ),
              Spacer(),
              Text(
                product == null || product['sp'] == "" ? '' : formatter.format(product['sp']),
                //                          style:
                //                          theme.textTheme.caption,

                ),
            ],
            ),
          color: Color(0xff68d8c2),
          )

        );
  }
}

class CategoryCard extends StatelessWidget {
  CategoryCard({this.imageAspectRatio = 33 / 49, this.category})
      : assert(imageAspectRatio == null || imageAspectRatio > 0);

  final double imageAspectRatio;
  final Map<String, dynamic> category;


  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat.simpleCurrency(name: 'INR',
                                                                   decimalDigits: 2, locale: Localizations.localeOf(context).toString());
    final ThemeData theme = Theme.of(context);

    return ScopedModelDescendant<NewAppStateModel>(
        builder: (context, child, model) => GestureDetector(
          onTap: () {
            onTapCategoryEntry(model, category);
            model.setCategory(category['name']);
          },
          child: child,
          ),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 50.0,
                  width: 221.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        category == null ? '' : category['name'].toString(),
                        style: theme.textTheme.button,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        ),

                    ],
                    ),
                  ),),
            ],
            ),
          color: Color(0xff429582),
          )
        );
  }
}



class StockRow extends StatelessWidget {
  StockRow({@required this.product});
  final Map product;


  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.simpleCurrency(name: 'INR',
                                                    decimalDigits: 2,
                                                  //                                                      locale: Localizations.localeOf(context).toString()
                                                  );


    return ScopedModelDescendant<NewAppStateModel> (
        builder: (context, child, model) {

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(

                    children: [
                      Expanded(
                        child: Text(((product['storeProductName'].toString() == 'null') ?
                        product['customProductName'].toString(): product['storeProductName'].toString())),
                        flex: 6,
                        ),

                      Expanded(
                        flex: 3,
                        child: Text(product['${DatabaseHelper.accepted_qty}'].toString(),
                                      textAlign: TextAlign.center,),
                        ),
                      Expanded(
                        child: new Text(formatter.format(double.parse(product['${DatabaseHelper.product_price}'].toString())),
                                          textAlign: TextAlign.end,
                                        ),
                        flex: 3,
                        ),


                    ],
                    ),
                  ),
                Divider(color: Color(0xff81c784), thickness: 1,)
              ],
              ),
            );
        });
  }
}



class StockRowEditable extends StatelessWidget {
  StockRowEditable({@required this.product});
  final Map product;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NewAppStateModel> (
        builder: (context, child, model) {
          TextEditingController quantityController = TextEditingController(text: '${int.parse(product['${DatabaseHelper.accepted_qty}'].toString())}');
          return Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [

                Row(
                  key: ValueKey(product['id'].toString()),
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Expanded(
                      child: Text((product['storeProductName'].toString() == 'null') ?
                                  product['customProductName'].toString(): product['storeProductName'].toString()),
                      flex: 6,
                      ),

                    Expanded(
                      child: Center(
                        child: Container(
                          width: 60.0,

                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: TextFormField(


//                                  focusNode: quantityFocusNode,
autofocus: false,
//                                          initialValue: quantity.toString(),
                                  controller: quantityController,
                                  keyboardType: TextInputType.number,

                                  onChanged: (text) async {
                                    await model.acceptStockQuantitySetter(product['id'], int.parse(quantityController.text));
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '${product['${DatabaseHelper.delivered_qty}'].toString()}'
                                      ),
),
                                ),
                              Container(
                                height: 48.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 0.5,
                                            ),
                                          ),
                                        ),
                                      child: InkWell(
                                        child: Icon(
                                          Icons.arrow_drop_up,
                                          size: 22.0,
                                          ),
                                        onTap: () async {
                                          await model.acceptStockQuantitySetter(product['id'], int.parse(quantityController.text) + 1);
                                        },
                                        ),
                                      ),
                                    InkWell(
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 22.0,
                                        ),
                                      onTap: () async {
                                        await model.acceptStockQuantitySetter(product['id'], int.parse(quantityController.text) - 1);
                                      },

                                      ),
                                  ],
                                  ),
                                ),
                            ],
                            ),
                          ),
                        ),
                      flex: 4,
                      ),
                    Expanded(
                      child: new Text('${formatter.format(double.parse(product['${DatabaseHelper.product_price}'].toString()))}',
                                        textAlign: TextAlign.end,
                                      ),
                      flex: 3,
                      ),

                  ],
                  ),
                Divider(color: Color(0xff429585),thickness: 1,height: 10,)

              ],
              ),
            );
        }
        );
  }

}

class StockRowNewStockEditable extends StatelessWidget {
  StockRowNewStockEditable({@required this.product});
  final Map product;
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NewAppStateModel> (
        builder: (context, child, model) {
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    children: [

                      Row(

                        key: ValueKey(product['id'].toString()),
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [



                          Expanded(
                            child: Text(product['name']),
                            flex: 6,
                            ),

                          Expanded(
                            child: Center(
                              child: Container(
                                width: 60.0,

                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(


//                                  focusNode: quantityFocusNode,
autofocus: false,
//                                          initialValue: quantity.toString(),
//                                  controller: quantityController,
                                        keyboardType: TextInputType.number,

                                        onChanged: (text){

                                        },
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '${product['qty'].toString()}'
                                            ),
),
                                      ),
                                    Container(
                                      height: 48.0,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  width: 0.5,
                                                  ),
                                                ),
                                              ),
                                            child: InkWell(
                                              child: Icon(
                                                Icons.arrow_drop_up,
                                                size: 22.0,
                                                ),
                                              onTap: () {

                                              },
                                              ),
                                            ),
                                          InkWell(
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 22.0,
                                              ),
                                            onTap: () {

                                            },
                                            ),
                                        ],
                                        ),
                                      ),
                                  ],
                                  ),
                                ),
                              ),
                            flex: 4,
                            ),

                        ],
                        ),


                    ],
                    ),
                  ),
                Divider(color: Color(0xff429585),thickness: 1,height: 1,)
              ],
              ),
            );
        }
        );
  }
}


class StockRowSentPage extends StatelessWidget {
  StockRowSentPage({@required this.product});
  final Map product;


  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.simpleCurrency(name: 'INR', decimalDigits: 2,);


    return ScopedModelDescendant<NewAppStateModel> (
        builder: (context, child, model) {

          return Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [

                Row(

                  children: [
                    Expanded(
                      child: Text((product['storeProductName'].toString() == 'null') ?
                                  product['customProductName'] : product['storeProductName']),
                      flex: 9,
                      ),

                    Expanded(
                      flex: 3,
                      child: Text((model.tempSelectedStock[DatabaseHelper.status] == 'delivered') ? product['delivered_qty'].toString() :
                                  (model.tempSelectedStock[DatabaseHelper.status] == 'accepted') ? product['${DatabaseHelper.accepted_qty}'].toString() :
                                  product['${DatabaseHelper.requested_qty}'].toString(),
                                    textAlign: TextAlign.end,),
                      ),

                  ],
                  ),
                Container(
                  height: 10,
                  ),
                Divider(color: Color(0xff429585),thickness: 1)

              ],
              ),
            );
        });
  }
}