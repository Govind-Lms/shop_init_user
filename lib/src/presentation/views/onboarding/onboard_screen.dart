import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  PageController controller = PageController();
  var currentIndex = 0;

  void onPageChanged(index){
    currentIndex = index;
  }
  void onDotClicked(index){
    currentIndex = index;
    controller.jumpToPage(index);
    controller.jumpTo(index);
  }

  void nextPage()async{
    
    if(currentIndex ==2 ){
      if(firebaseAuth.currentUser!= null ){
        

        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("isFirstTime", false);
        if(!mounted)return;
        Navigator.of(context).pushReplacementNamed('/');
       }
      else{
        Navigator.of(context).pushReplacementNamed('/signIn');
      }
    }
    else {
      int page = currentIndex+1;
      controller.jumpToPage(page);     
    }
  }
  
  void skipPage(){
    currentIndex = 2;
    controller.jumpToPage(2);
  }
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          
          PageView(
            controller: controller,
            onPageChanged: onPageChanged,
            
            children: List.generate(
            onBoardingImages.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Image(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * .6,
                      image: AssetImage(onBoardingImages[index]),
                    ),
                    Text(
                      onBoardingTitles[index],
                      style: GoogleFonts.poppins().copyWith(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(20.0),
                    Text(
                      onBoardingSubtitles[index],
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          )),

          Positioned(
            top: kToolbarHeight,
            right: 0,
            child: TextButton(
              onPressed: skipPage,
              child: Text('skip',style:  GoogleFonts.poppins().copyWith(color: Colors.black),),
            ),
          ),
          Positioned(
            bottom: kBottomNavigationBarHeight+20,
            left: 20.0,
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              onDotClicked: onDotClicked,
              axisDirection: Axis.horizontal,
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.black,
                dotColor: Colors.grey,
                dotHeight: 6,
                dotWidth: 20
              )
            ),
          ),

          Positioned(
            bottom: kBottomNavigationBarHeight,
            right: 20.0,
            child: InkWell(
              onTap: nextPage,
              child: Container(
                width: kToolbarHeight,
                height: kToolbarHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black,
                ),
                child:const Center(child: Icon(Icons.arrow_forward_ios,color: Colors.white,),),
              ),
            )
            
          ),



        ],
      ),
    );
  }
}
