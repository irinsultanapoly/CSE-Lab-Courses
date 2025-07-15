import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import '../core/logger/app_logger.dart';

class PlantClassifierService {
  static const String modelPath =
      'assets/models/DenseNet121_full_model_v3.0.tflite';
  static const int inputSize = 224;
  static const int numChannels = 3;
  static const int numClasses = 38;
  Interpreter? _interpreter;

  Future<void> loadModel() async {
    AppLogger.i('Attempting to load TFLite model from: $modelPath');
    try {
      _interpreter ??= await Interpreter.fromAsset(modelPath);
      AppLogger.i('TFLite model loaded successfully: $modelPath');
      if (_interpreter == null) {
        AppLogger.e('Interpreter is null after loading!');
      } else {
        AppLogger.i(
          'Interpreter input tensors: ' +
              _interpreter!.getInputTensors().toString(),
        );
        AppLogger.i(
          'Interpreter output tensors: ' +
              _interpreter!.getOutputTensors().toString(),
        );
      }
    } catch (e, stack) {
      AppLogger.e('Failed to load TFLite model: $e');
      AppLogger.e('Stacktrace: $stack');
      rethrow;
    }
  }

  Future<List<double>> predict(File imageFile) async {
    AppLogger.i('Starting prediction for file: ' + imageFile.path);
    await loadModel();
    try {
      // Load and preprocess image
      final img.Image? oriImage = img.decodeImage(
        await imageFile.readAsBytes(),
      );
      if (oriImage == null) {
        AppLogger.e('Cannot decode image: ' + imageFile.path);
        throw Exception('Cannot decode image');
      }
      AppLogger.i(
        'Image decoded. Size: \\${oriImage.width}x\\${oriImage.height}',
      );
      final img.Image resized = img.copyResize(
        oriImage,
        width: inputSize,
        height: inputSize,
      );
      AppLogger.i('Image resized to: $inputSize x $inputSize');
      final input = List.generate(
        inputSize,
        (y) => List.generate(
          inputSize,
          (x) => List.generate(numChannels, (c) {
            final pixel = resized.getPixel(x, y);
            final rgb = [pixel.r, pixel.g, pixel.b];
            // Normalize to [-1, 1]
            return (rgb[c] / 127.5) - 1.0;
          }),
        ),
      );
      AppLogger.i(
        'Input tensor shape: [1, $inputSize, $inputSize, $numChannels]',
      );
      // Model expects shape [1, 224, 224, 3]
      final inputTensor = [input];
      final output = List.filled(numClasses, 0.0).reshape([1, numClasses]);
      AppLogger.i('Running interpreter...');
      _interpreter!.run(inputTensor, output);
      AppLogger.i('Prediction successful. Output: ' + output[0].toString());
      return List<double>.from(output[0]);
    } catch (e, stack) {
      AppLogger.e('Prediction failed: $e');
      AppLogger.e('Stacktrace: $stack');
      rethrow;
    }
  }

  void close() {
    _interpreter?.close();
    _interpreter = null;
  }
}
