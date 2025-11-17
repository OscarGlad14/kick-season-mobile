import 'package:flutter/material.dart';
import 'package:kick_season/models/product_entry.dart';
import 'package:kick_season/widgets/left_drawer.dart';
import 'package:kick_season/screens/product_detail.dart';
import 'package:kick_season/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductEntryListPage extends StatefulWidget {
  const ProductEntryListPage({super.key});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  String currentFilter = '';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    String url = 'http://localhost:8000/show-json-filtered/?';
    
    if (currentFilter.isNotEmpty) {
      url += 'filter=$currentFilter&';
    }
    
    if (searchQuery.isNotEmpty) {
      url += 'search=$searchQuery&';
    }
    
    if (url.endsWith('&') || url.endsWith('?')) {
      url = url.substring(0, url.length - 1);
    }
    
    final response = await request.get(url);
    
    var data = response;
    
    List<ProductEntry> listProducts = [];
    for (var d in data) {
      if (d != null) {
        listProducts.add(ProductEntry.fromJson(d));
      }
    }
    return listProducts;
  }

  void _refreshProducts() {
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Entry List'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Column(
        children: [
          // Search Bar and Filter Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  searchQuery = '';
                                });
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                
                const SizedBox(width: 8),
                
                // Filter Button
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: PopupMenuButton<String>(
                    icon: const Icon(Icons.filter_list, color: Colors.white),
                    tooltip: 'Filter',
                    offset: const Offset(0, 50),
                    onSelected: (value) {
                      setState(() {
                        currentFilter = value;
                      });
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: '',
                        child: Row(
                          children: [
                            Text(
                              'All Products',
                              style: TextStyle(
                                fontWeight: currentFilter == '' ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'my',
                        child: Row(
                          children: [
                            Text(
                              'My Products',
                              style: TextStyle(
                                fontWeight: currentFilter == 'my' ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'featured',
                        child: Row(
                          children: [
                            Text(
                              'Featured',
                              style: TextStyle(
                                fontWeight: currentFilter == 'featured' ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          if (currentFilter.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Chip(
                    label: Text(
                      currentFilter == 'my' ? 'My Products' : 'Featured',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blueGrey,
                    deleteIcon: const Icon(Icons.close, color: Colors.white, size: 18),
                    onDeleted: () {
                      setState(() {
                        currentFilter = '';
                      });
                    },
                  ),
                ],
              ),
            ),
          
          const SizedBox(height: 8),
          
          // Product List
          Expanded(
            child: FutureBuilder(
              future: fetchProduct(request),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 80, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(
                            'Error: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _refreshProducts,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 80, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'No products found.',
                          style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                        ),
                      ],
                    ),
                  );
                }
                else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      _refreshProducts();
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => ProductEntryCard(
                        product: snapshot.data![index],
                        onTap: () {
                          // Navigate to product detail page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                product: snapshot.data![index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}