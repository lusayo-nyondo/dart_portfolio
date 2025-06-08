// lib/builder.dart
import 'dart:async';

import 'package:build/build.dart';

import 'package:dart_portfolio/components/tailwindcss/tailwindcss.dart';

/// A builder that collects all Tailwind CSS classes used in your Dart code
/// and writes them to a global CSS file.
class TailwindClassCollectingBuilder implements Builder {
  const TailwindClassCollectingBuilder();

  @override
  Map<String, List<String>> get buildExtensions => const {
        '.dart': [
          '.tailwind_classes_collected', // A dummy output to signal completion
          // This builder's primary output is the side-effect of writing tailwind.g.css
        ]
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    // We only want to process the main application entry point (or a specific file)
    // to trigger the global collection once per build cycle.
    // Adjust this path if your main entry file is not lib/main.dart.
    if (!buildStep.inputId.path.endsWith('lib/main.dart')) {
      return;
    }

    print(
        'TailwindClassCollectingBuilder: Initializing for build step on ${buildStep.inputId.path}');

    // Clear previous state to ensure a fresh collection for this build run.
    // This is crucial for accurate class generation when files change.
    GlobalTailwindTracker.instance.clearCollectedClasses();

    // ----- !!! CRITICAL STEP !!! -----
    // Call the static method in your main.dart to trigger the registration
    // of all component-level Tailwind classes with the global tracker.
    // This is how the builder "scans" your app's intended class usage.
    //app_entry_point.triggerTailwindCollection();
    // ----- !!! END CRITICAL STEP !!! -----

    print(
        'TailwindClassCollectingBuilder: Classes collected. Total: ${GlobalTailwindTracker.instance.registeredClasses.length}');

    // After collection, generate the tailwind.g.css file.
    // The path here is relative to your project's root.
    await GlobalTailwindTracker.instance
        .generateTailwindFile('tailwind.g.css'); // Adjust path as needed

    // Write a dummy output file to indicate the builder has completed for this input.
    // This is important for build_runner's dependency tracking.
    await buildStep.writeAsString(
        buildStep.inputId.addExtension('.tailwind_classes_collected'),
        'Tailwind classes collected successfully for ${buildStep.inputId.path}');
  }
}

// Top-level function for build_runner to discover the builder.
// The name `tailwindClassCollectingBuilder` will be used in `build.yaml`.
Builder tailwindClassCollectingBuilder(BuilderOptions options) =>
    const TailwindClassCollectingBuilder();
