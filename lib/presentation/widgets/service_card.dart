import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/router/app_router.dart';
import 'package:flutter_delivery_app/domain/entities/service/service.dart';
import 'package:shimmer/shimmer.dart';

class ServiceCard extends StatelessWidget {
  final Service? service;
  final Function? onClick;

  const ServiceCard({super.key, this.service, this.onClick});

  static const double imageHeight = 140;

  @override
  Widget build(BuildContext context) {
    return service == null
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade100,
            highlightColor: Colors.white,
            child: buildBody(context),
          )
        : buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (service != null) {
          Navigator.of(
            context,
          ).pushNamed(AppRouter.serviceDetails, arguments: service);
        }
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Fixed Height Image Container
            SizedBox(
              height: imageHeight,
              width: double.infinity,
              child: service == null
                  ? Material(
                      child: GridTile(
                        footer: Container(),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Container(color: Colors.grey.shade300),
                        ),
                      ),
                    )
                  : Hero(
                      tag: service!.id,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: service!.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey.shade100,
                            highlightColor: Colors.white,
                            child: Container(color: Colors.grey.shade300),
                          ),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 8),
            // ✅ Service Name
            SizedBox(
              height: 20,
              child: service == null
                  ? Container(
                      width: 120,
                      height: 18,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    )
                  : Text(
                      service!.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
            ),
            const SizedBox(height: 4),
            // ✅ Service SubName
            SizedBox(
              height: 18,
              child: service == null
                  ? Container(
                      width: 100,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    )
                  : Text(
                      service!.subName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, color: Colors.brown),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
