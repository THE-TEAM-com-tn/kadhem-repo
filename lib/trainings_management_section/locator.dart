import 'package:get_it/get_it.dart';
import 'package:team_elearny/trainings_management_section/core/services/category_api.dart';
import 'package:team_elearny/trainings_management_section/core/services/tag_api.dart';
import 'package:team_elearny/trainings_management_section/core/viewmodels/category_crud_model.dart';
import 'package:team_elearny/trainings_management_section/core/viewmodels/tag_crud_model.dart';

import 'core/services/training_api.dart';
import 'core/viewmodels/training_crud_model.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => TrainingAPI('trainings'));
  locator.registerLazySingleton(() => TrainingCRUDModel());

  locator.registerLazySingleton(() => CategoryAPI('tags'));
  locator.registerLazySingleton(() => CategoryCRUDModel());

  locator.registerLazySingleton(() => TagAPI('categories'));
  locator.registerLazySingleton(() => TagCRUDModel());
}
