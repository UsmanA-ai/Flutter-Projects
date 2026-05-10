import 'dart:async';
import 'dart:js_interop';
import 'package:image_picker/image_picker.dart';

// Bind to the global window.runInference function defined in tfjs_interop.js
@JS('runInference')
external JSPromise _runInferenceJS(JSString modelType);

class MLService {
  Future<void> loadModels() async {
    // Models are loaded asynchronously in the background via tfjs_interop.js
    // We just print a confirmation here.
    print('TFJS Models load requested in JS context.');
  }

  Future<String> predictBrainTumor(XFile imageFile) async {
    try {
      print("Starting Brain Tumor inference...");
      // Call the JS interop function with a timeout
      final jsResult = await _runInferenceJS('brain'.toJS).toDart.timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException('Inference timed out after 10 seconds'),
      );
      return (jsResult as JSString).toDart;
    } catch (e) {
      print("Inference error (Brain): $e");
      return 'Inference failed: $e';
    }
  }

  Future<String> predictSkinCancer(XFile imageFile) async {
    try {
      print("Starting Skin Cancer inference...");
      // Call the JS interop function with a timeout
      final jsResult = await _runInferenceJS('skin'.toJS).toDart.timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException('Inference timed out after 10 seconds'),
      );
      return (jsResult as JSString).toDart;
    } catch (e) {
      print("Inference error (Skin): $e");
      return 'Inference failed: $e';
    }
  }
}
