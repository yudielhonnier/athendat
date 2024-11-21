import 'package:athendat/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';

typedef XFileMonad = Either<Failure, XFile>;
typedef ListXFileMonad = Either<Failure, List<XFile?>>;
