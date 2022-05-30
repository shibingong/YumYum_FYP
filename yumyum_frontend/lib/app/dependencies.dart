import 'package:get_it/get_it.dart';
import 'package:yumyumfyp/screens/add_recipe/add_recipe_viewmodel.dart';
import 'package:yumyumfyp/screens/add_recipe_feedback/add_recipe_feedback_viewmodel.dart';
import 'package:yumyumfyp/screens/home/home_viewmodel.dart';
import 'package:yumyumfyp/screens/main/main_viewmodel.dart';
import 'package:yumyumfyp/screens/my_profile/my_profile_viewmodel.dart';
import 'package:yumyumfyp/screens/my_recipe/my_recipe_viewmodel.dart';
import 'package:yumyumfyp/screens/recipe_details/recipe_details_viewmodel.dart';
import 'package:yumyumfyp/screens/registration/registration_viewmodel.dart';
import 'package:yumyumfyp/screens/search_recipe/search_recipe_viewmodel.dart';
import 'package:yumyumfyp/screens/view_recipe_feedback/view_recipe_feedback_viewmodel.dart';
import 'package:yumyumfyp/services/feedback/feedback_service.dart';
import 'package:yumyumfyp/services/feedback/feedback_service_rest.dart';
import 'package:yumyumfyp/services/login/login_service.dart';
import 'package:yumyumfyp/services/login/login_service_rest.dart';
import 'package:yumyumfyp/services/nutrition/nutrition_service.dart';
import 'package:yumyumfyp/services/nutrition/nutrition_service_rest.dart';
import 'package:yumyumfyp/services/recipe/recipe_service.dart';
import 'package:yumyumfyp/services/recipe/recipe_service_rest.dart';
import 'package:yumyumfyp/services/registration/registration_service.dart';
import 'package:yumyumfyp/services/registration/registration_service_rest.dart';
import 'package:yumyumfyp/services/user/user_service.dart';
import 'package:yumyumfyp/services/user/user_service_rest.dart';
import 'auth.dart';
import 'package:yumyumfyp/screens/login/login_viewmodel.dart';

import '../services/rest.dart';

GetIt dependency = GetIt.instance;

void init() {
  // Services
  dependency.registerLazySingleton<RestService>(
    () => RestService(baseUrl: 'http://10.216.97.20:3000'),
  );
  dependency.registerLazySingleton<AuthService>(() => AuthService());
  dependency.registerLazySingleton<LoginService>(() => LoginServiceRest());
  dependency.registerLazySingleton<RegistrationService>(
      () => RegistrationServiceRest());
  dependency.registerLazySingleton<UserService>(() => UserServiceRest());
  dependency
      .registerLazySingleton<NutritionService>(() => NutritionServiceRest());
  dependency.registerLazySingleton<RecipeService>(() => RecipeServiceRest());
  dependency
      .registerLazySingleton<FeedbackService>(() => FeedbackServiceRest());

  // Viewmodels
  dependency.registerLazySingleton(() => LoginViewModel());
  dependency.registerLazySingleton(() => RegistrationViewModel());
  dependency.registerLazySingleton(() => MainViewModel());
  dependency.registerLazySingleton(() => HomeViewModel());
  dependency.registerLazySingleton(() => MyRecipeViewModel());
  dependency.registerLazySingleton(() => AddRecipeViewModel());
  dependency.registerLazySingleton(() => MyProfileViewModel());
  dependency.registerLazySingleton(() => RecipeDetailsViewModel());
  dependency.registerLazySingleton(() => SearchRecipeViewModel());
  dependency.registerLazySingleton(() => ViewRecipeFeedbackViewModel());
  dependency.registerLazySingleton(() => AddRecipeFeedbackViewModel());
}
