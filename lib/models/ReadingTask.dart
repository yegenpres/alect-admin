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


/** This is an auto generated class representing the ReadingTask type in your schema. */
@immutable
class ReadingTask extends Model {
  static const classType = const _ReadingTaskModelType();
  final String id;
  final String? _text;
  final String? _book;
  final String? _chapter;
  final String? _soundPath;
  final Level? _level;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ReadingTaskModelIdentifier get modelIdentifier {
      return ReadingTaskModelIdentifier(
        id: id
      );
  }
  
  String get text {
    try {
      return _text!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get book {
    try {
      return _book!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get chapter {
    try {
      return _chapter!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
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
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const ReadingTask._internal({required this.id, required text, required book, required chapter, required soundPath, required level, createdAt, updatedAt}): _text = text, _book = book, _chapter = chapter, _soundPath = soundPath, _level = level, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory ReadingTask({String? id, required String text, required String book, required String chapter, required String soundPath, required Level level}) {
    return ReadingTask._internal(
      id: id == null ? UUID.getUUID() : id,
      text: text,
      book: book,
      chapter: chapter,
      soundPath: soundPath,
      level: level);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReadingTask &&
      id == other.id &&
      _text == other._text &&
      _book == other._book &&
      _chapter == other._chapter &&
      _soundPath == other._soundPath &&
      _level == other._level;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ReadingTask {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("text=" + "$_text" + ", ");
    buffer.write("book=" + "$_book" + ", ");
    buffer.write("chapter=" + "$_chapter" + ", ");
    buffer.write("soundPath=" + "$_soundPath" + ", ");
    buffer.write("level=" + (_level != null ? enumToString(_level)! : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ReadingTask copyWith({String? text, String? book, String? chapter, String? soundPath, Level? level}) {
    return ReadingTask._internal(
      id: id,
      text: text ?? this.text,
      book: book ?? this.book,
      chapter: chapter ?? this.chapter,
      soundPath: soundPath ?? this.soundPath,
      level: level ?? this.level);
  }
  
  ReadingTask.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _text = json['text'],
      _book = json['book'],
      _chapter = json['chapter'],
      _soundPath = json['soundPath'],
      _level = enumFromString<Level>(json['level'], Level.values),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'text': _text, 'book': _book, 'chapter': _chapter, 'soundPath': _soundPath, 'level': enumToString(_level), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'text': _text, 'book': _book, 'chapter': _chapter, 'soundPath': _soundPath, 'level': _level, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<ReadingTaskModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<ReadingTaskModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField TEXT = QueryField(fieldName: "text");
  static final QueryField BOOK = QueryField(fieldName: "book");
  static final QueryField CHAPTER = QueryField(fieldName: "chapter");
  static final QueryField SOUNDPATH = QueryField(fieldName: "soundPath");
  static final QueryField LEVEL = QueryField(fieldName: "level");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ReadingTask";
    modelSchemaDefinition.pluralName = "ReadingTasks";
    
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
      key: ReadingTask.TEXT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ReadingTask.BOOK,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ReadingTask.CHAPTER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ReadingTask.SOUNDPATH,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ReadingTask.LEVEL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
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

class _ReadingTaskModelType extends ModelType<ReadingTask> {
  const _ReadingTaskModelType();
  
  @override
  ReadingTask fromJson(Map<String, dynamic> jsonData) {
    return ReadingTask.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'ReadingTask';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [ReadingTask] in your schema.
 */
@immutable
class ReadingTaskModelIdentifier implements ModelIdentifier<ReadingTask> {
  final String id;

  /** Create an instance of ReadingTaskModelIdentifier using [id] the primary key. */
  const ReadingTaskModelIdentifier({
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
  String toString() => 'ReadingTaskModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ReadingTaskModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}