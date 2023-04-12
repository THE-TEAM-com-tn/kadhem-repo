import 'package:elearning_provider/UI/Pages/EditProfilePage/EditProfilePage.dart';
import 'package:elearning_provider/providers/EditProfileProvider.dart';
import 'package:elearning_provider/providers/PasswordChangeProvider.dart';
import 'package:elearning_provider/services/ChangePasswordService.dart';
import 'package:elearning_provider/services/EditProfileService.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => EditProfileProvider());
  locator.registerLazySingleton(() => EditProfileService());

    locator.registerLazySingleton(() => ChangePasswordService());
  locator.registerLazySingleton(() => PasswordChangeProvider());


  
  }