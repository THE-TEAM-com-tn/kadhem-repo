import 'package:get_it/get_it.dart';

import 'core/services/training_api.dart';
import 'core/viewmodels/training_crud_model.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => TrainingAPI('training'));
  locator.registerLazySingleton(() => TrainingCRUDModel());
}
