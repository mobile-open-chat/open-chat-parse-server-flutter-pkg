// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_collection_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetMessagesCollectionModelCollection on Isar {
  IsarCollection<MessagesCollectionModel> get Messages => this.collection();
}

const MessagesCollectionModelSchema = CollectionSchema(
  name: r'Messages',
  id: -7414220297808124218,
  properties: {
    r'hashCode': PropertySchema(
      id: 0,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'imageMessage': PropertySchema(
      id: 1,
      name: r'imageMessage',
      type: IsarType.object,
      target: r'ImageMessage',
    ),
    r'localSentDate': PropertySchema(
      id: 2,
      name: r'localSentDate',
      type: IsarType.dateTime,
    ),
    r'messageType': PropertySchema(
      id: 3,
      name: r'messageType',
      type: IsarType.string,
    ),
    r'receivedMessageDeliveryState': PropertySchema(
      id: 4,
      name: r'receivedMessageDeliveryState',
      type: IsarType.byte,
      enumMap:
          _MessagesCollectionModelreceivedMessageDeliveryStateForLocalDBEnumValueMap,
    ),
    r'receivedMessageProperties': PropertySchema(
      id: 5,
      name: r'receivedMessageProperties',
      type: IsarType.object,
      target: r'ReceivedMessageProperties',
    ),
    r'remoteCreationDate': PropertySchema(
      id: 6,
      name: r'remoteCreationDate',
      type: IsarType.dateTime,
    ),
    r'remoteMessageId': PropertySchema(
      id: 7,
      name: r'remoteMessageId',
      type: IsarType.string,
    ),
    r'sentMessageProperties': PropertySchema(
      id: 8,
      name: r'sentMessageProperties',
      type: IsarType.object,
      target: r'SentMessageProperties',
    ),
    r'textMessage': PropertySchema(
      id: 9,
      name: r'textMessage',
      type: IsarType.object,
      target: r'TextMessage',
    ),
    r'userId': PropertySchema(
      id: 10,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _messagesCollectionModelEstimateSize,
  serialize: _messagesCollectionModelSerialize,
  deserialize: _messagesCollectionModelDeserialize,
  deserializeProp: _messagesCollectionModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'remoteMessageId': IndexSchema(
      id: -8093252508343952689,
      name: r'remoteMessageId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'remoteMessageId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'receivedMessageDeliveryState': IndexSchema(
      id: -1701020371036156273,
      name: r'receivedMessageDeliveryState',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'receivedMessageDeliveryState',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'SentMessageProperties': SentMessagePropertiesSchema,
    r'ReceivedMessageProperties': ReceivedMessagePropertiesSchema,
    r'TextMessage': TextMessageSchema,
    r'ImageMessage': ImageMessageSchema
  },
  getId: _messagesCollectionModelGetId,
  getLinks: _messagesCollectionModelGetLinks,
  attach: _messagesCollectionModelAttach,
  version: '3.0.2',
);

int _messagesCollectionModelEstimateSize(
  MessagesCollectionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.imageMessage;
    if (value != null) {
      bytesCount += 3 +
          ImageMessageSchema.estimateSize(
              value, allOffsets[ImageMessage]!, allOffsets);
    }
  }
  bytesCount += 3 + object.messageType.length * 3;
  {
    final value = object.receivedMessageProperties;
    if (value != null) {
      bytesCount += 3 +
          ReceivedMessagePropertiesSchema.estimateSize(
              value, allOffsets[ReceivedMessageProperties]!, allOffsets);
    }
  }
  {
    final value = object.remoteMessageId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sentMessageProperties;
    if (value != null) {
      bytesCount += 3 +
          SentMessagePropertiesSchema.estimateSize(
              value, allOffsets[SentMessageProperties]!, allOffsets);
    }
  }
  {
    final value = object.textMessage;
    if (value != null) {
      bytesCount += 3 +
          TextMessageSchema.estimateSize(
              value, allOffsets[TextMessage]!, allOffsets);
    }
  }
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _messagesCollectionModelSerialize(
  MessagesCollectionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.hashCode);
  writer.writeObject<ImageMessage>(
    offsets[1],
    allOffsets,
    ImageMessageSchema.serialize,
    object.imageMessage,
  );
  writer.writeDateTime(offsets[2], object.localSentDate);
  writer.writeString(offsets[3], object.messageType);
  writer.writeByte(
      offsets[4], object.receivedMessageDeliveryStateForLocalDB.index);
  writer.writeObject<ReceivedMessageProperties>(
    offsets[5],
    allOffsets,
    ReceivedMessagePropertiesSchema.serialize,
    object.receivedMessageProperties,
  );
  writer.writeDateTime(offsets[6], object.remoteCreationDate);
  writer.writeString(offsets[7], object.remoteMessageId);
  writer.writeObject<SentMessageProperties>(
    offsets[8],
    allOffsets,
    SentMessagePropertiesSchema.serialize,
    object.sentMessageProperties,
  );
  writer.writeObject<TextMessage>(
    offsets[9],
    allOffsets,
    TextMessageSchema.serialize,
    object.textMessage,
  );
  writer.writeString(offsets[10], object.userId);
}

MessagesCollectionModel _messagesCollectionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MessagesCollectionModel();
  object.localMessageId = id;
  object.imageMessage = reader.readObjectOrNull<ImageMessage>(
    offsets[1],
    ImageMessageSchema.deserialize,
    allOffsets,
  );
  object.localSentDate = reader.readDateTime(offsets[2]);
  object.messageType = reader.readString(offsets[3]);
  object.receivedMessageDeliveryStateForLocalDB =
      _MessagesCollectionModelreceivedMessageDeliveryStateForLocalDBValueEnumMap[
              reader.readByteOrNull(offsets[4])] ??
          ReceivedMessageDeliveryStateForLocalDB.nil;
  object.receivedMessageProperties =
      reader.readObjectOrNull<ReceivedMessageProperties>(
    offsets[5],
    ReceivedMessagePropertiesSchema.deserialize,
    allOffsets,
  );
  object.remoteCreationDate = reader.readDateTimeOrNull(offsets[6]);
  object.remoteMessageId = reader.readStringOrNull(offsets[7]);
  object.sentMessageProperties = reader.readObjectOrNull<SentMessageProperties>(
    offsets[8],
    SentMessagePropertiesSchema.deserialize,
    allOffsets,
  );
  object.textMessage = reader.readObjectOrNull<TextMessage>(
    offsets[9],
    TextMessageSchema.deserialize,
    allOffsets,
  );
  object.userId = reader.readString(offsets[10]);
  return object;
}

P _messagesCollectionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readObjectOrNull<ImageMessage>(
        offset,
        ImageMessageSchema.deserialize,
        allOffsets,
      )) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (_MessagesCollectionModelreceivedMessageDeliveryStateForLocalDBValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ReceivedMessageDeliveryStateForLocalDB.nil) as P;
    case 5:
      return (reader.readObjectOrNull<ReceivedMessageProperties>(
        offset,
        ReceivedMessagePropertiesSchema.deserialize,
        allOffsets,
      )) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readObjectOrNull<SentMessageProperties>(
        offset,
        SentMessagePropertiesSchema.deserialize,
        allOffsets,
      )) as P;
    case 9:
      return (reader.readObjectOrNull<TextMessage>(
        offset,
        TextMessageSchema.deserialize,
        allOffsets,
      )) as P;
    case 10:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MessagesCollectionModelreceivedMessageDeliveryStateForLocalDBEnumValueMap =
    {
  'nil': 0,
  'sent': 1,
  'delivered': 2,
  'seen': 3,
};
const _MessagesCollectionModelreceivedMessageDeliveryStateForLocalDBValueEnumMap =
    {
  0: ReceivedMessageDeliveryStateForLocalDB.nil,
  1: ReceivedMessageDeliveryStateForLocalDB.sent,
  2: ReceivedMessageDeliveryStateForLocalDB.delivered,
  3: ReceivedMessageDeliveryStateForLocalDB.seen,
};

