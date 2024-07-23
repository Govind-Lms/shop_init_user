import 'package:flutter/material.dart';
import 'package:shop_init/src/const/constant.dart';
import 'package:shop_init/src/const/vice_theme.dart';
import 'package:shop_init/src/core/models/noti_model.dart';
import 'package:shop_init/src/presentation/widgets/custom_appbar.dart';
import 'package:shop_init/src/presentation/widgets/empty.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
                isAnimated: false,
                showSearchBar: false,
                showDefinedName: true,
                showCart: false,
                name: 'Notifications',
                showBack: true,
            ),
            Expanded(
              child: StreamBuilder(
                stream: orderRef.doc(firebaseAuth.currentUser!.uid).collection("noti").snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator());
                  }
                  else if(snapshot.hasError){
                    return Text("ERROR");
                  }
                  else{
                    if(snapshot.data!.docs.isEmpty){
                      return EmptyPage(title: "No Notifications!",);
                    }
                    else{
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final data  = NotificaitonModel.fromJson(snapshot.data!.docs[index].data());
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: data.approveOrReject==true ?Colors.green : Colors.red,
                              child: Text("${index+1}".toString(),style: AppStyle.titleStyle.copyWith(color: Theme.of(context).primaryColorLight),),
                            ),
                            title: Text("${data.title}",style: AppStyle.titleStyle,),
                            subtitle: Text(data.details!,style: AppStyle.descStyle,),
                          );
                        },
                      );
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}