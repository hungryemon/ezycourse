import 'package:get/get.dart';

import '../../../../app/base/base_remote_source.dart';
import '../../data/datasources/feeds_remote_data_source.dart';

abstract class FeedsRepository {
}

class FeedsRepositoryImpl extends BaseRemoteSource implements FeedsRepository {
  final FeedsRemoteDataSource _remoteSource =
      Get.find(tag: (FeedsRemoteDataSource).toString());

  
 
}
