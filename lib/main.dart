import 'package:flutter/material.dart';

class ParallaxSliverAppBar extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double expandedHeight;

  ParallaxSliverAppBar({
    required this.title,
    required this.imageUrl,
    this.expandedHeight = 300.0,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: expandedHeight,
      backgroundColor: Colors.grey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(title),
        background: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[400],
              child: Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomSliverGrid extends StatelessWidget {
  final List<String> items;

  CustomSliverGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        childAspectRatio: 0.75,
      ),
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(8.0), // Add margin around each grid item
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 4.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                items[index],
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[400],
                    child: Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
        childCount: items.length,
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parallax Sliver App Bar Example',
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            ParallaxSliverAppBar(
              title: 'CoxyCode',
              imageUrl:
              'https://images.unsplash.com/photo-1497215728101-856f4ea42174?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 16.0),
            ),
            CustomSliverGrid(
              items: [
                'https://images.unsplash.com/photo-1537498425277-c283d32ef9db',
                'https://images.unsplash.com/photo-1498050108023-c5249f4df085',
                'https://images.unsplash.com/photo-1518770660439-4636190af475',
                'https://images.unsplash.com/photo-1555066931-4365d14bab8c',
                'https://images.unsplash.com/photo-1537498425277-c283d32ef9db',
                'https://images.unsplash.com/photo-1498050108023-c5249f4df085',
                'https://images.unsplash.com/photo-1518770660439-4636190af475',
                'https://images.unsplash.com/photo-1555066931-4365d14bab8c',
              ],
            ),
          ],
        ),
      ),
    );
  }
}