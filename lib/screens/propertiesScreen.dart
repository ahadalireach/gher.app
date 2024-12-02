// ignore_for_file: sort_child_properties_last, library_private_types_in_public_api, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/propertyCard.dart';

class PropertiesScreen extends StatefulWidget {
  @override
  _PropertiesScreenState createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen> {
  List<Map<String, dynamic>> properties = [];
  bool isLoading = true;
  bool hasError = false;
  String filterText = '';
  String sortOption = 'Sort by Price';

  @override
  void initState() {
    super.initState();
    fetchProperties();
  }

  Future<void> fetchProperties() async {
    try {
      final response = await http.get(
          Uri.parse("https://gher-api.vercel.app/properties/view-properties"));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          properties = data.map((property) {
            return {
              'id': property['_id'],
              'title': property['title'],
              'description': property['description'],
              'price': property['regularPrice'].toString(),
              'image': property['imageUrls'][0],
              'bedrooms': property['bedrooms'],
              'bathrooms': property['bathrooms'],
              'area': property['area'],
              'location': property['address'],
            };
          }).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  List<Map<String, dynamic>> get filteredProperties {
    List<Map<String, dynamic>> filtered = properties
        .where((property) => property['title']
            .toString()
            .toLowerCase()
            .contains(filterText.toLowerCase()))
        .toList();

    if (sortOption == 'Sort by Price') {
      filtered.sort((a, b) => int.parse(a['price'].replaceAll(',', ''))
          .compareTo(int.parse(b['price'].replaceAll(',', ''))));
    } else if (sortOption == 'Sort by Oldest') {}

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Properties'),
        backgroundColor: Colors.green,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Search by Title',
                          labelStyle: TextStyle(color: Colors.green),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.green),
                        ),
                        onChanged: (value) {
                          setState(() {
                            filterText = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButton<String>(
                        value: sortOption,
                        isExpanded: true,
                        icon: const Icon(Icons.sort, color: Colors.green),
                        items: <String>['Sort by Price', 'Sort by Oldest']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            sortOption = newValue!;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            filterText = '';
                            sortOption = 'Sort by Price';
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.clear_all,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Clear Filters',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          shadowColor: Colors.greenAccent.withOpacity(0.4),
                          elevation: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      ],
                    ),
                  )
                : hasError
                    ? Center(
                        child: Text(
                          'Failed to load properties. Please try again later.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: filteredProperties.length,
                          itemBuilder: (context, index) {
                            return PropertyCard(
                                property: filteredProperties[index]);
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
