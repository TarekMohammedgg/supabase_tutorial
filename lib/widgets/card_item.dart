import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.image,
    required this.title,
    required this.hasPrice,
    this.icon,
    required this.onCartPressed,
    this.price,
  });

  final Icon? icon;
  final String image, title;
  final bool hasPrice;
  final num? price;
  final VoidCallback onCartPressed;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(child: Image.asset(image, fit: BoxFit.contain)),
          const SizedBox(height: 16),
          Text(title),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              hasPrice
                  ? Text(
                      r"$"
                      "$price!",
                    )
                  : const SizedBox.shrink(),
              hasPrice
                  ? IconButton(
                      onPressed: onCartPressed,
                      icon: icon ?? Icon(Icons.line_style),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
