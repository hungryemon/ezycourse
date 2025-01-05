// ignore: depend_on_referenced_packages
import 'package:logger/logger.dart';

class EnvConfig {
  final String appName;
  final String baseUrlPrimary;
  final String baseUrlSecondary;
  final bool shouldCollectLog;

  late final Logger logger;

  EnvConfig({
    required this.appName,
    required this.baseUrlPrimary,
    required this.baseUrlSecondary,
    this.shouldCollectLog = false,
  }) {
    logger = Logger(
      printer: PrettyPrinter(
          methodCount: 2,
          // number of method calls to be displayed
          errorMethodCount: 8,
          // number of method calls if stacktrace is provided
          lineLength: 120,
          // width of the output
          colors: true,
          // Colorful log messages
          printEmojis: true,
          // Print an emoji for each log message
          // ignore: deprecated_member_use
          printTime: false // Should each log print contain a timestamp
          ),
    );
  }
}