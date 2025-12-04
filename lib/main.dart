import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlatformView Scroll Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PlatformViewListScreen(),
    );
  }
}

class PlatformViewListScreen extends StatelessWidget {
  const PlatformViewListScreen({super.key});

  // Indices where PlatformView will be placed (8 items at multiples of 6)
  static const Set<int> platformViewIndices = {0, 6, 12, 18, 24, 30, 36, 42};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('PlatformView Scroll Test'),
      ),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          if (platformViewIndices.contains(index)) {
            return NativeAdCard(key: ValueKey(index), index: index);
          }
          return ProfileCard(key: ValueKey(index), index: index);
        },
      ),
    );
  }
}

/// Simulates a native ad view using PlatformView (AndroidView with TLHC)
class NativeAdCard extends StatefulWidget {
  final int index;

  const NativeAdCard({super.key, required this.index});

  @override
  State<NativeAdCard> createState() => _NativeAdCardState();
}

class _NativeAdCardState extends State<NativeAdCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: 150,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: AndroidView(
          viewType: 'android_text_view',
          layoutDirection: TextDirection.ltr,
          creationParams: <String, dynamic>{
            'text': 'Ad #${widget.index}',
            'imageUrl': 'https://picsum.photos/seed/${widget.index}/1200/600',
          },
          creationParamsCodec: const StandardMessageCodec(),
        ),
      ),
    );
  }
}

/// A simple profile card widget (pure Flutter, no PlatformView)
class ProfileCard extends StatelessWidget {
  final int index;

  const ProfileCard({super.key, required this.index});

  static const List<Color> _avatarColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: _avatarColors[index % _avatarColors.length],
              child: Text(
                'T$index',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Title $index',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'user$index@example.com',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _StatChip(icon: Icons.star, value: '${(index * 7) % 100}'),
                      const SizedBox(width: 8),
                      _StatChip(icon: Icons.people, value: '${(index * 13) % 500}'),
                      const SizedBox(width: 8),
                      _StatChip(icon: Icons.article, value: '${(index * 3) % 50}'),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Follow'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String value;

  const _StatChip({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey[500]),
        const SizedBox(width: 4),
        Text(value, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
