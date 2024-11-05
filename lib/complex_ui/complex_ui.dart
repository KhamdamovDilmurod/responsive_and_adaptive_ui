import 'package:flutter/material.dart';

class CategorySectionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("chorva"),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Oziq-ovqat'),
              _buildSection(
                backgroundColor: Color(0xFFFAF7F5),
                firstRowItems: [
                  FlexItem(
                    flex: 2,  // Takes 2/3 of the width
                    title: 'Ichimliklar',
                    imageUrl: 'https://images.unsplash.com/photo-1544145945-f90425340c7e',
                  ),
                  FlexItem(
                    flex: 1,  // Takes 1/3 of the width
                    title: 'Non',
                    imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff',
                  ),
                ],
                secondRowItems: [
                  FlexItem(
                    flex: 1,
                    title: 'Baliq',
                    imageUrl: 'https://images.unsplash.com/photo-1544943910-4c1dc44aab44',
                  ),
                  FlexItem(
                    flex: 1,
                    title: 'Meva',
                    imageUrl: 'https://images.unsplash.com/photo-1619566636858-adf3ef46400b',
                  ),
                  FlexItem(
                    flex: 1,
                    title: "Go'sht",
                    imageUrl: 'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f',
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSectionHeader('Maishiy texnika'),
              _buildSection(
                backgroundColor: Color(0xFFF0F7FF),
                firstRowItems: [
                  FlexItem(
                    flex: 2,
                    title: 'Uy jihozlari',
                    imageUrl: 'https://images.unsplash.com/photo-1574269909862-7e1d70bb8078',
                  ),
                  FlexItem(
                    flex: 1,
                    title: 'Oshxona',
                    imageUrl: 'https://images.unsplash.com/photo-1556911220-bff31c812dba',
                  ),
                ],
                secondRowItems: [
                  FlexItem(
                    flex: 1,
                    title: "O'yinlar",
                    imageUrl: 'https://images.unsplash.com/photo-1538895490524-987f40c8c847',
                  ),
                  FlexItem(
                    flex: 1,
                    title: 'Telefon',
                    imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9',
                  ),
                  FlexItem(
                    flex: 1,
                    title: 'Noutbuk',
                    imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Barchasi',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required Color backgroundColor,
    required List<FlexItem> firstRowItems,
    required List<FlexItem> secondRowItems,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // First row with flexible items
          SizedBox(
            height: 140,
            child: Row(
              children: firstRowItems.map((item) => Expanded(
                flex: item.flex,
                child: _buildGridItem(item.title, item.imageUrl),
              )).toList(),
            ),
          ),
          // Second row with equal width items
          SizedBox(
            height: 140,
            child: Row(
              children: secondRowItems.map((item) => Expanded(
                flex: 1,
                child: _buildGridItem(item.title, item.imageUrl),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(String title, String imageUrl) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: Icon(Icons.error_outline, color: Colors.red),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper class to define items with flex values
class FlexItem {
  final int flex;
  final String title;
  final String imageUrl;

  FlexItem({
    required this.flex,
    required this.title,
    required this.imageUrl,
  });
}