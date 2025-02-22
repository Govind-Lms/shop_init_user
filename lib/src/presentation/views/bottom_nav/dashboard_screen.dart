import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/core/models/item_model.dart';
import 'package:shop_init/src/presentation/views/products/product_details.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final controller = PageController();
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Center(
              child: StreamBuilder(
                stream: bannerRef.snapshots(),
                builder: (context,snapshot) {
                  if(!snapshot.hasData){
                    return  Container();
                  }
                  else if (snapshot.hasError){
                    return  Container();
                  }
                  else{
                    return Stack(
                      children: [
                        Center(
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20.0,
                              ),
                              const Spacer(),
                              SmoothPageIndicator(
                                controller: controller,
                                count: snapshot.data!.docs.length,
                                axisDirection: Axis.vertical,
                                
                                effect: const ExpandingDotsEffect(
                                  activeDotColor: Colors.black,
                                  dotColor: Colors.grey,
                                  dotHeight: 5,
                                  dotWidth: 30,
                                )
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10.0),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 1.5,
                            // color: Colors.yellow,
                            child: PageView(
                              scrollDirection: Axis.vertical,
                              controller: controller,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              physics: const BouncingScrollPhysics(),
                              children: List.generate(
                                snapshot.data!.docs.length,
                                (index) {
                                  final productModel = ItemModel.fromJson(snapshot.data!.docs[index].data());
                                  return GestureDetector(
                                    onTap: (){
                                      nav(context, ProductDetailsScreen(productModel: productModel));
                                    },
                                    child: FadeInUp(
                                      child: CachedNetworkImage(
                                        imageUrl: productModel.imageUrl ?? '',
                                        width: MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                        height: MediaQuery.of(context).size.height / 1.5,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: -20,
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  'NEW\nCOLLECTION',
                  style: GoogleFonts.playfairDisplay().copyWith(
                    fontSize: 50.0,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10.0,
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  'SHOPINIT',
                  style: GoogleFonts.bebasNeue().copyWith(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}