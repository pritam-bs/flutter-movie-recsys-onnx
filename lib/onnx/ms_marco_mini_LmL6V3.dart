import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter_movie_list/onnx/bert_vocab.dart';
import 'package:flutter_movie_list/onnx/wordpiece_tokenizer.dart';
import 'package:onnxruntime/onnxruntime.dart';

class MsmarcoMiniLmL6V3 {
  OrtSessionOptions? _sessionOptions;
  OrtSession? _session;
  final tokenizer = const WordpieceTokenizer(
    encoder: bertEncoder,
    decoder: bertDecoder,
    unkString: '[UNK]',
    unkToken: 100,
    startToken: 101,
    endToken: 102,
    maxInputTokens: 512,
    maxInputCharsPerWord: 100,
  );

  Future<void> initModel() async {
    _sessionOptions = OrtSessionOptions()
      ..setInterOpNumThreads(1)
      ..setIntraOpNumThreads(1)
      ..setSessionGraphOptimizationLevel(GraphOptimizationLevel.ortEnableAll);
    const assetFileName = 'assets/models/miniLmL6V2/miniLmL6V2.onnx';
    // const assetFileName =
    //     'assets/models/msmarcoMiniLmL6V3/msmarcoMiniLmL6V3.onnx';
    final rawAssetFile = await rootBundle.load(assetFileName);
    final bytes = rawAssetFile.buffer.asUint8List();
    _session = OrtSession.fromBuffer(bytes, _sessionOptions!);
  }

  void release() {
    _sessionOptions?.release();
    _sessionOptions = null;
    _session?.release();
    _session = null;
    OrtEnv.instance.release();
  }

  Future<List<double>?> getEmbeddings(String text) async {
    final runOptions = OrtRunOptions();
    final tokens = tokenizer.tokenize(text).first.tokens;
    final inputTensor = OrtValueTensor.createTensorWithDataList(
      tokens,
      [1, tokens.length],
    );
    final attentionTensor = OrtValueTensor.createTensorWithDataList(
      List.filled(tokens.length, 1),
      [1, tokens.length],
    );
    final tokenTypeTensor = OrtValueTensor.createTensorWithDataList(
      List.filled(tokens.length, 0),
      [1, tokens.length],
    );
    final outputs = await _session?.runAsync(runOptions, {
      'input_ids': inputTensor,
      'attention_mask': attentionTensor,
      'token_type_ids': tokenTypeTensor,
    });
    if (outputs != null) {
      final embeddings = (outputs[0]?.value as List<List<double>>)[0];
      return embeddings;
    }

    return null;
  }

  double cosineSimilarity(List<double> vec1, List<double> vec2) {
    if (vec1.length != vec2.length) {
      throw Exception('Vectors must be of the same length');
    }

    var dotProduct = 0.0;
    var normVec1 = 0.0;
    var normVec2 = 0.0;

    for (var i = 0; i < vec1.length; i++) {
      dotProduct += vec1[i] * vec2[i];
      normVec1 += vec1[i] * vec1[i];
      normVec2 += vec2[i] * vec2[i];
    }

    if (normVec1 == 0.0 || normVec2 == 0.0) {
      throw Exception('Vector norm cannot be zero');
    }

    return dotProduct / (math.sqrt(normVec1) * math.sqrt(normVec2));
  }
}