Id _messagesCollectionModelGetId(MessagesCollectionModel object) {
  return object.localMessageId;
}

List<IsarLinkBase<dynamic>> _messagesCollectionModelGetLinks(
    MessagesCollectionModel object) {
  return [];
}

void _messagesCollectionModelAttach(
    IsarCollection<dynamic> col, Id id, MessagesCollectionModel object) {
  object.localMessageId = id;
}

extension MessagesCollectionModelByIndex
    on IsarCollection<MessagesCollectionModel> {
  Future<MessagesCollectionModel?> getByRemoteMessageId(
      String? remoteMessageId) {
    return getByIndex(r'remoteMessageId', [remoteMessageId]);
  }

  MessagesCollectionModel? getByRemoteMessageIdSync(String? remoteMessageId) {
    return getByIndexSync(r'remoteMessageId', [remoteMessageId]);
  }

  Future<bool> deleteByRemoteMessageId(String? remoteMessageId) {
    return deleteByIndex(r'remoteMessageId', [remoteMessageId]);
  }

  bool deleteByRemoteMessageIdSync(String? remoteMessageId) {
    return deleteByIndexSync(r'remoteMessageId', [remoteMessageId]);
  }

  Future<List<MessagesCollectionModel?>> getAllByRemoteMessageId(
      List<String?> remoteMessageIdValues) {
    final values = remoteMessageIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'remoteMessageId', values);
  }

  List<MessagesCollectionModel?> getAllByRemoteMessageIdSync(
      List<String?> remoteMessageIdValues) {
    final values = remoteMessageIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'remoteMessageId', values);
  }

  Future<int> deleteAllByRemoteMessageId(List<String?> remoteMessageIdValues) {
    final values = remoteMessageIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'remoteMessageId', values);
  }

  int deleteAllByRemoteMessageIdSync(List<String?> remoteMessageIdValues) {
    final values = remoteMessageIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'remoteMessageId', values);
  }

  Future<Id> putByRemoteMessageId(MessagesCollectionModel object) {
    return putByIndex(r'remoteMessageId', object);
  }

  Id putByRemoteMessageIdSync(MessagesCollectionModel object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'remoteMessageId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByRemoteMessageId(
      List<MessagesCollectionModel> objects) {
    return putAllByIndex(r'remoteMessageId', objects);
  }

  List<Id> putAllByRemoteMessageIdSync(List<MessagesCollectionModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'remoteMessageId', objects, saveLinks: saveLinks);
  }
}

