import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mindpeace/Helper/constant.dart';
import 'package:mindpeace/IAPScreens/in_app_purchase_screen.dart';
import 'package:mindpeace/Screens/navbar_screen.dart';
import 'package:mindpeace/Widget/custom_alert.dart';
import 'package:purchases_flutter/object_wrappers.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseButton extends StatefulWidget {
  final Package package;
  final Color backgroundColour;
  final String tag;
  final Color textColour;

  const PurchaseButton({Key key, this.package, this.backgroundColour, this.tag, this.textColour}) : super(key: key);

  @override
  _PurchaseButtonState createState() => _PurchaseButtonState();
}

class _PurchaseButtonState extends State<PurchaseButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        child: Container(
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: widget.backgroundColour ?? meditationCardColour
          ),

          child: Stack(
            children: [
              widget.tag != "" ?Positioned(
                right: 5,
                height: 20,
                top: 5,
                child: Container(
                  width: 75,
                  child: Center(child:
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(widget.tag, style: TextStyle(color: Colors.white, fontSize: 10),),
                  )),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.deepPurple
                  ),
                ),
              ): Container(),
              Positioned(
                top: 10,
                left: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(widget.package.product.priceString, style: kSubTitleTextStyle.copyWith(fontSize: 16,color: widget.textColour, fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Text(widget.package.product.title, style: kDescTextStyle.copyWith(color: widget.textColour, fontWeight: FontWeight.w500),),

                ],
            ),
              ),
            ]
          ),
        ),
        onTap: () async {
          try {
            print('trying to purchase');
            var _purchaseInfo = await Purchases.purchasePackage(widget.package);
            print('purchase complete');

            appData.isPro =
                _purchaseInfo.entitlements.all['all_features'].isActive;
            print('is user pro? ${appData.isPro}');

            if (appData.isPro) {
              //TODO: Show alert box confirming purchase
              showDialog(context: context, builder: (BuildContext context){
                return CustomAlert(
                  title: 'Congratulation',
                  descriptions: 'Your purchase has been successful, you now have access to entire app',
                  buttonPressed: (){
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => NavbarScreen()), (route) => false);

                  },
                );
              });
            } else {
              showDialog(context: context, builder: (BuildContext context){
                return CustomAlert(
                  title: 'Error',
                  descriptions: 'Failed to do purchase, try again later',
                  buttonPressed: (){
                    Navigator.pop(context);
                  },
                );
              });
            }
          } on PlatformException catch(e){
            print('---- X ---');
            var errorCode = PurchasesErrorHelper.getErrorCode(e);
            if(errorCode == PurchasesErrorCode.purchaseCancelledError){

            }else if(errorCode == PurchasesErrorCode.purchaseNotAllowedError){
              print('Purchase not allowed');
              showDialog(context: context, builder: (BuildContext context){
                return CustomAlert(
                  title: 'Error',
                  descriptions: 'Purchase not allowed. Try again later.',
                  buttonPressed: (){
                    Navigator.pop(context);
                  },
                );
              });
            }else if(errorCode == PurchasesErrorCode.productAlreadyPurchasedError){
              print('Product already purchased');
              showDialog(context: context, builder: (BuildContext context){
                return CustomAlert(
                  title: 'Already a Pro Member',
                  descriptions: 'You are already a Pro Member.',
                  buttonPressed: (){
                    Navigator.pop(context);
                  },
                );
              });
            }

            // return InAppPurchaseScreen();
          }
        },
      ),
    );
  }
}
