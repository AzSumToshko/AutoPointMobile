import 'package:auto_point_mobile/controllers/product_controller.dart';
import 'package:auto_point_mobile/pages/home/page_body.dart';
import 'package:auto_point_mobile/pages/home/search_page.dart';
import 'package:auto_point_mobile/utils/colors.dart';
import 'package:auto_point_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  final directory;

  MainPage({Key? key, required this.directory}) : super(key: key);

  @override
  State<MainPage> createState() => _State(directory: directory);
}

class _State extends State<MainPage> {

  final directory;

  Future<void> _loadResource() async {
    await Get.find<ProductController>();
  }

  _State({required this.directory});
  @override
  Widget build(BuildContext context) {

    TextEditingController _searchController = TextEditingController();
    _searchController.text = Get.find<ProductController>().searchInput;

    _appBar(height) => PreferredSize(
      preferredSize:  Size(MediaQuery.of(context).size.width, height+80 ),
      child: Stack(
        children: <Widget>[
          Container(     // Background
            color:AppColors.mainColor,
            height: height+75,
            width: MediaQuery.of(context).size.width,     // Background
            child: Center(
              child: Image.asset("assets/image/logo.png",height: Dimensions.height45,color: Colors.white,)),
          ),

          Container(),   // Required some widget in between to float AppBar

          Positioned(// To take AppBar Size only
            top: 100.0,
            left: 20.0,
            right: 20.0,
            child: AppBar(
              backgroundColor: Colors.white,
              leading: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("assets/image/fav.png",),
              ),
              primary: false,
              title: TextField(
                onChanged: (String input){
                  Get.find<ProductController>().setSearchInput(input);
                },
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  controller: _searchController,
                  decoration: const InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey))),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search, color: AppColors.mainColor), onPressed: () {
                    if(_searchController.text.isNotEmpty){
                      Get.to(SearchPage(products: Get.find<ProductController>().getProductsContaining(), directory: directory));
                    }
                },),
              ],
            ),
          )

        ],
      ),
    );

    return RefreshIndicator(
      onRefresh: _loadResource,
      child: Scaffold(
        appBar: _appBar(AppBar().preferredSize.height),
        body: Column(
          children: [
            Expanded(child: SingleChildScrollView(
              child: PageBody(directory: directory),
            )),
          ],
        ),
      ),
    );
  }
}
