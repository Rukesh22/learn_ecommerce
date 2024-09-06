import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:learn_ecommerce/common/widgets/home_widgets/success_screen.dart';
import 'package:learn_ecommerce/data/repositories/autentication_repository.dart';
import 'package:learn_ecommerce/utils/constants/image_strings.dart';
import 'package:learn_ecommerce/utils/constants/text_strings.dart';
import 'package:learn_ecommerce/utils/helpers/t_loader.dart';


class VerifyEmailController extends GetxController {

static VerifyEmailController get instance => Get.find();

/// Send Email Bhenever Verify Screen appears & Set Timer for auto redirect.

@override
void onInit() {
  sendEmailVerification();
  setTimerForAutoRedirect();
   super.onInit();

}

/// Send Enail Verification Link
sendEmailVerification()
async {
  try
  {
    await AutenticationRepository.instance.sendEmailVerification();
    TLoaders.successSnabar(title: 'email sent',message: 'please che');
    
  }catch(e)
  {
    TLoaders.errorSnackBar(title: '');
  }
}

/// Timer to automatically redirect on Email Verification
   setTimerForAutoRedirect(){
    Timer.periodic(
      const Duration(seconds:1),
      (timer) async {
        final user=FirebaseAuth.instance.currentUser;
        await FirebaseAuth.instance.currentUser?.reload();
        if(user?.emailVerified ?? false){
          timer.cancel();
          Get.off(() => SuccessScreen(
            image: TImages.appleLogo,
             title: TTexts.yourAccountCreatedTitle,
              subTitle: TTexts.yourAccountCreatedSubTitle,
               onPressed: () => AutenticationRepository.instance.screenRedirect()
               )
               );
        
        }
      },
    );
   }
   


/// Manualty Check if Emoit Verified
checkEmailVerificstionStatus() async{
  final currentUser=FirebaseAuth.instance.currentUser;
  if(currentUser!=null && currentUser.emailVerified){
    Get.off(()=>SuccessScreen(image: TImages.appleLogo, 
    title: TTexts.yourAccountCreatedTitle,
     subTitle: TTexts.yourAccountCreatedSubTitle,
      onPressed: () => AutenticationRepository.instance.screenRedirect()
    ),
    );
    }
  }  

}
 