extension MessagesCollectionModelQueryWhereSort
    on QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QWhere> {
  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterWhere>
      anyLocalMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterWhere>
      anyReceivedMessageDeliveryStateForLocalDB() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'receivedMessageDeliveryState'),
      );
    });
  }
}

extension MessagesCollectionModelQueryWhere on QueryBuilder<
    MessagesCollectionModel, MessagesCollectionModel, QWhereClause> {
  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterWhereClause> localMessageIdEqualTo(Id localMessageId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localMessageId,
        upper: localMessageId,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterWhereClause> localMessageIdNotEqualTo(Id localMessageId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(
                  upper: localMessageId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: localMessageId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: localMessageId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(
                  upper: localMessageId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
          QAfterWhereClause>
      localMessageIdGreaterThan(Id localMessageId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localMessageId, includeLower: include),
      );
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
          QAfterWhereClause>
      localMessageIdLessThan(Id localMessageId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localMessageId, includeUpper: include),
      );
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterWhereClause> localMessageIdBetween(
    Id lowerLocalMessageId,
    Id upperLocalMessageId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerLocalMessageId,
        includeLower: includeLower,
        upper: upperLocalMessageId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterWhereClause> remoteMessageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'remoteMessageId',
        value: [null],
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterWhereClause> remoteMessageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'remoteMessageId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterWhereClause> remoteMessageIdEqualTo(String? remoteMessageId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'remoteMessageId',
        value: [remoteMessageId],
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterWhereClause> remoteMessageIdNotEqualTo(String? remoteMessageId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteMessageId',
              lower: [],
              upper: [remoteMessageId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteMessageId',
              lower: [remoteMessageId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteMessageId',
              lower: [remoteMessageId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'remoteMessageId',
              lower: [],
              upper: [remoteMessageId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterWhereClause> userIdEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterWhereClause> userIdNotEqualTo(String userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
          QAfterWhereClause>
      receivedMessageDeliveryStateForLocalDBEqualTo(
          ReceivedMessageDeliveryStateForLocalDB
              receivedMessageDeliveryStateForLocalDB) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'receivedMessageDeliveryState',
        value: [receivedMessageDeliveryStateForLocalDB],
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
          QAfterWhereClause>
      receivedMessageDeliveryStateForLocalDBNotEqualTo(
          ReceivedMessageDeliveryStateForLocalDB
              receivedMessageDeliveryStateForLocalDB) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'receivedMessageDeliveryState',
              lower: [],
              upper: [receivedMessageDeliveryStateForLocalDB],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'receivedMessageDeliveryState',
              lower: [receivedMessageDeliveryStateForLocalDB],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'receivedMessageDeliveryState',
              lower: [receivedMessageDeliveryStateForLocalDB],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'receivedMessageDeliveryState',
              lower: [],
              upper: [receivedMessageDeliveryStateForLocalDB],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterWhereClause> receivedMessageDeliveryStateForLocalDBGreaterThan(
    ReceivedMessageDeliveryStateForLocalDB
        receivedMessageDeliveryStateForLocalDB, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'receivedMessageDeliveryState',
        lower: [receivedMessageDeliveryStateForLocalDB],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterWhereClause> receivedMessageDeliveryStateForLocalDBLessThan(
    ReceivedMessageDeliveryStateForLocalDB
        receivedMessageDeliveryStateForLocalDB, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'receivedMessageDeliveryState',
        lower: [],
        upper: [receivedMessageDeliveryStateForLocalDB],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterWhereClause> receivedMessageDeliveryStateForLocalDBBetween(
    ReceivedMessageDeliveryStateForLocalDB
        lowerReceivedMessageDeliveryStateForLocalDB,
    ReceivedMessageDeliveryStateForLocalDB
        upperReceivedMessageDeliveryStateForLocalDB, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'receivedMessageDeliveryState',
        lower: [lowerReceivedMessageDeliveryStateForLocalDB],
        includeLower: includeLower,
        upper: [upperReceivedMessageDeliveryStateForLocalDB],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MessagesCollectionModelQueryFilter on QueryBuilder<
    MessagesCollectionModel, MessagesCollectionModel, QFilterCondition> {
  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> localMessageIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> localMessageIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> localMessageIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> localMessageIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> imageMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageMessage',
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> imageMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageMessage',
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> localSentDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localSentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> localSentDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localSentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> localSentDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localSentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> localSentDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localSentDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> messageTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> messageTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> messageTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> messageTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> messageTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'messageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> messageTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'messageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
          QAfterFilterCondition>
      messageTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'messageType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
          QAfterFilterCondition>
      messageTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'messageType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> messageTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageType',
        value: '',
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> messageTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'messageType',
        value: '',
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
          QAfterFilterCondition>
      receivedMessageDeliveryStateForLocalDBEqualTo(
          ReceivedMessageDeliveryStateForLocalDB value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'receivedMessageDeliveryState',
        value: value,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> receivedMessageDeliveryStateForLocalDBGreaterThan(
    ReceivedMessageDeliveryStateForLocalDB value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'receivedMessageDeliveryState',
        value: value,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> receivedMessageDeliveryStateForLocalDBLessThan(
    ReceivedMessageDeliveryStateForLocalDB value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'receivedMessageDeliveryState',
        value: value,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> receivedMessageDeliveryStateForLocalDBBetween(
    ReceivedMessageDeliveryStateForLocalDB lower,
    ReceivedMessageDeliveryStateForLocalDB upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'receivedMessageDeliveryState',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> receivedMessagePropertiesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'receivedMessageProperties',
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> receivedMessagePropertiesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'receivedMessageProperties',
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> remoteCreationDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'remoteCreationDate',
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> remoteCreationDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'remoteCreationDate',
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> remoteCreationDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteCreationDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> remoteCreationDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remoteCreationDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> remoteCreationDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remoteCreationDate',
        value: value,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> remoteCreationDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remoteCreationDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> remoteMessageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'remoteMessageId',
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> remoteMessageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'remoteMessageId',
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> remoteMessageIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> remoteMessageIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remoteMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> remoteMessageIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remoteMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> remoteMessageIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remoteMessageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> remoteMessageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'remoteMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> remoteMessageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'remoteMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
          QAfterFilterCondition>
      remoteMessageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'remoteMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
          QAfterFilterCondition>
      remoteMessageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'remoteMessageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> remoteMessageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteMessageId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> remoteMessageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'remoteMessageId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> sentMessagePropertiesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sentMessageProperties',
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> sentMessagePropertiesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sentMessageProperties',
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> textMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'textMessage',
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> textMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'textMessage',
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
          QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
          QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension MessagesCollectionModelQueryObject on QueryBuilder<
    MessagesCollectionModel, MessagesCollectionModel, QFilterCondition> {
  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> imageMessage(FilterQuery<ImageMessage> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'imageMessage');
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
          QAfterFilterCondition>
      receivedMessageProperties(FilterQuery<ReceivedMessageProperties> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'receivedMessageProperties');
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
          QAfterFilterCondition>
      sentMessageProperties(FilterQuery<SentMessageProperties> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'sentMessageProperties');
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel,
      QAfterFilterCondition> textMessage(FilterQuery<TextMessage> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'textMessage');
    });
  }
}

extension MessagesCollectionModelQueryLinks on QueryBuilder<
    MessagesCollectionModel, MessagesCollectionModel, QFilterCondition> {}

extension MessagesCollectionModelQuerySortBy
    on QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QSortBy> {
  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      sortByLocalSentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localSentDate', Sort.asc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      sortByLocalSentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localSentDate', Sort.desc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      sortByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      sortByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      sortByReceivedMessageDeliveryStateForLocalDB() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedMessageDeliveryState', Sort.asc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      sortByReceivedMessageDeliveryStateForLocalDBDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedMessageDeliveryState', Sort.desc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      sortByRemoteCreationDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteCreationDate', Sort.asc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      sortByRemoteCreationDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteCreationDate', Sort.desc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      sortByRemoteMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteMessageId', Sort.asc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      sortByRemoteMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteMessageId', Sort.desc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension MessagesCollectionModelQuerySortThenBy on QueryBuilder<
    MessagesCollectionModel, MessagesCollectionModel, QSortThenBy> {
  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      thenByLocalMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      thenByLocalMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      thenByLocalSentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localSentDate', Sort.asc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      thenByLocalSentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localSentDate', Sort.desc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      thenByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      thenByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      thenByReceivedMessageDeliveryStateForLocalDB() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedMessageDeliveryState', Sort.asc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      thenByReceivedMessageDeliveryStateForLocalDBDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'receivedMessageDeliveryState', Sort.desc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      thenByRemoteCreationDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteCreationDate', Sort.asc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      thenByRemoteCreationDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteCreationDate', Sort.desc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      thenByRemoteMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteMessageId', Sort.asc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      thenByRemoteMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteMessageId', Sort.desc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension MessagesCollectionModelQueryWhereDistinct on QueryBuilder<
    MessagesCollectionModel, MessagesCollectionModel, QDistinct> {
  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QDistinct>
      distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QDistinct>
      distinctByLocalSentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localSentDate');
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QDistinct>
      distinctByMessageType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QDistinct>
      distinctByReceivedMessageDeliveryStateForLocalDB() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'receivedMessageDeliveryState');
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QDistinct>
      distinctByRemoteCreationDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteCreationDate');
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QDistinct>
      distinctByRemoteMessageId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteMessageId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MessagesCollectionModel, MessagesCollectionModel, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension MessagesCollectionModelQueryProperty on QueryBuilder<
    MessagesCollectionModel, MessagesCollectionModel, QQueryProperty> {
  QueryBuilder<MessagesCollectionModel, int, QQueryOperations>
      localMessageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MessagesCollectionModel, int, QQueryOperations>
      hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<MessagesCollectionModel, ImageMessage?, QQueryOperations>
      imageMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageMessage');
    });
  }

  QueryBuilder<MessagesCollectionModel, DateTime, QQueryOperations>
      localSentDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localSentDate');
    });
  }

  QueryBuilder<MessagesCollectionModel, String, QQueryOperations>
      messageTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageType');
    });
  }

  QueryBuilder<MessagesCollectionModel, ReceivedMessageDeliveryStateForLocalDB,
      QQueryOperations> receivedMessageDeliveryStateForLocalDBProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'receivedMessageDeliveryState');
    });
  }

  QueryBuilder<MessagesCollectionModel, ReceivedMessageProperties?,
      QQueryOperations> receivedMessagePropertiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'receivedMessageProperties');
    });
  }

  QueryBuilder<MessagesCollectionModel, DateTime?, QQueryOperations>
      remoteCreationDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteCreationDate');
    });
  }

  QueryBuilder<MessagesCollectionModel, String?, QQueryOperations>
      remoteMessageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteMessageId');
    });
  }

  QueryBuilder<MessagesCollectionModel, SentMessageProperties?,
      QQueryOperations> sentMessagePropertiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sentMessageProperties');
    });
  }

  QueryBuilder<MessagesCollectionModel, TextMessage?, QQueryOperations>
      textMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textMessage');
    });
  }

  QueryBuilder<MessagesCollectionModel, String, QQueryOperations>
      userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const TextMessageSchema = Schema(
  name: r'TextMessage',
  id: 1394217023106951580,
  properties: {
    r'hashCode': PropertySchema(
      id: 0,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'text': PropertySchema(
      id: 1,
      name: r'text',
      type: IsarType.string,
    )
  },
  estimateSize: _textMessageEstimateSize,
  serialize: _textMessageSerialize,
  deserialize: _textMessageDeserialize,
  deserializeProp: _textMessageDeserializeProp,
);

int _textMessageEstimateSize(
  TextMessage object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _textMessageSerialize(
  TextMessage object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.hashCode);
  writer.writeString(offsets[1], object.text);
}

TextMessage _textMessageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TextMessage();
  object.text = reader.readString(offsets[1]);
  return object;
}

