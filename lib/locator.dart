import 'package:get_it/get_it.dart';
import 'package:provider_trainings/core/services/category_api.dart';
import 'package:provider_trainings/core/services/tag_api.dart';
import 'package:provider_trainings/core/viewmodels/category_crud_model.dart';
import 'package:provider_trainings/core/viewmodels/tag_crud_model.dart';

import 'core/services/training_api.dart';
import 'core/viewmodels/training_crud_model.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => TrainingAPI('training'));
  locator.registerLazySingleton(() => TrainingCRUDModel());

  locator.registerLazySingleton(() => CategoryAPI('category'));
  locator.registerLazySingleton(() => CategoryCRUDModel());

  locator.registerLazySingleton(() => TagAPI('tag'));
  locator.registerLazySingleton(() => TagCRUDModel());
}
