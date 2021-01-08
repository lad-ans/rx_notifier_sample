import 'package:flutter/material.dart';
import 'package:new_rx/app/modules/home/home_controller.dart';
import 'package:rx_notifier/rx_notifier.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final homeController = HomeController();
  final controller = TextEditingController();

  AppBar appBar = AppBar(title: Text('RxNotifier'));
  double get appBarHeight => appBar.preferredSize.height;
  double get statusBarHeight => MediaQuery.of(context).padding.top;
  double get screenHeight => MediaQuery.of(context).size.height;

  double get totalScreenSubt => appBarHeight + statusBarHeight + 120;

  _buildTextField() => TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          hintText: 'Digite aqui . . .',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
        onChanged: (value) {
          homeController.item = value;
        },
      );

  ListView _buildListView(List<String> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  list[index],
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    homeController.removeItem(index);
                  },
                ),
              ),
              if (index != list[index].length) Divider(color: Colors.green),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 45,
                    child: _buildTextField(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: RxBuilder(builder: (_) {
                    return IconButton(
                      icon: Icon(Icons.send, color: Colors.green),
                      onPressed: homeController.item != null
                          ? () {
                              homeController.addItem();
                              controller.clear();
                              homeController.item = null;
                            }
                          : null,
                    );
                  }),
                )
              ],
            ),
          ),
          RxBuilder(builder: (_) {
            return Visibility(
              visible: homeController.list.length > 0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: screenHeight - totalScreenSubt,
                  decoration: BoxDecoration(
                      color: Colors.black12.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: RxBuilder(
                    builder: (context) {
                      List<String> list = homeController.list.reversed.toList();
                      return _buildListView(list);
                    },
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: _buildBody(),
    );
  }
}