P _textMessageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TextMessageQueryFilter
    on QueryBuilder<TextMessage, TextMessage, QFilterCondition> {
  QueryBuilder<TextMessage, TextMessage, QAfterFilterCondition> hashCodeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<TextMessage, TextMessage, QAfterFilterCondition>
      hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<TextMessage, TextMessage, QAfterFilterCondition>
      hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<TextMessage, TextMessage, QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TextMessage, TextMessage, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextMessage, TextMessage, QAfterFilterCondition> textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextMessage, TextMessage, QAfterFilterCondition> textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextMessage, TextMessage, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextMessage, TextMessage, QAfterFilterCondition> textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextMessage, TextMessage, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextMessage, TextMessage, QAfterFilterCondition> textContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextMessage, TextMessage, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextMessage, TextMessage, QAfterFilterCondition> textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<TextMessage, TextMessage, QAfterFilterCondition>
      textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }
}

extension TextMessageQueryObject
    on QueryBuilder<TextMessage, TextMessage, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const ImageMessageSchema = Schema(
  name: r'ImageMessage',
  id: 3940839185407678174,
  properties: {
    r'hashCode': PropertySchema(
      id: 0,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'hight': PropertySchema(
      id: 1,
      name: r'hight',
      type: IsarType.long,
    ),
    r'imageFilePath': PropertySchema(
      id: 2,
      name: r'imageFilePath',
      type: IsarType.string,
    ),
    r'imageURL': PropertySchema(
      id: 3,
      name: r'imageURL',
      type: IsarType.string,
    ),
    r'size': PropertySchema(
      id: 4,
      name: r'size',
      type: IsarType.long,
    ),
    r'thumbnailFilePath': PropertySchema(
      id: 5,
      name: r'thumbnailFilePath',
      type: IsarType.string,
    ),
    r'thumbnailURL': PropertySchema(
      id: 6,
      name: r'thumbnailURL',
      type: IsarType.string,
    ),
    r'width': PropertySchema(
      id: 7,
      name: r'width',
      type: IsarType.long,
    )
  },
  estimateSize: _imageMessageEstimateSize,
  serialize: _imageMessageSerialize,
  deserialize: _imageMessageDeserialize,
  deserializeProp: _imageMessageDeserializeProp,
);

int _imageMessageEstimateSize(
  ImageMessage object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.imageFilePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.imageURL;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.thumbnailFilePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.thumbnailURL;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _imageMessageSerialize(
  ImageMessage object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.hashCode);
  writer.writeLong(offsets[1], object.hight);
  writer.writeString(offsets[2], object.imageFilePath);
  writer.writeString(offsets[3], object.imageURL);
  writer.writeLong(offsets[4], object.size);
  writer.writeString(offsets[5], object.thumbnailFilePath);
  writer.writeString(offsets[6], object.thumbnailURL);
  writer.writeLong(offsets[7], object.width);
}

ImageMessage _imageMessageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ImageMessage();
  object.hight = reader.readLongOrNull(offsets[1]);
  object.imageFilePath = reader.readStringOrNull(offsets[2]);
  object.imageURL = reader.readStringOrNull(offsets[3]);
  object.size = reader.readLongOrNull(offsets[4]);
  object.thumbnailFilePath = reader.readStringOrNull(offsets[5]);
  object.thumbnailURL = reader.readStringOrNull(offsets[6]);
  object.width = reader.readLongOrNull(offsets[7]);
  return object;
}

