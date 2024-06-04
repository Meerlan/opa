import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/info_card_model.dart';

class PlanCard extends StatelessWidget {
  final InfoCardModel item;
  final Function()? onTap;
  const PlanCard({
    Key? key,
    required this.item,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
                blurRadius: 20, color: AppConfig.blackColor.withOpacity(0.005))
          ],
        ),
        child: Stack(alignment: Alignment.center, children: [
          Image.asset(
            item.image,
            fit: BoxFit.fill,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'до ${item.square} м2',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w500,
                  color: AppConfig.whiteColor,
                ),
              ),
              Text(
                '${item.price} ${item.currency}',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: AppConfig.whiteColor,
                ),
              ),
              const SizedBox(height: 29),
              Text(
                '${item.previousPrice} ${item.currency}',
                style: TextStyle(
                  fontSize: 24,
                  decoration: TextDecoration.lineThrough,
                  fontWeight: FontWeight.w500,
                  color: AppConfig.whiteColor.withOpacity(0.4),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
