import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_init/src/core/helper/authentication.dart';

part 'google_sign_in_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  GoogleSignInCubit() : super(AuthInitial());

  AuthRepo authRepo  = AuthRepo();
  
  Future<void> login() async{
    try{
      emit(AuthLoading());
      final user = await authRepo.signInWithGoogle();
      emit(AuthSuccess(user.user!));
    }catch (e){
      print(e);
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logOut() async{
    try{
      emit(AuthLoading());
      final isTrue = await authRepo.signOutFromGoogle();
      emit(AuthLogOut("LogOut$isTrue"));
    }catch (e){
      emit(AuthFailure(e.toString()));
    }
  }
}