P _imageMessageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ImageMessageQueryFilter
    on QueryBuilder<ImageMessage, ImageMessage, QFilterCondition> {
  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      hightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hight',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      hightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hight',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition> hightEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hight',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      hightGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hight',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition> hightLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hight',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition> hightBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageFilePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageFilePath',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageFilePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageFilePath',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageFilePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageFilePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageFilePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageFilePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageFilePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageFilePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageFilePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageFilePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageFilePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageFilePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageFilePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageFilePath',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageFilePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageFilePath',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageURLIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageURL',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageURLIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageURL',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageURLEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageURLGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageURLLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageURLBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageURL',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageURLStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageURLEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageURLContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageURLMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageURL',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageURLIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageURL',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      imageURLIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageURL',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition> sizeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'size',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      sizeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'size',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition> sizeEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      sizeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition> sizeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition> sizeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'size',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailFilePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'thumbnailFilePath',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailFilePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'thumbnailFilePath',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailFilePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailFilePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thumbnailFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailFilePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thumbnailFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailFilePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thumbnailFilePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailFilePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'thumbnailFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailFilePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'thumbnailFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailFilePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'thumbnailFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailFilePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'thumbnailFilePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailFilePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailFilePath',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailFilePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'thumbnailFilePath',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailURLIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'thumbnailURL',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailURLIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'thumbnailURL',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailURLEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailURLGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thumbnailURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailURLLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thumbnailURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailURLBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thumbnailURL',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailURLStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'thumbnailURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailURLEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'thumbnailURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailURLContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'thumbnailURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailURLMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'thumbnailURL',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailURLIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumbnailURL',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      thumbnailURLIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'thumbnailURL',
        value: '',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      widthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'width',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      widthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'width',
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition> widthEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'width',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition>
      widthGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'width',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition> widthLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'width',
        value: value,
      ));
    });
  }

  QueryBuilder<ImageMessage, ImageMessage, QAfterFilterCondition> widthBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'width',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ImageMessageQueryObject
    on QueryBuilder<ImageMessage, ImageMessage, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const SentMessagePropertiesSchema = Schema(
  name: r'SentMessageProperties',
  id: -5799686392740683567,
  properties: {
    r'hashCode': PropertySchema(
      id: 0,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'sentMessageDeliveryState': PropertySchema(
      id: 1,
      name: r'sentMessageDeliveryState',
      type: IsarType.string,
      enumMap: _SentMessagePropertiessentMessageDeliveryStateEnumValueMap,
    )
  },
  estimateSize: _sentMessagePropertiesEstimateSize,
  serialize: _sentMessagePropertiesSerialize,
  deserialize: _sentMessagePropertiesDeserialize,
  deserializeProp: _sentMessagePropertiesDeserializeProp,
);

int _sentMessagePropertiesEstimateSize(
  SentMessageProperties object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.sentMessageDeliveryState.name.length * 3;
  return bytesCount;
}

void _sentMessagePropertiesSerialize(
  SentMessageProperties object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.hashCode);
  writer.writeString(offsets[1], object.sentMessageDeliveryState.name);
}

