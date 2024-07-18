import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/presentation/views/products/components/categorized_product_screen.dart';
import 'package:shop_init/src/presentation/views/bottom_nav/components/category_widget.dart';
import 'package:shop_init/src/presentation/widgets/custom_appbar.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: CustomAppBar(
              isAnimated: true,
              showDefinedName: false,
              name: '',
              showCart: true,
              showSearchBar: false,
            ),
          ),
          SliverToBoxAdapter(
            child: FadeInDown(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Categories',
                  style: GoogleFonts.poppins().copyWith(
                      color: theme.primaryColorDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ),
          SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4 / 5,
            ),
            itemCount: categoryNames.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  switch (categoryNames[index]) {
                    case 'tee':
                      categoryName = 'tee';
                    case 'outerwear':
                      categoryName = 'outerwear';
                    case 'sneaker':
                      categoryName = 'sneaker';
                    case 'hoodie':
                      categoryName = 'hoodie';
                  }

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CategorizedProductScreen(),
                    ),
                  );
                },
                child: FadeInDown(
                  child: CategoryWidget(
                    color: colors[index],
                    image: images[index],
                    name: categoryNames[index],
                    angle: angles[index],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
