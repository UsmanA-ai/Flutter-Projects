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
      // Call the JS interop function
      final jsResult = await _runInferenceJS('brain'.toJS).toDart;
      return (jsResult as JSString).toDart;
    } catch (e) {
      print("JS Inference error (Brain): $e");
      return 'Error during JS inference: $e';
    }
  }

  Future<String> predictSkinCancer(XFile imageFile) async {
    try {
      // Call the JS interop function
      final jsResult = await _runInferenceJS('skin'.toJS).toDart;
      return (jsResult as JSString).toDart;
    } catch (e) {
      print("JS Inference error (Skin): $e");
      return 'Error during JS inference: $e';
    }
  }
}
