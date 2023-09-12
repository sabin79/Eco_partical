import 'package:flutter/material.dart';

import 'product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> productlist = [];
  List<Product> searchList = [];
  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  void addProduct() {
    final product = Product(
      productName: controllers[0].text,
      productDescription: controllers[1].text,
      productPrice: double.parse(controllers[2].text),
    );
    setState(() => productlist.add(product));
    for (var controller in controllers) {
      controller.clear();
    }
  }

  void searchProduct({required String searchKey}) {
    setState(() {
      if (searchKey.isNotEmpty) {
        if (searchList.isEmpty) searchList = List.from(productlist);
        productlist = productlist
            .where((element) => element.productName
                .toLowerCase()
                .contains(searchKey.toLowerCase()))
            .toList();
      } else {
        productlist = List.from(searchList);
        searchList = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.green)),
                child: TextField(
                  onChanged: (val) {
                    searchProduct(searchKey: val);
                  },
                  decoration: const InputDecoration(
                    hintText: "Search Product",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              const Text('Add Product',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              ...controllers
                  .map(
                    (controller) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.green),
                        ),
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: [
                              "Product Name",
                              "Product Description",
                              "Product Price"
                            ][controllers.indexOf(controller)],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              const SizedBox(height: 35),
              InkWell(
                onTap: addProduct,
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25)),
                  child: const Center(
                    child: Text('ADD PRODUCT',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              const Center(
                child: Text(' Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: productlist.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        productlist[index].productName,
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(productlist[index].productDescription),
                      trailing: Text(
                        productlist[index].productPrice.toStringAsFixed(2),
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
