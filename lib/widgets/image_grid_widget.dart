import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Widget to display a grid of images for wall posts
class ImageGridWidget extends StatelessWidget {
  final List<String> imageUrls;
  final VoidCallback? onImageTap;

  const ImageGridWidget({
    super.key,
    required this.imageUrls,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) return const SizedBox.shrink();

    final imageCount = imageUrls.length;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: _buildImageLayout(context, imageCount),
    );
  }

  Widget _buildImageLayout(BuildContext context, int count) {
    switch (count) {
      case 1:
        return _buildSingleImage(context, 0);
      case 2:
        return _buildTwoImages(context);
      case 3:
        return _buildThreeImages(context);
      case 4:
        return _buildFourImages(context);
      default: // 5 or more
        return _buildFiveImages(context);
    }
  }

  Widget _buildSingleImage(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => _openImageViewer(context, index),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrls[index],
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: 300,
              color: Colors.grey.shade200,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 300,
              color: Colors.grey.shade200,
              child: const Center(
                child: Icon(Icons.broken_image, size: 64, color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTwoImages(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildImageTile(context, 0, height: 200)),
        const SizedBox(width: 4),
        Expanded(child: _buildImageTile(context, 1, height: 200)),
      ],
    );
  }

  Widget _buildThreeImages(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _buildImageTile(context, 0, height: 250),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            children: [
              _buildImageTile(context, 1, height: 123),
              const SizedBox(height: 4),
              _buildImageTile(context, 2, height: 123),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFourImages(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildImageTile(context, 0, height: 150)),
            const SizedBox(width: 4),
            Expanded(child: _buildImageTile(context, 1, height: 150)),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(child: _buildImageTile(context, 2, height: 150)),
            const SizedBox(width: 4),
            Expanded(child: _buildImageTile(context, 3, height: 150)),
          ],
        ),
      ],
    );
  }

  Widget _buildFiveImages(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildImageTile(context, 0, height: 150)),
            const SizedBox(width: 4),
            Expanded(child: _buildImageTile(context, 1, height: 150)),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(child: _buildImageTile(context, 2, height: 100)),
            const SizedBox(width: 4),
            Expanded(child: _buildImageTile(context, 3, height: 100)),
            const SizedBox(width: 4),
            Expanded(
              child: Stack(
                children: [
                  _buildImageTile(context, 4, height: 100),
                  if (imageUrls.length > 5)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '+${imageUrls.length - 5}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageTile(BuildContext context, int index, {required double height}) {
    return GestureDetector(
      onTap: () => _openImageViewer(context, index),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imageUrls[index],
          height: height,
          width: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              height: height,
              color: Colors.grey.shade200,
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: height,
              color: Colors.grey.shade200,
              child: const Center(
                child: Icon(Icons.broken_image, size: 32, color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openImageViewer(BuildContext context, int initialIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageViewerScreen(
          imageUrls: imageUrls,
          initialIndex: initialIndex,
        ),
      ),
    );
  }
}

/// Full-screen image viewer with swipe support
class ImageViewerScreen extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const ImageViewerScreen({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
  });

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('${_currentIndex + 1} / ${widget.imageUrls.length}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () async {
              final currentUrl = widget.imageUrls[_currentIndex];
              await _downloadImage(context, currentUrl);
            },
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.imageUrls.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return InteractiveViewer(
            child: Center(
              child: Image.network(
                widget.imageUrls[index],
                fit: BoxFit.contain,
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
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.broken_image, size: 64, color: Colors.white54),
                        SizedBox(height: 16),
                        Text(
                          'Failed to load image',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _downloadImage(BuildContext context, String imageUrl) async {
    try {
      // Open URL in browser to download
      final uri = Uri.parse(imageUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم فتح الصورة في المتصفح للتحميل'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('لا يمكن فتح الرابط')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: $e')),
        );
      }
    }
  }
}
