import 'package:flutter/material.dart';

class ProfilePhotoGallery extends StatelessWidget {
  const ProfilePhotoGallery({
    super.key,
    this.photoAssets = const [],
    this.photoUrls = const [],
  });

  final List<String> photoAssets;
  final List<String> photoUrls;

  static const List<Alignment> _cropAlignments = [
    Alignment(-0.15, -0.35),
    Alignment.center,
    Alignment(0.2, 0.25),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        final asset =
            index < photoAssets.length ? photoAssets[index] : null;
        final url = index < photoUrls.length ? photoUrls[index] : null;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : 5,
              right: index == 2 ? 0 : 5,
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: _GalleryImage(
                  asset: asset,
                  url: url,
                  index: index,
                  alignment: _cropAlignments[index],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _GalleryImage extends StatelessWidget {
  const _GalleryImage({
    required this.index,
    required this.alignment,
    this.asset,
    this.url,
  });

  final String? asset;
  final String? url;
  final int index;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    if (asset != null && asset!.isNotEmpty) {
      return Image.asset(
        asset!,
        fit: BoxFit.cover,
        alignment: alignment,
        errorBuilder: (context, error, stackTrace) =>
            _GalleryPlaceholder(index: index),
      );
    }
    if (url != null && url!.isNotEmpty) {
      return Image.network(
        url!,
        fit: BoxFit.cover,
        alignment: alignment,
        errorBuilder: (context, error, stackTrace) =>
            _GalleryPlaceholder(index: index),
      );
    }
    return _GalleryPlaceholder(index: index);
  }
}

class _GalleryPlaceholder extends StatelessWidget {
  const _GalleryPlaceholder({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = [
      const Color(0xFF374151),
      const Color(0xFF1F2937),
      const Color(0xFF4B5563),
    ];
    return Container(
      color: colors[index % colors.length],
      child: const Icon(
        Icons.photo_rounded,
        color: Color(0xFF9CA3AF),
        size: 28,
      ),
    );
  }
}