SentMessageProperties _sentMessagePropertiesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SentMessageProperties();
  object.sentMessageDeliveryState =
      _SentMessagePropertiessentMessageDeliveryStateValueEnumMap[
              reader.readStringOrNull(offsets[1])] ??
          SentMessageDeliveryState.pending;
  return object;
}

P _sentMessagePropertiesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (_SentMessagePropertiessentMessageDeliveryStateValueEnumMap[
              reader.readStringOrNull(offset)] ??
          SentMessageDeliveryState.pending) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _SentMessagePropertiessentMessageDeliveryStateEnumValueMap = {
  r'pending': r'pending',
  r'sent': r'sent',
  r'error': r'error',
  r'delivered': r'delivered',
  r'seen': r'seen',
};
const _SentMessagePropertiessentMessageDeliveryStateValueEnumMap = {
  r'pending': SentMessageDeliveryState.pending,
  r'sent': SentMessageDeliveryState.sent,
  r'error': SentMessageDeliveryState.error,
  r'delivered': SentMessageDeliveryState.delivered,
  r'seen': SentMessageDeliveryState.seen,
};

extension SentMessagePropertiesQueryFilter on QueryBuilder<
    SentMessageProperties, SentMessageProperties, QFilterCondition> {
  QueryBuilder<SentMessageProperties, SentMessageProperties,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<SentMessageProperties, SentMessageProperties,
      QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<SentMessageProperties, SentMessageProperties,
      QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<SentMessageProperties, SentMessageProperties,
      QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SentMessageProperties, SentMessageProperties,
      QAfterFilterCondition> sentMessageDeliveryStateEqualTo(
    SentMessageDeliveryState value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sentMessageDeliveryState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SentMessageProperties, SentMessageProperties,
      QAfterFilterCondition> sentMessageDeliveryStateGreaterThan(
    SentMessageDeliveryState value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sentMessageDeliveryState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SentMessageProperties, SentMessageProperties,
      QAfterFilterCondition> sentMessageDeliveryStateLessThan(
    SentMessageDeliveryState value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sentMessageDeliveryState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SentMessageProperties, SentMessageProperties,
      QAfterFilterCondition> sentMessageDeliveryStateBetween(
    SentMessageDeliveryState lower,
    SentMessageDeliveryState upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sentMessageDeliveryState',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SentMessageProperties, SentMessageProperties,
      QAfterFilterCondition> sentMessageDeliveryStateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sentMessageDeliveryState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SentMessageProperties, SentMessageProperties,
      QAfterFilterCondition> sentMessageDeliveryStateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sentMessageDeliveryState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SentMessageProperties, SentMessageProperties,
          QAfterFilterCondition>
      sentMessageDeliveryStateContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sentMessageDeliveryState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SentMessageProperties, SentMessageProperties,
          QAfterFilterCondition>
      sentMessageDeliveryStateMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sentMessageDeliveryState',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SentMessageProperties, SentMessageProperties,
      QAfterFilterCondition> sentMessageDeliveryStateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sentMessageDeliveryState',
        value: '',
      ));
    });
  }

  QueryBuilder<SentMessageProperties, SentMessageProperties,
      QAfterFilterCondition> sentMessageDeliveryStateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sentMessageDeliveryState',
        value: '',
      ));
    });
  }
}

