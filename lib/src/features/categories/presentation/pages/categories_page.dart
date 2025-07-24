import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tecnica_exito/src/core/constants/styles.dart';
import 'package:prueba_tecnica_exito/src/core/utils/utils.dart';
import 'package:prueba_tecnica_exito/src/features/categories/domain/entities/category_entity.dart';
import 'package:prueba_tecnica_exito/src/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:prueba_tecnica_exito/src/features/categories/presentation/widgets/category_list_item_widget.dart';
import 'package:prueba_tecnica_exito/src/shared/custom_appbar_widget.dart';
import 'package:prueba_tecnica_exito/src/shared/deliver_mode_banner_widget.dart';
import 'package:prueba_tecnica_exito/src/shared/inputs/search_input_widget.dart';
import 'package:prueba_tecnica_exito/src/shared/loading_widget.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<CategoryEntity> _categories = [];
  List<CategoryEntity> _originalCategoriesList = [];

  final _searchInputController = TextEditingController();

  bool _expressExperience = false;

  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _searchInputController.addListener(_searchInputListener);
    _loadInitialCategories();
  }

  void _loadInitialCategories() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoriesBloc>().add(GetCategoriesEvent());
    });
  }

  void _searchInputListener() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 100), () {
      if (_searchInputController.text.isEmpty) {
        _resetCategories();
      } else {
        _filterCategories(_searchInputController.text.toLowerCase());
      }
    });
  }

  void _resetCategories() {
    setState(() => _categories = List.from(_originalCategoriesList));
  }

  void _filterCategories(String query) {
    setState(() {
      _categories = _originalCategoriesList
          .where((category) => category.name.toLowerCase().contains(query))
          .toList();
    });
  }

  void _handleStateChange(BuildContext context, CategoriesState state) {
    if (state is CategoryErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.exception.message)),
      );
    }
    if (state is CategoriesLoadedState) {
      _updateCategories(state.categories);
    }
  }

  void _updateCategories(List<CategoryEntity> categories) => setState(() {
    _originalCategoriesList = categories;
    _categories = List.from(categories);
  });

  void _onToggleSwitch() =>
      setState(() => _expressExperience = !_expressExperience);

  _buildContent(CategoriesState state) {
    if (state is CategoriesLoadingState) {
      return const LoadingWidget();
    }
    if (state is CategoriesLoadedState) {
      _categories = state.categories;
      _originalCategoriesList = state.categories;
      context.read<CategoriesBloc>().add(CategoriesInitialEvent());

      return _buildLoadedContent();
    }

    return _buildDefaultContent();
  }

  _buildLoadedContent() => const SizedBox();

  _buildDefaultContent() => _categories.isEmpty
      ? const Center(child: Text("No hay categorias"))
      : _CategoriesPageContentWidget(
          categories: _categories,
          onClickItem: (category) => context.pushNamed(
            "category",
            extra: {
              "category": category,
              "canEnableExpressExperience": _expressExperience,
            },
          ),
          onToggleSwitch: _onToggleSwitch,
          expressExperience: _expressExperience,
        );

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchInputController.removeListener(_searchInputListener);
    _searchInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: backgroundColor,
    appBar: MainAppbarWidget(
      centerWidget: SearchInputWidget(
        controller: _searchInputController,
        hint: "Busca en tu app",
      ),
      showBackButton: false,
      actions: const Icon(Icons.person_outline_outlined, size: 35),
    ),
    body: SafeArea(
      child: BlocConsumer<CategoriesBloc, CategoriesState>(
        listener: _handleStateChange,
        builder: (context, state) => _buildContent(state),
      ),
    ),
  );
}

class _CategoriesPageContentWidget extends StatelessWidget {
  final List<CategoryEntity> categories;
  final Function(CategoryEntity) onClickItem;
  final VoidCallback onToggleSwitch;
  final bool expressExperience;

  const _CategoriesPageContentWidget({
    required this.categories,
    required this.onClickItem,
    required this.onToggleSwitch,
    required this.expressExperience,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const DeliveryModeBannerWidget(
        text: "¿Cómo quieres recibir tu pedido?",
      ),

      Expanded(
        child: _CategoriesListWidget(
          categories: categories,
          onClickItem: (category) => onClickItem(category),
          onToggleSwitch: onToggleSwitch,
          expressExperience: expressExperience,
        ),
      ),
    ],
  );
}

class _CategoriesListWidget extends StatelessWidget {
  final List<CategoryEntity> categories;
  final Function(CategoryEntity) onClickItem;
  final VoidCallback onToggleSwitch;
  final bool expressExperience;
  const _CategoriesListWidget({
    required this.categories,
    required this.onClickItem,
    required this.onToggleSwitch,
    required this.expressExperience,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    child: CustomScrollView(
      slivers: [
        _CategoriesListHeaderWidget(
          onToggleSwitch: onToggleSwitch,
          expressExperience: expressExperience,
        ),
        _CategoriesListContentWidget(
          categories: categories,
          onClickItem: (category) => onClickItem(category),
        ),
      ],
    ),
  );
}

class _CategoriesListHeaderWidget extends StatelessWidget {
  final VoidCallback onToggleSwitch;
  final bool expressExperience;
  const _CategoriesListHeaderWidget({
    required this.onToggleSwitch,
    required this.expressExperience,
  });

  _buildExpressExperience() => canEnableExpressExperience()
      ? Row(
          children: [
            const Text(
              "Activar la experiencia express: ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Switch.adaptive(
              value: expressExperience,
              onChanged: (value) => onToggleSwitch(),
            ),
          ],
        )
      : const SizedBox();

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.only(left: 2, right: 2, top: 13, bottom: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Grilla cuadrada",
                style: TextStyle(fontSize: 25),
              ),
              Text(
                "Ver Todos",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          _buildExpressExperience(),
        ],
      ),
    ),
  );
}

class _CategoriesListContentWidget extends StatelessWidget {
  const _CategoriesListContentWidget({
    required this.categories,
    required this.onClickItem,
  });

  final List<CategoryEntity> categories;
  final Function(CategoryEntity) onClickItem;

  @override
  Widget build(BuildContext context) => SliverGrid(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 169 / 160,
    ),
    delegate: SliverChildBuilderDelegate(
      (context, index) => CategoryListItemWidget(
        category: categories[index],
        onClickItem: () => onClickItem(categories[index]),
      ),
      childCount: categories.length,
    ),
  );
}
