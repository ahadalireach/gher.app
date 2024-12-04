import 'package:flutter/material.dart';
import 'propertiesScreen.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Us',
              style: TextStyle(
                color: Colors.green[700],
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Your Top Choice for Real Estate.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Bringing honesty and community to real estate, helping you find the perfect property and build strong relationships.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              "Features",
              style: TextStyle(
                color: Colors.green[700],
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildFeatureItem(Icons.home, 'Modern Home Designs'),
            _buildFeatureItem(Icons.park, 'Beautiful, Peaceful Locations'),
            _buildFeatureItem(Icons.bed, 'Comfortable Living Spaces'),
            _buildFeatureItem(
                Icons.handshake, 'Friendly and Trustworthy Service'),
            const SizedBox(height: 24.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.green[100]!),
              ),
              child: Text(
                'We’re here to make your real estate journey smooth and easy. Our goal is to build strong, lasting relationships with every client we serve.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.green[700],
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PropertiesScreen(),
                    ),
                  );
                },
                child: const Center(
                  child: Text(
                    'Explore Properties',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Center(
              child: Text(
                'Our Services',
                style: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24.0),
            _buildServiceCardRow(
              Icons.home,
              'Buy Your Dream Home',
              'Find the perfect home for your family with our help at every step.',
              'Explore Properties',
              context,
            ),
            _buildServiceCardRow(
              Icons.rss_feed,
              'Rent a Comfortable Home',
              'Discover rental homes for short or long stays that meet your needs.',
              'Find Rental Options',
              context,
            ),
            _buildServiceCardRow(
              Icons.business,
              'Commercial Properties',
              'Find the best commercial properties to meet your business needs.',
              'Explore Commercials',
              context,
            ),
            _buildServiceCardRow(
              Icons.local_offer,
              'Exclusive Offers',
              'Get access to exclusive deals and discounts on properties.',
              'Check Offers',
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.green[700], size: 32.0),
        const SizedBox(width: 12.0),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCardRow(IconData icon, String title, String description,
      String buttonText, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: _buildServiceCard(
        icon,
        title,
        description,
        buttonText,
        context,
      ),
    );
  }

  Widget _buildServiceCard(IconData icon, String title, String description,
      String buttonText, BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 48.0, color: Colors.green[700]),
              const SizedBox(height: 16.0),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PropertiesScreen()),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green[700],
                ),
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
