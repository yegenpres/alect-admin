/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Word type in your schema. */
@immutable
class Word extends Model {
  static const classType = const _WordModelType();
  final String id;
  final String? _soundPath;
  final String? _translateEng;
  final String? _translateUkr;
  final String? _wordDK;
  final Level? _level;
  final String? _taskId;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  WordModelIdentifier get modelIdentifier {
      return WordModelIdentifier(
        id: id
      );
  }
  
  String get soundPath {
    try {
      return _soundPath!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get translateEng {
    try {
      return _translateEng!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get translateUkr {
    try {
      return _translateUkr!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get wordDK {
    try {
      return _wordDK!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Level get level {
    try {
      return _level!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get taskId {
    try {
      return _taskId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Word._internal({required this.id, required soundPath, required translateEng, required translateUkr, required wordDK, required level, required taskId, createdAt, updatedAt}): _soundPath = soundPath, _translateEng = translateEng, _translateUkr = translateUkr, _wordDK = wordDK, _level = level, _taskId = taskId, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Word({String? id, required String soundPath, required String translateEng, required String translateUkr, required String wordDK, required Level level, required String taskId}) {
    return Word._internal(
      id: id == null ? UUID.getUUID() : id,
      soundPath: soundPath,
      translateEng: translateEng,
      translateUkr: translateUkr,
      wordDK: wordDK,
      level: level,
      taskId: taskId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Word &&
      id == other.id &&
      _soundPath == other._soundPath &&
      _translateEng == other._translateEng &&
      _translateUkr == other._translateUkr &&
      _wordDK == other._wordDK &&
      _level == other._level &&
      _taskId == other._taskId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Word {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("soundPath=" + "$_soundPath" + ", ");
    buffer.write("translateEng=" + "$_translateEng" + ", ");
    buffer.write("translateUkr=" + "$_translateUkr" + ", ");
    buffer.write("wordDK=" + "$_wordDK" + ", ");
    buffer.write("level=" + (_level != null ? enumToString(_level)! : "null") + ", ");
    buffer.write("taskId=" + "$_taskId" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Word copyWith({String? soundPath, String? translateEng, String? translateUkr, String? wordDK, Level? level, String? taskId}) {
    return Word._internal(
      id: id,
      soundPath: soundPath ?? this.soundPath,
      translateEng: translateEng ?? this.translateEng,
      translateUkr: translateUkr ?? this.translateUkr,
      wordDK: wordDK ?? this.wordDK,
      level: level ?? this.level,
      taskId: taskId ?? this.taskId);
  }
  
  Word.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _soundPath = json['soundPath'],
      _translateEng = json['translateEng'],
      _translateUkr = json['translateUkr'],
      _wordDK = json['wordDK'],
      _level = enumFromString<Level>(json['level'], Level.values),
      _taskId = json['taskId'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'soundPath': _soundPath, 'translateEng': _translateEng, 'translateUkr': _translateUkr, 'wordDK': _wordDK, 'level': enumToString(_level), 'taskId': _taskId, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'soundPath': _soundPath, 'translateEng': _translateEng, 'translateUkr': _translateUkr, 'wordDK': _wordDK, 'level': _level, 'taskId': _taskId, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<WordModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<WordModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField SOUNDPATH = QueryField(fieldName: "soundPath");
  static final QueryField TRANSLATEENG = QueryField(fieldName: "translateEng");
  static final QueryField TRANSLATEUKR = QueryField(fieldName: "translateUkr");
  static final QueryField WORDDK = QueryField(fieldName: "wordDK");
  static final QueryField LEVEL = QueryField(fieldName: "level");
  static final QueryField TASKID = QueryField(fieldName: "taskId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Word";
    modelSchemaDefinition.pluralName = "Words";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Word.SOUNDPATH,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Word.TRANSLATEENG,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Word.TRANSLATEUKR,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Word.WORDDK,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Word.LEVEL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Word.TASKID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _WordModelType extends ModelType<Word> {
  const _WordModelType();
  
  @override
  Word fromJson(Map<String, dynamic> jsonData) {
    return Word.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Word';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Word] in your schema.
 */
@immutable
class WordModelIdentifier implements ModelIdentifier<Word> {
  final String id;

  /** Create an instance of WordModelIdentifier using [id] the primary key. */
  const WordModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'WordModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is WordModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}