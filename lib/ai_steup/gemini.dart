import 'package:dart_openai/dart_openai.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// For generating prompt to generate image.
Future<String> generate(String topic) async {
  String combined = '';
  // Access your API key as an environment variable (see "Set up your API key" above)
  const apiKey = 'AIzaSyDcJgpYKpB91bgCrZm5CyeVQlRl90ei2MM';

  // For text-only input, use the gemini-pro model
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  final content = [
    Content.text('''You are a prompt generator.

Generate a prompt for creating a meme image on the topic of student confusion. The meme should humorously depict a situation where a student is confused about the topic: {$topic}

Additional Instructions:
- Include a brief description of the meme scenario.
- Provide a catchy caption that adds humor to the meme.
- Ensure the meme is relatable to students and conveys the theme of confusion effectively.

The format should be 
Topic:$topic
Meme template:
Scenario:
Caption:
and positions accordingly
Only the prompt.

FOLLOW THE FORMAT.
AGE GROUP: 15-30 YEARS.
MAKE SURE THE MEME TEMPLATE IS POPULAR.''')
  ];
  final response = await model.generateContent(content);
  combined = combined + response.text!;
  // print(response.text);
  return combined;
}

// For Generating AI Image.
Future<String> createAIImange(String prompt) async {
  String url = '';
  OpenAI.apiKey = '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';

  OpenAIImageModel image = await OpenAI.instance.image.create(
    prompt: prompt,
    n: 1,
    size: OpenAIImageSize.size512,
    responseFormat: OpenAIImageResponseFormat.url,
  );
  url = image.data[0].url.toString();
  return url;
}
