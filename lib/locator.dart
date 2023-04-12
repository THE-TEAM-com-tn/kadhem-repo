import 'package:elearning_provider/UI/Pages/EditProfilePage/EditProfilePage.dart';
import 'package:elearning_provider/providers/EditProfileProvider.dart';
import 'package:elearning_provider/providers/PasswordChangeProvider.dart';
import 'package:elearning_provider/providers/category_crud_model.dart';
import 'package:elearning_provider/providers/tag_crud_model.dart';
import 'package:elearning_provider/providers/training_crud_model.dart';
import 'package:elearning_provider/services/ChangePasswordService.dart';
import 'package:elearning_provider/services/EditProfileService.dart';
import 'package:elearning_provider/services/category_api.dart';
import 'package:elearning_provider/services/tag_api.dart';
import 'package:elearning_provider/services/training_api.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => EditProfileProvider());
  locator.registerLazySingleton(() => EditProfileService());

  locator.registerLazySingleton(() => ChangePasswordService());
  locator.registerLazySingleton(() => PasswordChangeProvider());

  locator.registerLazySingleton(() => TrainingAPI('trainings'));
  locator.registerLazySingleton(() => TrainingCRUDModel());

  locator.registerLazySingleton(() => CategoryAPI('categories'));
  locator.registerLazySingleton(() => CategoryCRUDModel());

  locator.registerLazySingleton(() => TagAPI('tags'));
  locator.registerLazySingleton(() => TagCRUDModel());
}
