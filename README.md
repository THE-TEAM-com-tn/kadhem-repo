# elearning_provider

A new Flutter project.

## Info


Additional run args (flutter run ...): 

```
-d chrome --web-hostname localhost --web-port 5000
```

<br/>

Additional attach args (flutter run ...):

```
--web-renderer html
```




### Errors : 

Img :

```
======== Exception caught by image resource service ================================================
The following ImageCodecException was thrown resolving an image codec:
Failed to detect image file format using the file header.
File header was [0x3c 0x21 0x44 0x4f 0x43 0x54 0x59 0x50 0x45 0x20].
Image source: http://localhost:5000/

When the exception was thrown, this was the stack: 
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/_internal/js_dev_runtime/private/ddc_runtime/errors.dart 266:49  throw_
C:/b/s/w/ir/cache/builder/src/out/host_debug/lib/_engine/engine/canvaskit/image_web_codecs.dart 60:7                       create
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/_internal/js_dev_runtime/patch/async_patch.dart 84:54            runBody
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/_internal/js_dev_runtime/patch/async_patch.dart 123:5            _async
C:/b/s/w/ir/cache/builder/src/out/host_debug/lib/_engine/engine/canvaskit/image_web_codecs.dart 43:46                      create
C:/b/s/w/ir/cache/builder/src/out/host_debug/lib/_engine/engine/canvaskit/image.dart 87:34                                 skiaInstantiateWebImageCodec
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/_internal/js_dev_runtime/patch/async_patch.dart 45:50            <fn>
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/async/zone.dart 1660:54                                          runUnary
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/async/future_impl.dart 147:18                                    handleValue
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/async/future_impl.dart 767:44                                    handleValueCallback
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/async/future_impl.dart 796:13                                    _propagateToListeners
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/async/future_impl.dart 567:5                                     [_completeWithValue]
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/async/future_impl.dart 640:7                                     callback
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/async/schedule_microtask.dart 40:11                              _microtaskLoop
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/async/schedule_microtask.dart 49:5                               _startMicrotaskLoop
C:/b/s/w/ir/cache/builder/src/out/host_debug/dart-sdk/lib/_internal/js_dev_runtime/patch/async_patch.dart 166:15           <fn>
Image provider: NetworkImage("", scale: 1)
Image key: NetworkImage("", scale: 1)
====================================================================================================
```