import 'package:get/get.dart';

import 'use_cases_bindings.dart';
import 'remote_source_bindings.dart';
import 'repository_bindings.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    RemoteSourceBindings().dependencies();
    RepositoryBindings().dependencies();
    UseCasesBindings().dependencies();
  }
}
