// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SinglePropertyScreen extends StatefulWidget {
  final String propertyId;

  const SinglePropertyScreen({required this.propertyId});

  @override
  _SinglePropertyScreenState createState() => _SinglePropertyScreenState();
}

class _SinglePropertyScreenState extends State<SinglePropertyScreen> {
  bool isLoading = true;
  bool hasError = false;
  Map<String, dynamic>? propertyDetails;

  @override
  void initState() {
    super.initState();
    fetchPropertyDetails();
  }

  Future<void> fetchPropertyDetails() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://gher-api.vercel.app/properties/view-property/${widget.propertyId}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null &&
            data.containsKey('_id') &&
            data.containsKey('title')) {
          setState(() {
            propertyDetails = data;
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            hasError = true;
          });
        }
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Details'),
      ),
      body: isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    strokeWidth: 6.0,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Loading Properties...',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : hasError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Failed to load properties. Please try again later.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                            hasError = false;
                          });
                          fetchPropertyDetails();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          'Retry',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (propertyDetails?['imageUrls'] != null)
                        SizedBox(
                          height: 300, // Set a height for the image carousel
                          child: PageView.builder(
                            itemCount: propertyDetails!['imageUrls'].length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                propertyDetails!['imageUrls'][index],
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8.0),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.green, width: 1),
                              ),
                              child: Text(
                                propertyDetails?['purpose'] == 'sell'
                                    ? 'Sell'
                                    : 'Rent',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: Colors.green.shade200,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.green, width: 1),
                              ),
                              child: Text(
                                propertyDetails?['offer'] == true
                                    ? 'Offer'
                                    : 'No Offer',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          propertyDetails?['title'] ?? '',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 22, color: Colors.green),
                            const SizedBox(width: 4),
                            Text(
                              propertyDetails?['address'] ?? 'Unknown Location',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.account_balance_wallet,
                              size: 22,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'PKR ${propertyDetails != null && propertyDetails!['offer'] == true ? propertyDetails!['discountPrice'] : propertyDetails?['price']}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.aspect_ratio,
                              size: 22,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${propertyDetails?['area'] ?? 'N/A'}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          propertyDetails?['description'] ??
                              'No description available.',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
    );
  }
}
