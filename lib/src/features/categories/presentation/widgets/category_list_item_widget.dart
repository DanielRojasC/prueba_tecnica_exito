import 'package:flutter/material.dart';
import 'package:prueba_tecnica_exito/src/core/constants/assets_path_constants.dart';
import 'package:prueba_tecnica_exito/src/core/utils/utils.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/entities/category_entity.dart';

class CategoryListItemWidget extends StatelessWidget {
  final CategoryEntity category;
  final VoidCallback onClickItem;
  const CategoryListItemWidget({
    super.key,
    required this.category,
    required this.onClickItem,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onClickItem,
    child: Card(
      elevation: 5,
      child: Container(
        width: 160,
        height: 200,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ImageWidget(category: category),
            _NameWidget(category: category),
          ],
        ),
      ),
    ),
  );
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    required this.category,
  });

  final CategoryEntity category;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: FadeInImage.assetNetwork(
        placeholder: AssetsPathConstants.loadingGif,
        image: category.image,
      ),
    ),
  );
}

class _NameWidget extends StatelessWidget {
  const _NameWidget({
    required this.category,
  });

  final CategoryEntity category;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8),
    child: Text(
      category.name.capitalize(),

      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
