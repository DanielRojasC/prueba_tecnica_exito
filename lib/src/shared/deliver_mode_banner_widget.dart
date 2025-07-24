import 'package:flutter/material.dart';
import 'package:prueba_tecnica_exito/src/core/constants/styles.dart';

class DeliveryModeBannerWidget extends StatelessWidget {
  final String text;
  const DeliveryModeBannerWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Container(
    color: secondaryColor,
    height: 50,
    width: deviceWidth(context),
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: _DeliverModeBannerContent(text: text),
  );
}

class _DeliverModeBannerContent extends StatelessWidget {
  final String text;
  const _DeliverModeBannerContent({required this.text});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Icon(Icons.location_on, color: primaryColor),
      const SizedBox(width: 15),
      Flexible(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(left: 15),
        child: Icon(Icons.edit, color: primaryColor, size: 20,),
      ),
    ],
  );
}