extension SentMessagePropertiesQueryObject on QueryBuilder<
    SentMessageProperties, SentMessageProperties, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const ReceivedMessagePropertiesSchema = Schema(
  name: r'ReceivedMessageProperties',
  id: 6610116909236088648,
  properties: {
    r'hashCode': PropertySchema(
      id: 0,
      name: r'hashCode',
      type: IsarType.long,
    ),
    r'localReceivedDate': PropertySchema(
      id: 1,
      name: r'localReceivedDate',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _receivedMessagePropertiesEstimateSize,
  serialize: _receivedMessagePropertiesSerialize,
  deserialize: _receivedMessagePropertiesDeserialize,
  deserializeProp: _receivedMessagePropertiesDeserializeProp,
);

int _receivedMessagePropertiesEstimateSize(
  ReceivedMessageProperties object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _receivedMessagePropertiesSerialize(
  ReceivedMessageProperties object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.hashCode);
  writer.writeDateTime(offsets[1], object.localReceivedDate);
}

ReceivedMessageProperties _receivedMessagePropertiesDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ReceivedMessageProperties();
  object.localReceivedDate = reader.readDateTime(offsets[1]);
  return object;
}

P _receivedMessagePropertiesDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ReceivedMessagePropertiesQueryFilter on QueryBuilder<
    ReceivedMessageProperties, ReceivedMessageProperties, QFilterCondition> {
  QueryBuilder<ReceivedMessageProperties, ReceivedMessageProperties,
      QAfterFilterCondition> hashCodeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ReceivedMessageProperties, ReceivedMessageProperties,
      QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ReceivedMessageProperties, ReceivedMessageProperties,
      QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hashCode',
        value: value,
      ));
    });
  }

  QueryBuilder<ReceivedMessageProperties, ReceivedMessageProperties,
      QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hashCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReceivedMessageProperties, ReceivedMessageProperties,
      QAfterFilterCondition> localReceivedDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localReceivedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ReceivedMessageProperties, ReceivedMessageProperties,
      QAfterFilterCondition> localReceivedDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localReceivedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ReceivedMessageProperties, ReceivedMessageProperties,
      QAfterFilterCondition> localReceivedDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localReceivedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ReceivedMessageProperties, ReceivedMessageProperties,
      QAfterFilterCondition> localReceivedDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localReceivedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ReceivedMessagePropertiesQueryObject on QueryBuilder<
    ReceivedMessageProperties, ReceivedMessageProperties, QFilterCondition> {}
