// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserProfilesTableTable extends UserProfilesTable
    with TableInfo<$UserProfilesTableTable, UserProfilesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _preferredLanguageMeta = const VerificationMeta(
    'preferredLanguage',
  );
  @override
  late final GeneratedColumn<String> preferredLanguage =
      GeneratedColumn<String>(
        'preferred_language',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('en'),
      );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fullName,
    phone,
    location,
    preferredLanguage,
    avatarUrl,
    createdAt,
    updatedAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfilesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('preferred_language')) {
      context.handle(
        _preferredLanguageMeta,
        preferredLanguage.isAcceptableOrUnknown(
          data['preferred_language']!,
          _preferredLanguageMeta,
        ),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfilesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfilesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      preferredLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferred_language'],
      )!,
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $UserProfilesTableTable createAlias(String alias) {
    return $UserProfilesTableTable(attachedDatabase, alias);
  }
}

class UserProfilesTableData extends DataClass
    implements Insertable<UserProfilesTableData> {
  final String id;
  final String? fullName;
  final String? phone;
  final String? location;
  final String preferredLanguage;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  const UserProfilesTableData({
    required this.id,
    this.fullName,
    this.phone,
    this.location,
    required this.preferredLanguage,
    this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || fullName != null) {
      map['full_name'] = Variable<String>(fullName);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['preferred_language'] = Variable<String>(preferredLanguage);
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  UserProfilesTableCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesTableCompanion(
      id: Value(id),
      fullName: fullName == null && nullToAbsent
          ? const Value.absent()
          : Value(fullName),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      preferredLanguage: Value(preferredLanguage),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
    );
  }

  factory UserProfilesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfilesTableData(
      id: serializer.fromJson<String>(json['id']),
      fullName: serializer.fromJson<String?>(json['fullName']),
      phone: serializer.fromJson<String?>(json['phone']),
      location: serializer.fromJson<String?>(json['location']),
      preferredLanguage: serializer.fromJson<String>(json['preferredLanguage']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fullName': serializer.toJson<String?>(fullName),
      'phone': serializer.toJson<String?>(phone),
      'location': serializer.toJson<String?>(location),
      'preferredLanguage': serializer.toJson<String>(preferredLanguage),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  UserProfilesTableData copyWith({
    String? id,
    Value<String?> fullName = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> location = const Value.absent(),
    String? preferredLanguage,
    Value<String?> avatarUrl = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
  }) => UserProfilesTableData(
    id: id ?? this.id,
    fullName: fullName.present ? fullName.value : this.fullName,
    phone: phone.present ? phone.value : this.phone,
    location: location.present ? location.value : this.location,
    preferredLanguage: preferredLanguage ?? this.preferredLanguage,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
  );
  UserProfilesTableData copyWithCompanion(UserProfilesTableCompanion data) {
    return UserProfilesTableData(
      id: data.id.present ? data.id.value : this.id,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      phone: data.phone.present ? data.phone.value : this.phone,
      location: data.location.present ? data.location.value : this.location,
      preferredLanguage: data.preferredLanguage.present
          ? data.preferredLanguage.value
          : this.preferredLanguage,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesTableData(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('location: $location, ')
          ..write('preferredLanguage: $preferredLanguage, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fullName,
    phone,
    location,
    preferredLanguage,
    avatarUrl,
    createdAt,
    updatedAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfilesTableData &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.phone == this.phone &&
          other.location == this.location &&
          other.preferredLanguage == this.preferredLanguage &&
          other.avatarUrl == this.avatarUrl &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced);
}

class UserProfilesTableCompanion
    extends UpdateCompanion<UserProfilesTableData> {
  final Value<String> id;
  final Value<String?> fullName;
  final Value<String?> phone;
  final Value<String?> location;
  final Value<String> preferredLanguage;
  final Value<String?> avatarUrl;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const UserProfilesTableCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.phone = const Value.absent(),
    this.location = const Value.absent(),
    this.preferredLanguage = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesTableCompanion.insert({
    required String id,
    this.fullName = const Value.absent(),
    this.phone = const Value.absent(),
    this.location = const Value.absent(),
    this.preferredLanguage = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<UserProfilesTableData> custom({
    Expression<String>? id,
    Expression<String>? fullName,
    Expression<String>? phone,
    Expression<String>? location,
    Expression<String>? preferredLanguage,
    Expression<String>? avatarUrl,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (phone != null) 'phone': phone,
      if (location != null) 'location': location,
      if (preferredLanguage != null) 'preferred_language': preferredLanguage,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesTableCompanion copyWith({
    Value<String>? id,
    Value<String?>? fullName,
    Value<String?>? phone,
    Value<String?>? location,
    Value<String>? preferredLanguage,
    Value<String?>? avatarUrl,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return UserProfilesTableCompanion(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (preferredLanguage.present) {
      map['preferred_language'] = Variable<String>(preferredLanguage.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesTableCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('phone: $phone, ')
          ..write('location: $location, ')
          ..write('preferredLanguage: $preferredLanguage, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VehiclesTableTable extends VehiclesTable
    with TableInfo<$VehiclesTableTable, VehiclesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _makeMeta = const VerificationMeta('make');
  @override
  late final GeneratedColumn<String> make = GeneratedColumn<String>(
    'make',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mileageMeta = const VerificationMeta(
    'mileage',
  );
  @override
  late final GeneratedColumn<int> mileage = GeneratedColumn<int>(
    'mileage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vinMeta = const VerificationMeta('vin');
  @override
  late final GeneratedColumn<String> vin = GeneratedColumn<String>(
    'vin',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fuelTypeMeta = const VerificationMeta(
    'fuelType',
  );
  @override
  late final GeneratedColumn<String> fuelType = GeneratedColumn<String>(
    'fuel_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plateNumberMeta = const VerificationMeta(
    'plateNumber',
  );
  @override
  late final GeneratedColumn<String> plateNumber = GeneratedColumn<String>(
    'plate_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoUrlsMeta = const VerificationMeta(
    'photoUrls',
  );
  @override
  late final GeneratedColumn<String> photoUrls = GeneratedColumn<String>(
    'photo_urls',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPrimaryMeta = const VerificationMeta(
    'isPrimary',
  );
  @override
  late final GeneratedColumn<bool> isPrimary = GeneratedColumn<bool>(
    'is_primary',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_primary" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    make,
    model,
    year,
    mileage,
    vin,
    fuelType,
    plateNumber,
    color,
    photoUrls,
    notes,
    isPrimary,
    createdAt,
    updatedAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles';
  @override
  VerificationContext validateIntegrity(
    Insertable<VehiclesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('make')) {
      context.handle(
        _makeMeta,
        make.isAcceptableOrUnknown(data['make']!, _makeMeta),
      );
    } else if (isInserting) {
      context.missing(_makeMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('mileage')) {
      context.handle(
        _mileageMeta,
        mileage.isAcceptableOrUnknown(data['mileage']!, _mileageMeta),
      );
    } else if (isInserting) {
      context.missing(_mileageMeta);
    }
    if (data.containsKey('vin')) {
      context.handle(
        _vinMeta,
        vin.isAcceptableOrUnknown(data['vin']!, _vinMeta),
      );
    }
    if (data.containsKey('fuel_type')) {
      context.handle(
        _fuelTypeMeta,
        fuelType.isAcceptableOrUnknown(data['fuel_type']!, _fuelTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fuelTypeMeta);
    }
    if (data.containsKey('plate_number')) {
      context.handle(
        _plateNumberMeta,
        plateNumber.isAcceptableOrUnknown(
          data['plate_number']!,
          _plateNumberMeta,
        ),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('photo_urls')) {
      context.handle(
        _photoUrlsMeta,
        photoUrls.isAcceptableOrUnknown(data['photo_urls']!, _photoUrlsMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_primary')) {
      context.handle(
        _isPrimaryMeta,
        isPrimary.isAcceptableOrUnknown(data['is_primary']!, _isPrimaryMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehiclesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehiclesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      make: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}make'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      mileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mileage'],
      )!,
      vin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vin'],
      ),
      fuelType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fuel_type'],
      )!,
      plateNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plate_number'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      photoUrls: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_urls'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isPrimary: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_primary'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $VehiclesTableTable createAlias(String alias) {
    return $VehiclesTableTable(attachedDatabase, alias);
  }
}

class VehiclesTableData extends DataClass
    implements Insertable<VehiclesTableData> {
  final String id;
  final String userId;
  final String make;
  final String model;
  final int year;
  final int mileage;
  final String? vin;
  final String fuelType;
  final String? plateNumber;
  final String? color;
  final String photoUrls;
  final String? notes;
  final bool isPrimary;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  const VehiclesTableData({
    required this.id,
    required this.userId,
    required this.make,
    required this.model,
    required this.year,
    required this.mileage,
    this.vin,
    required this.fuelType,
    this.plateNumber,
    this.color,
    required this.photoUrls,
    this.notes,
    required this.isPrimary,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['make'] = Variable<String>(make);
    map['model'] = Variable<String>(model);
    map['year'] = Variable<int>(year);
    map['mileage'] = Variable<int>(mileage);
    if (!nullToAbsent || vin != null) {
      map['vin'] = Variable<String>(vin);
    }
    map['fuel_type'] = Variable<String>(fuelType);
    if (!nullToAbsent || plateNumber != null) {
      map['plate_number'] = Variable<String>(plateNumber);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['photo_urls'] = Variable<String>(photoUrls);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_primary'] = Variable<bool>(isPrimary);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  VehiclesTableCompanion toCompanion(bool nullToAbsent) {
    return VehiclesTableCompanion(
      id: Value(id),
      userId: Value(userId),
      make: Value(make),
      model: Value(model),
      year: Value(year),
      mileage: Value(mileage),
      vin: vin == null && nullToAbsent ? const Value.absent() : Value(vin),
      fuelType: Value(fuelType),
      plateNumber: plateNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(plateNumber),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      photoUrls: Value(photoUrls),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isPrimary: Value(isPrimary),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
    );
  }

  factory VehiclesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehiclesTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      make: serializer.fromJson<String>(json['make']),
      model: serializer.fromJson<String>(json['model']),
      year: serializer.fromJson<int>(json['year']),
      mileage: serializer.fromJson<int>(json['mileage']),
      vin: serializer.fromJson<String?>(json['vin']),
      fuelType: serializer.fromJson<String>(json['fuelType']),
      plateNumber: serializer.fromJson<String?>(json['plateNumber']),
      color: serializer.fromJson<String?>(json['color']),
      photoUrls: serializer.fromJson<String>(json['photoUrls']),
      notes: serializer.fromJson<String?>(json['notes']),
      isPrimary: serializer.fromJson<bool>(json['isPrimary']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'make': serializer.toJson<String>(make),
      'model': serializer.toJson<String>(model),
      'year': serializer.toJson<int>(year),
      'mileage': serializer.toJson<int>(mileage),
      'vin': serializer.toJson<String?>(vin),
      'fuelType': serializer.toJson<String>(fuelType),
      'plateNumber': serializer.toJson<String?>(plateNumber),
      'color': serializer.toJson<String?>(color),
      'photoUrls': serializer.toJson<String>(photoUrls),
      'notes': serializer.toJson<String?>(notes),
      'isPrimary': serializer.toJson<bool>(isPrimary),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  VehiclesTableData copyWith({
    String? id,
    String? userId,
    String? make,
    String? model,
    int? year,
    int? mileage,
    Value<String?> vin = const Value.absent(),
    String? fuelType,
    Value<String?> plateNumber = const Value.absent(),
    Value<String?> color = const Value.absent(),
    String? photoUrls,
    Value<String?> notes = const Value.absent(),
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
  }) => VehiclesTableData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    make: make ?? this.make,
    model: model ?? this.model,
    year: year ?? this.year,
    mileage: mileage ?? this.mileage,
    vin: vin.present ? vin.value : this.vin,
    fuelType: fuelType ?? this.fuelType,
    plateNumber: plateNumber.present ? plateNumber.value : this.plateNumber,
    color: color.present ? color.value : this.color,
    photoUrls: photoUrls ?? this.photoUrls,
    notes: notes.present ? notes.value : this.notes,
    isPrimary: isPrimary ?? this.isPrimary,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
  );
  VehiclesTableData copyWithCompanion(VehiclesTableCompanion data) {
    return VehiclesTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      make: data.make.present ? data.make.value : this.make,
      model: data.model.present ? data.model.value : this.model,
      year: data.year.present ? data.year.value : this.year,
      mileage: data.mileage.present ? data.mileage.value : this.mileage,
      vin: data.vin.present ? data.vin.value : this.vin,
      fuelType: data.fuelType.present ? data.fuelType.value : this.fuelType,
      plateNumber: data.plateNumber.present
          ? data.plateNumber.value
          : this.plateNumber,
      color: data.color.present ? data.color.value : this.color,
      photoUrls: data.photoUrls.present ? data.photoUrls.value : this.photoUrls,
      notes: data.notes.present ? data.notes.value : this.notes,
      isPrimary: data.isPrimary.present ? data.isPrimary.value : this.isPrimary,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('mileage: $mileage, ')
          ..write('vin: $vin, ')
          ..write('fuelType: $fuelType, ')
          ..write('plateNumber: $plateNumber, ')
          ..write('color: $color, ')
          ..write('photoUrls: $photoUrls, ')
          ..write('notes: $notes, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    make,
    model,
    year,
    mileage,
    vin,
    fuelType,
    plateNumber,
    color,
    photoUrls,
    notes,
    isPrimary,
    createdAt,
    updatedAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehiclesTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.make == this.make &&
          other.model == this.model &&
          other.year == this.year &&
          other.mileage == this.mileage &&
          other.vin == this.vin &&
          other.fuelType == this.fuelType &&
          other.plateNumber == this.plateNumber &&
          other.color == this.color &&
          other.photoUrls == this.photoUrls &&
          other.notes == this.notes &&
          other.isPrimary == this.isPrimary &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced);
}

class VehiclesTableCompanion extends UpdateCompanion<VehiclesTableData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> make;
  final Value<String> model;
  final Value<int> year;
  final Value<int> mileage;
  final Value<String?> vin;
  final Value<String> fuelType;
  final Value<String?> plateNumber;
  final Value<String?> color;
  final Value<String> photoUrls;
  final Value<String?> notes;
  final Value<bool> isPrimary;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const VehiclesTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.make = const Value.absent(),
    this.model = const Value.absent(),
    this.year = const Value.absent(),
    this.mileage = const Value.absent(),
    this.vin = const Value.absent(),
    this.fuelType = const Value.absent(),
    this.plateNumber = const Value.absent(),
    this.color = const Value.absent(),
    this.photoUrls = const Value.absent(),
    this.notes = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehiclesTableCompanion.insert({
    required String id,
    required String userId,
    required String make,
    required String model,
    required int year,
    required int mileage,
    this.vin = const Value.absent(),
    required String fuelType,
    this.plateNumber = const Value.absent(),
    this.color = const Value.absent(),
    this.photoUrls = const Value.absent(),
    this.notes = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       make = Value(make),
       model = Value(model),
       year = Value(year),
       mileage = Value(mileage),
       fuelType = Value(fuelType);
  static Insertable<VehiclesTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? make,
    Expression<String>? model,
    Expression<int>? year,
    Expression<int>? mileage,
    Expression<String>? vin,
    Expression<String>? fuelType,
    Expression<String>? plateNumber,
    Expression<String>? color,
    Expression<String>? photoUrls,
    Expression<String>? notes,
    Expression<bool>? isPrimary,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (make != null) 'make': make,
      if (model != null) 'model': model,
      if (year != null) 'year': year,
      if (mileage != null) 'mileage': mileage,
      if (vin != null) 'vin': vin,
      if (fuelType != null) 'fuel_type': fuelType,
      if (plateNumber != null) 'plate_number': plateNumber,
      if (color != null) 'color': color,
      if (photoUrls != null) 'photo_urls': photoUrls,
      if (notes != null) 'notes': notes,
      if (isPrimary != null) 'is_primary': isPrimary,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehiclesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? make,
    Value<String>? model,
    Value<int>? year,
    Value<int>? mileage,
    Value<String?>? vin,
    Value<String>? fuelType,
    Value<String?>? plateNumber,
    Value<String?>? color,
    Value<String>? photoUrls,
    Value<String?>? notes,
    Value<bool>? isPrimary,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return VehiclesTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      mileage: mileage ?? this.mileage,
      vin: vin ?? this.vin,
      fuelType: fuelType ?? this.fuelType,
      plateNumber: plateNumber ?? this.plateNumber,
      color: color ?? this.color,
      photoUrls: photoUrls ?? this.photoUrls,
      notes: notes ?? this.notes,
      isPrimary: isPrimary ?? this.isPrimary,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (make.present) {
      map['make'] = Variable<String>(make.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (mileage.present) {
      map['mileage'] = Variable<int>(mileage.value);
    }
    if (vin.present) {
      map['vin'] = Variable<String>(vin.value);
    }
    if (fuelType.present) {
      map['fuel_type'] = Variable<String>(fuelType.value);
    }
    if (plateNumber.present) {
      map['plate_number'] = Variable<String>(plateNumber.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (photoUrls.present) {
      map['photo_urls'] = Variable<String>(photoUrls.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isPrimary.present) {
      map['is_primary'] = Variable<bool>(isPrimary.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('mileage: $mileage, ')
          ..write('vin: $vin, ')
          ..write('fuelType: $fuelType, ')
          ..write('plateNumber: $plateNumber, ')
          ..write('color: $color, ')
          ..write('photoUrls: $photoUrls, ')
          ..write('notes: $notes, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MaintenanceRecordsTableTable extends MaintenanceRecordsTable
    with TableInfo<$MaintenanceRecordsTableTable, MaintenanceRecordsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceRecordsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceTypeMeta = const VerificationMeta(
    'serviceType',
  );
  @override
  late final GeneratedColumn<String> serviceType = GeneratedColumn<String>(
    'service_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mileageAtServiceMeta = const VerificationMeta(
    'mileageAtService',
  );
  @override
  late final GeneratedColumn<int> mileageAtService = GeneratedColumn<int>(
    'mileage_at_service',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
    'cost',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _serviceDateMeta = const VerificationMeta(
    'serviceDate',
  );
  @override
  late final GeneratedColumn<DateTime> serviceDate = GeneratedColumn<DateTime>(
    'service_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _garageIdMeta = const VerificationMeta(
    'garageId',
  );
  @override
  late final GeneratedColumn<String> garageId = GeneratedColumn<String>(
    'garage_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextServiceDateMeta = const VerificationMeta(
    'nextServiceDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextServiceDate =
      GeneratedColumn<DateTime>(
        'next_service_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nextServiceMileageMeta =
      const VerificationMeta('nextServiceMileage');
  @override
  late final GeneratedColumn<int> nextServiceMileage = GeneratedColumn<int>(
    'next_service_mileage',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoUrlsMeta = const VerificationMeta(
    'photoUrls',
  );
  @override
  late final GeneratedColumn<String> photoUrls = GeneratedColumn<String>(
    'photo_urls',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    serviceType,
    title,
    mileageAtService,
    cost,
    serviceDate,
    garageId,
    nextServiceDate,
    nextServiceMileage,
    notes,
    photoUrls,
    createdAt,
    updatedAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaintenanceRecordsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('service_type')) {
      context.handle(
        _serviceTypeMeta,
        serviceType.isAcceptableOrUnknown(
          data['service_type']!,
          _serviceTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serviceTypeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('mileage_at_service')) {
      context.handle(
        _mileageAtServiceMeta,
        mileageAtService.isAcceptableOrUnknown(
          data['mileage_at_service']!,
          _mileageAtServiceMeta,
        ),
      );
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    }
    if (data.containsKey('service_date')) {
      context.handle(
        _serviceDateMeta,
        serviceDate.isAcceptableOrUnknown(
          data['service_date']!,
          _serviceDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serviceDateMeta);
    }
    if (data.containsKey('garage_id')) {
      context.handle(
        _garageIdMeta,
        garageId.isAcceptableOrUnknown(data['garage_id']!, _garageIdMeta),
      );
    }
    if (data.containsKey('next_service_date')) {
      context.handle(
        _nextServiceDateMeta,
        nextServiceDate.isAcceptableOrUnknown(
          data['next_service_date']!,
          _nextServiceDateMeta,
        ),
      );
    }
    if (data.containsKey('next_service_mileage')) {
      context.handle(
        _nextServiceMileageMeta,
        nextServiceMileage.isAcceptableOrUnknown(
          data['next_service_mileage']!,
          _nextServiceMileageMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('photo_urls')) {
      context.handle(
        _photoUrlsMeta,
        photoUrls.isAcceptableOrUnknown(data['photo_urls']!, _photoUrlsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaintenanceRecordsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceRecordsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      serviceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      mileageAtService: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mileage_at_service'],
      ),
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost'],
      ),
      serviceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}service_date'],
      )!,
      garageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}garage_id'],
      ),
      nextServiceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_service_date'],
      ),
      nextServiceMileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_service_mileage'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      photoUrls: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_urls'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $MaintenanceRecordsTableTable createAlias(String alias) {
    return $MaintenanceRecordsTableTable(attachedDatabase, alias);
  }
}

class MaintenanceRecordsTableData extends DataClass
    implements Insertable<MaintenanceRecordsTableData> {
  final String id;
  final String vehicleId;
  final String serviceType;
  final String title;
  final int? mileageAtService;
  final double? cost;
  final DateTime serviceDate;
  final String? garageId;
  final DateTime? nextServiceDate;
  final int? nextServiceMileage;
  final String? notes;
  final String photoUrls;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  const MaintenanceRecordsTableData({
    required this.id,
    required this.vehicleId,
    required this.serviceType,
    required this.title,
    this.mileageAtService,
    this.cost,
    required this.serviceDate,
    this.garageId,
    this.nextServiceDate,
    this.nextServiceMileage,
    this.notes,
    required this.photoUrls,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['service_type'] = Variable<String>(serviceType);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || mileageAtService != null) {
      map['mileage_at_service'] = Variable<int>(mileageAtService);
    }
    if (!nullToAbsent || cost != null) {
      map['cost'] = Variable<double>(cost);
    }
    map['service_date'] = Variable<DateTime>(serviceDate);
    if (!nullToAbsent || garageId != null) {
      map['garage_id'] = Variable<String>(garageId);
    }
    if (!nullToAbsent || nextServiceDate != null) {
      map['next_service_date'] = Variable<DateTime>(nextServiceDate);
    }
    if (!nullToAbsent || nextServiceMileage != null) {
      map['next_service_mileage'] = Variable<int>(nextServiceMileage);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['photo_urls'] = Variable<String>(photoUrls);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  MaintenanceRecordsTableCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceRecordsTableCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      serviceType: Value(serviceType),
      title: Value(title),
      mileageAtService: mileageAtService == null && nullToAbsent
          ? const Value.absent()
          : Value(mileageAtService),
      cost: cost == null && nullToAbsent ? const Value.absent() : Value(cost),
      serviceDate: Value(serviceDate),
      garageId: garageId == null && nullToAbsent
          ? const Value.absent()
          : Value(garageId),
      nextServiceDate: nextServiceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextServiceDate),
      nextServiceMileage: nextServiceMileage == null && nullToAbsent
          ? const Value.absent()
          : Value(nextServiceMileage),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      photoUrls: Value(photoUrls),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
    );
  }

  factory MaintenanceRecordsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceRecordsTableData(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      serviceType: serializer.fromJson<String>(json['serviceType']),
      title: serializer.fromJson<String>(json['title']),
      mileageAtService: serializer.fromJson<int?>(json['mileageAtService']),
      cost: serializer.fromJson<double?>(json['cost']),
      serviceDate: serializer.fromJson<DateTime>(json['serviceDate']),
      garageId: serializer.fromJson<String?>(json['garageId']),
      nextServiceDate: serializer.fromJson<DateTime?>(json['nextServiceDate']),
      nextServiceMileage: serializer.fromJson<int?>(json['nextServiceMileage']),
      notes: serializer.fromJson<String?>(json['notes']),
      photoUrls: serializer.fromJson<String>(json['photoUrls']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'serviceType': serializer.toJson<String>(serviceType),
      'title': serializer.toJson<String>(title),
      'mileageAtService': serializer.toJson<int?>(mileageAtService),
      'cost': serializer.toJson<double?>(cost),
      'serviceDate': serializer.toJson<DateTime>(serviceDate),
      'garageId': serializer.toJson<String?>(garageId),
      'nextServiceDate': serializer.toJson<DateTime?>(nextServiceDate),
      'nextServiceMileage': serializer.toJson<int?>(nextServiceMileage),
      'notes': serializer.toJson<String?>(notes),
      'photoUrls': serializer.toJson<String>(photoUrls),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  MaintenanceRecordsTableData copyWith({
    String? id,
    String? vehicleId,
    String? serviceType,
    String? title,
    Value<int?> mileageAtService = const Value.absent(),
    Value<double?> cost = const Value.absent(),
    DateTime? serviceDate,
    Value<String?> garageId = const Value.absent(),
    Value<DateTime?> nextServiceDate = const Value.absent(),
    Value<int?> nextServiceMileage = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? photoUrls,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
  }) => MaintenanceRecordsTableData(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    serviceType: serviceType ?? this.serviceType,
    title: title ?? this.title,
    mileageAtService: mileageAtService.present
        ? mileageAtService.value
        : this.mileageAtService,
    cost: cost.present ? cost.value : this.cost,
    serviceDate: serviceDate ?? this.serviceDate,
    garageId: garageId.present ? garageId.value : this.garageId,
    nextServiceDate: nextServiceDate.present
        ? nextServiceDate.value
        : this.nextServiceDate,
    nextServiceMileage: nextServiceMileage.present
        ? nextServiceMileage.value
        : this.nextServiceMileage,
    notes: notes.present ? notes.value : this.notes,
    photoUrls: photoUrls ?? this.photoUrls,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
  );
  MaintenanceRecordsTableData copyWithCompanion(
    MaintenanceRecordsTableCompanion data,
  ) {
    return MaintenanceRecordsTableData(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      serviceType: data.serviceType.present
          ? data.serviceType.value
          : this.serviceType,
      title: data.title.present ? data.title.value : this.title,
      mileageAtService: data.mileageAtService.present
          ? data.mileageAtService.value
          : this.mileageAtService,
      cost: data.cost.present ? data.cost.value : this.cost,
      serviceDate: data.serviceDate.present
          ? data.serviceDate.value
          : this.serviceDate,
      garageId: data.garageId.present ? data.garageId.value : this.garageId,
      nextServiceDate: data.nextServiceDate.present
          ? data.nextServiceDate.value
          : this.nextServiceDate,
      nextServiceMileage: data.nextServiceMileage.present
          ? data.nextServiceMileage.value
          : this.nextServiceMileage,
      notes: data.notes.present ? data.notes.value : this.notes,
      photoUrls: data.photoUrls.present ? data.photoUrls.value : this.photoUrls,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceRecordsTableData(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('serviceType: $serviceType, ')
          ..write('title: $title, ')
          ..write('mileageAtService: $mileageAtService, ')
          ..write('cost: $cost, ')
          ..write('serviceDate: $serviceDate, ')
          ..write('garageId: $garageId, ')
          ..write('nextServiceDate: $nextServiceDate, ')
          ..write('nextServiceMileage: $nextServiceMileage, ')
          ..write('notes: $notes, ')
          ..write('photoUrls: $photoUrls, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    serviceType,
    title,
    mileageAtService,
    cost,
    serviceDate,
    garageId,
    nextServiceDate,
    nextServiceMileage,
    notes,
    photoUrls,
    createdAt,
    updatedAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceRecordsTableData &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.serviceType == this.serviceType &&
          other.title == this.title &&
          other.mileageAtService == this.mileageAtService &&
          other.cost == this.cost &&
          other.serviceDate == this.serviceDate &&
          other.garageId == this.garageId &&
          other.nextServiceDate == this.nextServiceDate &&
          other.nextServiceMileage == this.nextServiceMileage &&
          other.notes == this.notes &&
          other.photoUrls == this.photoUrls &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced);
}

class MaintenanceRecordsTableCompanion
    extends UpdateCompanion<MaintenanceRecordsTableData> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<String> serviceType;
  final Value<String> title;
  final Value<int?> mileageAtService;
  final Value<double?> cost;
  final Value<DateTime> serviceDate;
  final Value<String?> garageId;
  final Value<DateTime?> nextServiceDate;
  final Value<int?> nextServiceMileage;
  final Value<String?> notes;
  final Value<String> photoUrls;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const MaintenanceRecordsTableCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.serviceType = const Value.absent(),
    this.title = const Value.absent(),
    this.mileageAtService = const Value.absent(),
    this.cost = const Value.absent(),
    this.serviceDate = const Value.absent(),
    this.garageId = const Value.absent(),
    this.nextServiceDate = const Value.absent(),
    this.nextServiceMileage = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoUrls = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MaintenanceRecordsTableCompanion.insert({
    required String id,
    required String vehicleId,
    required String serviceType,
    required String title,
    this.mileageAtService = const Value.absent(),
    this.cost = const Value.absent(),
    required DateTime serviceDate,
    this.garageId = const Value.absent(),
    this.nextServiceDate = const Value.absent(),
    this.nextServiceMileage = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoUrls = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       serviceType = Value(serviceType),
       title = Value(title),
       serviceDate = Value(serviceDate);
  static Insertable<MaintenanceRecordsTableData> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<String>? serviceType,
    Expression<String>? title,
    Expression<int>? mileageAtService,
    Expression<double>? cost,
    Expression<DateTime>? serviceDate,
    Expression<String>? garageId,
    Expression<DateTime>? nextServiceDate,
    Expression<int>? nextServiceMileage,
    Expression<String>? notes,
    Expression<String>? photoUrls,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (serviceType != null) 'service_type': serviceType,
      if (title != null) 'title': title,
      if (mileageAtService != null) 'mileage_at_service': mileageAtService,
      if (cost != null) 'cost': cost,
      if (serviceDate != null) 'service_date': serviceDate,
      if (garageId != null) 'garage_id': garageId,
      if (nextServiceDate != null) 'next_service_date': nextServiceDate,
      if (nextServiceMileage != null)
        'next_service_mileage': nextServiceMileage,
      if (notes != null) 'notes': notes,
      if (photoUrls != null) 'photo_urls': photoUrls,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MaintenanceRecordsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<String>? serviceType,
    Value<String>? title,
    Value<int?>? mileageAtService,
    Value<double?>? cost,
    Value<DateTime>? serviceDate,
    Value<String?>? garageId,
    Value<DateTime?>? nextServiceDate,
    Value<int?>? nextServiceMileage,
    Value<String?>? notes,
    Value<String>? photoUrls,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return MaintenanceRecordsTableCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      serviceType: serviceType ?? this.serviceType,
      title: title ?? this.title,
      mileageAtService: mileageAtService ?? this.mileageAtService,
      cost: cost ?? this.cost,
      serviceDate: serviceDate ?? this.serviceDate,
      garageId: garageId ?? this.garageId,
      nextServiceDate: nextServiceDate ?? this.nextServiceDate,
      nextServiceMileage: nextServiceMileage ?? this.nextServiceMileage,
      notes: notes ?? this.notes,
      photoUrls: photoUrls ?? this.photoUrls,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (serviceType.present) {
      map['service_type'] = Variable<String>(serviceType.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (mileageAtService.present) {
      map['mileage_at_service'] = Variable<int>(mileageAtService.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (serviceDate.present) {
      map['service_date'] = Variable<DateTime>(serviceDate.value);
    }
    if (garageId.present) {
      map['garage_id'] = Variable<String>(garageId.value);
    }
    if (nextServiceDate.present) {
      map['next_service_date'] = Variable<DateTime>(nextServiceDate.value);
    }
    if (nextServiceMileage.present) {
      map['next_service_mileage'] = Variable<int>(nextServiceMileage.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoUrls.present) {
      map['photo_urls'] = Variable<String>(photoUrls.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceRecordsTableCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('serviceType: $serviceType, ')
          ..write('title: $title, ')
          ..write('mileageAtService: $mileageAtService, ')
          ..write('cost: $cost, ')
          ..write('serviceDate: $serviceDate, ')
          ..write('garageId: $garageId, ')
          ..write('nextServiceDate: $nextServiceDate, ')
          ..write('nextServiceMileage: $nextServiceMileage, ')
          ..write('notes: $notes, ')
          ..write('photoUrls: $photoUrls, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GaragesTableTable extends GaragesTable
    with TableInfo<$GaragesTableTable, GaragesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GaragesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double> lng = GeneratedColumn<double>(
    'lng',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoUrlsMeta = const VerificationMeta(
    'photoUrls',
  );
  @override
  late final GeneratedColumn<String> photoUrls = GeneratedColumn<String>(
    'photo_urls',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _averageRatingMeta = const VerificationMeta(
    'averageRating',
  );
  @override
  late final GeneratedColumn<double> averageRating = GeneratedColumn<double>(
    'average_rating',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _totalReviewsMeta = const VerificationMeta(
    'totalReviews',
  );
  @override
  late final GeneratedColumn<int> totalReviews = GeneratedColumn<int>(
    'total_reviews',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isVerifiedMeta = const VerificationMeta(
    'isVerified',
  );
  @override
  late final GeneratedColumn<bool> isVerified = GeneratedColumn<bool>(
    'is_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_verified" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _workingHoursMeta = const VerificationMeta(
    'workingHours',
  );
  @override
  late final GeneratedColumn<String> workingHours = GeneratedColumn<String>(
    'working_hours',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    address,
    city,
    lat,
    lng,
    phone,
    photoUrls,
    averageRating,
    totalReviews,
    isVerified,
    workingHours,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'garages';
  @override
  VerificationContext validateIntegrity(
    Insertable<GaragesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    }
    if (data.containsKey('lng')) {
      context.handle(
        _lngMeta,
        lng.isAcceptableOrUnknown(data['lng']!, _lngMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('photo_urls')) {
      context.handle(
        _photoUrlsMeta,
        photoUrls.isAcceptableOrUnknown(data['photo_urls']!, _photoUrlsMeta),
      );
    }
    if (data.containsKey('average_rating')) {
      context.handle(
        _averageRatingMeta,
        averageRating.isAcceptableOrUnknown(
          data['average_rating']!,
          _averageRatingMeta,
        ),
      );
    }
    if (data.containsKey('total_reviews')) {
      context.handle(
        _totalReviewsMeta,
        totalReviews.isAcceptableOrUnknown(
          data['total_reviews']!,
          _totalReviewsMeta,
        ),
      );
    }
    if (data.containsKey('is_verified')) {
      context.handle(
        _isVerifiedMeta,
        isVerified.isAcceptableOrUnknown(data['is_verified']!, _isVerifiedMeta),
      );
    }
    if (data.containsKey('working_hours')) {
      context.handle(
        _workingHoursMeta,
        workingHours.isAcceptableOrUnknown(
          data['working_hours']!,
          _workingHoursMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GaragesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GaragesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      ),
      lng: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lng'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      photoUrls: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_urls'],
      )!,
      averageRating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}average_rating'],
      )!,
      totalReviews: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_reviews'],
      )!,
      isVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_verified'],
      )!,
      workingHours: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}working_hours'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $GaragesTableTable createAlias(String alias) {
    return $GaragesTableTable(attachedDatabase, alias);
  }
}

class GaragesTableData extends DataClass
    implements Insertable<GaragesTableData> {
  final String id;
  final String name;
  final String address;
  final String city;
  final double? lat;
  final double? lng;
  final String? phone;
  final String photoUrls;
  final double averageRating;
  final int totalReviews;
  final bool isVerified;
  final String workingHours;
  final DateTime createdAt;
  final DateTime updatedAt;
  const GaragesTableData({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    this.lat,
    this.lng,
    this.phone,
    required this.photoUrls,
    required this.averageRating,
    required this.totalReviews,
    required this.isVerified,
    required this.workingHours,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['city'] = Variable<String>(city);
    if (!nullToAbsent || lat != null) {
      map['lat'] = Variable<double>(lat);
    }
    if (!nullToAbsent || lng != null) {
      map['lng'] = Variable<double>(lng);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['photo_urls'] = Variable<String>(photoUrls);
    map['average_rating'] = Variable<double>(averageRating);
    map['total_reviews'] = Variable<int>(totalReviews);
    map['is_verified'] = Variable<bool>(isVerified);
    map['working_hours'] = Variable<String>(workingHours);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GaragesTableCompanion toCompanion(bool nullToAbsent) {
    return GaragesTableCompanion(
      id: Value(id),
      name: Value(name),
      address: Value(address),
      city: Value(city),
      lat: lat == null && nullToAbsent ? const Value.absent() : Value(lat),
      lng: lng == null && nullToAbsent ? const Value.absent() : Value(lng),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      photoUrls: Value(photoUrls),
      averageRating: Value(averageRating),
      totalReviews: Value(totalReviews),
      isVerified: Value(isVerified),
      workingHours: Value(workingHours),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory GaragesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GaragesTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      city: serializer.fromJson<String>(json['city']),
      lat: serializer.fromJson<double?>(json['lat']),
      lng: serializer.fromJson<double?>(json['lng']),
      phone: serializer.fromJson<String?>(json['phone']),
      photoUrls: serializer.fromJson<String>(json['photoUrls']),
      averageRating: serializer.fromJson<double>(json['averageRating']),
      totalReviews: serializer.fromJson<int>(json['totalReviews']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
      workingHours: serializer.fromJson<String>(json['workingHours']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'city': serializer.toJson<String>(city),
      'lat': serializer.toJson<double?>(lat),
      'lng': serializer.toJson<double?>(lng),
      'phone': serializer.toJson<String?>(phone),
      'photoUrls': serializer.toJson<String>(photoUrls),
      'averageRating': serializer.toJson<double>(averageRating),
      'totalReviews': serializer.toJson<int>(totalReviews),
      'isVerified': serializer.toJson<bool>(isVerified),
      'workingHours': serializer.toJson<String>(workingHours),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GaragesTableData copyWith({
    String? id,
    String? name,
    String? address,
    String? city,
    Value<double?> lat = const Value.absent(),
    Value<double?> lng = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    String? photoUrls,
    double? averageRating,
    int? totalReviews,
    bool? isVerified,
    String? workingHours,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => GaragesTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address ?? this.address,
    city: city ?? this.city,
    lat: lat.present ? lat.value : this.lat,
    lng: lng.present ? lng.value : this.lng,
    phone: phone.present ? phone.value : this.phone,
    photoUrls: photoUrls ?? this.photoUrls,
    averageRating: averageRating ?? this.averageRating,
    totalReviews: totalReviews ?? this.totalReviews,
    isVerified: isVerified ?? this.isVerified,
    workingHours: workingHours ?? this.workingHours,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  GaragesTableData copyWithCompanion(GaragesTableCompanion data) {
    return GaragesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      city: data.city.present ? data.city.value : this.city,
      lat: data.lat.present ? data.lat.value : this.lat,
      lng: data.lng.present ? data.lng.value : this.lng,
      phone: data.phone.present ? data.phone.value : this.phone,
      photoUrls: data.photoUrls.present ? data.photoUrls.value : this.photoUrls,
      averageRating: data.averageRating.present
          ? data.averageRating.value
          : this.averageRating,
      totalReviews: data.totalReviews.present
          ? data.totalReviews.value
          : this.totalReviews,
      isVerified: data.isVerified.present
          ? data.isVerified.value
          : this.isVerified,
      workingHours: data.workingHours.present
          ? data.workingHours.value
          : this.workingHours,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GaragesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('phone: $phone, ')
          ..write('photoUrls: $photoUrls, ')
          ..write('averageRating: $averageRating, ')
          ..write('totalReviews: $totalReviews, ')
          ..write('isVerified: $isVerified, ')
          ..write('workingHours: $workingHours, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    address,
    city,
    lat,
    lng,
    phone,
    photoUrls,
    averageRating,
    totalReviews,
    isVerified,
    workingHours,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GaragesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.city == this.city &&
          other.lat == this.lat &&
          other.lng == this.lng &&
          other.phone == this.phone &&
          other.photoUrls == this.photoUrls &&
          other.averageRating == this.averageRating &&
          other.totalReviews == this.totalReviews &&
          other.isVerified == this.isVerified &&
          other.workingHours == this.workingHours &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GaragesTableCompanion extends UpdateCompanion<GaragesTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> address;
  final Value<String> city;
  final Value<double?> lat;
  final Value<double?> lng;
  final Value<String?> phone;
  final Value<String> photoUrls;
  final Value<double> averageRating;
  final Value<int> totalReviews;
  final Value<bool> isVerified;
  final Value<String> workingHours;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const GaragesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.phone = const Value.absent(),
    this.photoUrls = const Value.absent(),
    this.averageRating = const Value.absent(),
    this.totalReviews = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.workingHours = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GaragesTableCompanion.insert({
    required String id,
    required String name,
    required String address,
    required String city,
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.phone = const Value.absent(),
    this.photoUrls = const Value.absent(),
    this.averageRating = const Value.absent(),
    this.totalReviews = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.workingHours = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       address = Value(address),
       city = Value(city);
  static Insertable<GaragesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? city,
    Expression<double>? lat,
    Expression<double>? lng,
    Expression<String>? phone,
    Expression<String>? photoUrls,
    Expression<double>? averageRating,
    Expression<int>? totalReviews,
    Expression<bool>? isVerified,
    Expression<String>? workingHours,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (phone != null) 'phone': phone,
      if (photoUrls != null) 'photo_urls': photoUrls,
      if (averageRating != null) 'average_rating': averageRating,
      if (totalReviews != null) 'total_reviews': totalReviews,
      if (isVerified != null) 'is_verified': isVerified,
      if (workingHours != null) 'working_hours': workingHours,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GaragesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? address,
    Value<String>? city,
    Value<double?>? lat,
    Value<double?>? lng,
    Value<String?>? phone,
    Value<String>? photoUrls,
    Value<double>? averageRating,
    Value<int>? totalReviews,
    Value<bool>? isVerified,
    Value<String>? workingHours,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return GaragesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      city: city ?? this.city,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      phone: phone ?? this.phone,
      photoUrls: photoUrls ?? this.photoUrls,
      averageRating: averageRating ?? this.averageRating,
      totalReviews: totalReviews ?? this.totalReviews,
      isVerified: isVerified ?? this.isVerified,
      workingHours: workingHours ?? this.workingHours,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (photoUrls.present) {
      map['photo_urls'] = Variable<String>(photoUrls.value);
    }
    if (averageRating.present) {
      map['average_rating'] = Variable<double>(averageRating.value);
    }
    if (totalReviews.present) {
      map['total_reviews'] = Variable<int>(totalReviews.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
    }
    if (workingHours.present) {
      map['working_hours'] = Variable<String>(workingHours.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GaragesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('phone: $phone, ')
          ..write('photoUrls: $photoUrls, ')
          ..write('averageRating: $averageRating, ')
          ..write('totalReviews: $totalReviews, ')
          ..write('isVerified: $isVerified, ')
          ..write('workingHours: $workingHours, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GarageServicesTableTable extends GarageServicesTable
    with TableInfo<$GarageServicesTableTable, GarageServicesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GarageServicesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _garageIdMeta = const VerificationMeta(
    'garageId',
  );
  @override
  late final GeneratedColumn<String> garageId = GeneratedColumn<String>(
    'garage_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceCategoryIdMeta = const VerificationMeta(
    'serviceCategoryId',
  );
  @override
  late final GeneratedColumn<String> serviceCategoryId =
      GeneratedColumn<String>(
        'service_category_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _priceMinMeta = const VerificationMeta(
    'priceMin',
  );
  @override
  late final GeneratedColumn<double> priceMin = GeneratedColumn<double>(
    'price_min',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceMaxMeta = const VerificationMeta(
    'priceMax',
  );
  @override
  late final GeneratedColumn<double> priceMax = GeneratedColumn<double>(
    'price_max',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedDurationMeta = const VerificationMeta(
    'estimatedDuration',
  );
  @override
  late final GeneratedColumn<int> estimatedDuration = GeneratedColumn<int>(
    'estimated_duration',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    garageId,
    serviceCategoryId,
    priceMin,
    priceMax,
    estimatedDuration,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'garage_services';
  @override
  VerificationContext validateIntegrity(
    Insertable<GarageServicesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('garage_id')) {
      context.handle(
        _garageIdMeta,
        garageId.isAcceptableOrUnknown(data['garage_id']!, _garageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_garageIdMeta);
    }
    if (data.containsKey('service_category_id')) {
      context.handle(
        _serviceCategoryIdMeta,
        serviceCategoryId.isAcceptableOrUnknown(
          data['service_category_id']!,
          _serviceCategoryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serviceCategoryIdMeta);
    }
    if (data.containsKey('price_min')) {
      context.handle(
        _priceMinMeta,
        priceMin.isAcceptableOrUnknown(data['price_min']!, _priceMinMeta),
      );
    }
    if (data.containsKey('price_max')) {
      context.handle(
        _priceMaxMeta,
        priceMax.isAcceptableOrUnknown(data['price_max']!, _priceMaxMeta),
      );
    }
    if (data.containsKey('estimated_duration')) {
      context.handle(
        _estimatedDurationMeta,
        estimatedDuration.isAcceptableOrUnknown(
          data['estimated_duration']!,
          _estimatedDurationMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GarageServicesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GarageServicesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      garageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}garage_id'],
      )!,
      serviceCategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_category_id'],
      )!,
      priceMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_min'],
      ),
      priceMax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_max'],
      ),
      estimatedDuration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_duration'],
      ),
    );
  }

  @override
  $GarageServicesTableTable createAlias(String alias) {
    return $GarageServicesTableTable(attachedDatabase, alias);
  }
}

class GarageServicesTableData extends DataClass
    implements Insertable<GarageServicesTableData> {
  final String id;
  final String garageId;
  final String serviceCategoryId;
  final double? priceMin;
  final double? priceMax;
  final int? estimatedDuration;
  const GarageServicesTableData({
    required this.id,
    required this.garageId,
    required this.serviceCategoryId,
    this.priceMin,
    this.priceMax,
    this.estimatedDuration,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['garage_id'] = Variable<String>(garageId);
    map['service_category_id'] = Variable<String>(serviceCategoryId);
    if (!nullToAbsent || priceMin != null) {
      map['price_min'] = Variable<double>(priceMin);
    }
    if (!nullToAbsent || priceMax != null) {
      map['price_max'] = Variable<double>(priceMax);
    }
    if (!nullToAbsent || estimatedDuration != null) {
      map['estimated_duration'] = Variable<int>(estimatedDuration);
    }
    return map;
  }

  GarageServicesTableCompanion toCompanion(bool nullToAbsent) {
    return GarageServicesTableCompanion(
      id: Value(id),
      garageId: Value(garageId),
      serviceCategoryId: Value(serviceCategoryId),
      priceMin: priceMin == null && nullToAbsent
          ? const Value.absent()
          : Value(priceMin),
      priceMax: priceMax == null && nullToAbsent
          ? const Value.absent()
          : Value(priceMax),
      estimatedDuration: estimatedDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedDuration),
    );
  }

  factory GarageServicesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GarageServicesTableData(
      id: serializer.fromJson<String>(json['id']),
      garageId: serializer.fromJson<String>(json['garageId']),
      serviceCategoryId: serializer.fromJson<String>(json['serviceCategoryId']),
      priceMin: serializer.fromJson<double?>(json['priceMin']),
      priceMax: serializer.fromJson<double?>(json['priceMax']),
      estimatedDuration: serializer.fromJson<int?>(json['estimatedDuration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'garageId': serializer.toJson<String>(garageId),
      'serviceCategoryId': serializer.toJson<String>(serviceCategoryId),
      'priceMin': serializer.toJson<double?>(priceMin),
      'priceMax': serializer.toJson<double?>(priceMax),
      'estimatedDuration': serializer.toJson<int?>(estimatedDuration),
    };
  }

  GarageServicesTableData copyWith({
    String? id,
    String? garageId,
    String? serviceCategoryId,
    Value<double?> priceMin = const Value.absent(),
    Value<double?> priceMax = const Value.absent(),
    Value<int?> estimatedDuration = const Value.absent(),
  }) => GarageServicesTableData(
    id: id ?? this.id,
    garageId: garageId ?? this.garageId,
    serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
    priceMin: priceMin.present ? priceMin.value : this.priceMin,
    priceMax: priceMax.present ? priceMax.value : this.priceMax,
    estimatedDuration: estimatedDuration.present
        ? estimatedDuration.value
        : this.estimatedDuration,
  );
  GarageServicesTableData copyWithCompanion(GarageServicesTableCompanion data) {
    return GarageServicesTableData(
      id: data.id.present ? data.id.value : this.id,
      garageId: data.garageId.present ? data.garageId.value : this.garageId,
      serviceCategoryId: data.serviceCategoryId.present
          ? data.serviceCategoryId.value
          : this.serviceCategoryId,
      priceMin: data.priceMin.present ? data.priceMin.value : this.priceMin,
      priceMax: data.priceMax.present ? data.priceMax.value : this.priceMax,
      estimatedDuration: data.estimatedDuration.present
          ? data.estimatedDuration.value
          : this.estimatedDuration,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GarageServicesTableData(')
          ..write('id: $id, ')
          ..write('garageId: $garageId, ')
          ..write('serviceCategoryId: $serviceCategoryId, ')
          ..write('priceMin: $priceMin, ')
          ..write('priceMax: $priceMax, ')
          ..write('estimatedDuration: $estimatedDuration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    garageId,
    serviceCategoryId,
    priceMin,
    priceMax,
    estimatedDuration,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GarageServicesTableData &&
          other.id == this.id &&
          other.garageId == this.garageId &&
          other.serviceCategoryId == this.serviceCategoryId &&
          other.priceMin == this.priceMin &&
          other.priceMax == this.priceMax &&
          other.estimatedDuration == this.estimatedDuration);
}

class GarageServicesTableCompanion
    extends UpdateCompanion<GarageServicesTableData> {
  final Value<String> id;
  final Value<String> garageId;
  final Value<String> serviceCategoryId;
  final Value<double?> priceMin;
  final Value<double?> priceMax;
  final Value<int?> estimatedDuration;
  final Value<int> rowid;
  const GarageServicesTableCompanion({
    this.id = const Value.absent(),
    this.garageId = const Value.absent(),
    this.serviceCategoryId = const Value.absent(),
    this.priceMin = const Value.absent(),
    this.priceMax = const Value.absent(),
    this.estimatedDuration = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GarageServicesTableCompanion.insert({
    required String id,
    required String garageId,
    required String serviceCategoryId,
    this.priceMin = const Value.absent(),
    this.priceMax = const Value.absent(),
    this.estimatedDuration = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       garageId = Value(garageId),
       serviceCategoryId = Value(serviceCategoryId);
  static Insertable<GarageServicesTableData> custom({
    Expression<String>? id,
    Expression<String>? garageId,
    Expression<String>? serviceCategoryId,
    Expression<double>? priceMin,
    Expression<double>? priceMax,
    Expression<int>? estimatedDuration,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (garageId != null) 'garage_id': garageId,
      if (serviceCategoryId != null) 'service_category_id': serviceCategoryId,
      if (priceMin != null) 'price_min': priceMin,
      if (priceMax != null) 'price_max': priceMax,
      if (estimatedDuration != null) 'estimated_duration': estimatedDuration,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GarageServicesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? garageId,
    Value<String>? serviceCategoryId,
    Value<double?>? priceMin,
    Value<double?>? priceMax,
    Value<int?>? estimatedDuration,
    Value<int>? rowid,
  }) {
    return GarageServicesTableCompanion(
      id: id ?? this.id,
      garageId: garageId ?? this.garageId,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      priceMin: priceMin ?? this.priceMin,
      priceMax: priceMax ?? this.priceMax,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (garageId.present) {
      map['garage_id'] = Variable<String>(garageId.value);
    }
    if (serviceCategoryId.present) {
      map['service_category_id'] = Variable<String>(serviceCategoryId.value);
    }
    if (priceMin.present) {
      map['price_min'] = Variable<double>(priceMin.value);
    }
    if (priceMax.present) {
      map['price_max'] = Variable<double>(priceMax.value);
    }
    if (estimatedDuration.present) {
      map['estimated_duration'] = Variable<int>(estimatedDuration.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GarageServicesTableCompanion(')
          ..write('id: $id, ')
          ..write('garageId: $garageId, ')
          ..write('serviceCategoryId: $serviceCategoryId, ')
          ..write('priceMin: $priceMin, ')
          ..write('priceMax: $priceMax, ')
          ..write('estimatedDuration: $estimatedDuration, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServiceCategoriesTableTable extends ServiceCategoriesTable
    with TableInfo<$ServiceCategoriesTableTable, ServiceCategoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceCategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameFrMeta = const VerificationMeta('nameFr');
  @override
  late final GeneratedColumn<String> nameFr = GeneratedColumn<String>(
    'name_fr',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceTypeMeta = const VerificationMeta(
    'serviceType',
  );
  @override
  late final GeneratedColumn<String> serviceType = GeneratedColumn<String>(
    'service_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameEn,
    nameFr,
    iconName,
    serviceType,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServiceCategoriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_fr')) {
      context.handle(
        _nameFrMeta,
        nameFr.isAcceptableOrUnknown(data['name_fr']!, _nameFrMeta),
      );
    } else if (isInserting) {
      context.missing(_nameFrMeta);
    }
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
    } else if (isInserting) {
      context.missing(_iconNameMeta);
    }
    if (data.containsKey('service_type')) {
      context.handle(
        _serviceTypeMeta,
        serviceType.isAcceptableOrUnknown(
          data['service_type']!,
          _serviceTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serviceTypeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceCategoriesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceCategoriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameFr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_fr'],
      )!,
      iconName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_name'],
      )!,
      serviceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_type'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ServiceCategoriesTableTable createAlias(String alias) {
    return $ServiceCategoriesTableTable(attachedDatabase, alias);
  }
}

class ServiceCategoriesTableData extends DataClass
    implements Insertable<ServiceCategoriesTableData> {
  final String id;
  final String nameEn;
  final String nameFr;
  final String iconName;
  final String serviceType;
  final DateTime createdAt;
  const ServiceCategoriesTableData({
    required this.id,
    required this.nameEn,
    required this.nameFr,
    required this.iconName,
    required this.serviceType,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_en'] = Variable<String>(nameEn);
    map['name_fr'] = Variable<String>(nameFr);
    map['icon_name'] = Variable<String>(iconName);
    map['service_type'] = Variable<String>(serviceType);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ServiceCategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return ServiceCategoriesTableCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameFr: Value(nameFr),
      iconName: Value(iconName),
      serviceType: Value(serviceType),
      createdAt: Value(createdAt),
    );
  }

  factory ServiceCategoriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceCategoriesTableData(
      id: serializer.fromJson<String>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameFr: serializer.fromJson<String>(json['nameFr']),
      iconName: serializer.fromJson<String>(json['iconName']),
      serviceType: serializer.fromJson<String>(json['serviceType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameFr': serializer.toJson<String>(nameFr),
      'iconName': serializer.toJson<String>(iconName),
      'serviceType': serializer.toJson<String>(serviceType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ServiceCategoriesTableData copyWith({
    String? id,
    String? nameEn,
    String? nameFr,
    String? iconName,
    String? serviceType,
    DateTime? createdAt,
  }) => ServiceCategoriesTableData(
    id: id ?? this.id,
    nameEn: nameEn ?? this.nameEn,
    nameFr: nameFr ?? this.nameFr,
    iconName: iconName ?? this.iconName,
    serviceType: serviceType ?? this.serviceType,
    createdAt: createdAt ?? this.createdAt,
  );
  ServiceCategoriesTableData copyWithCompanion(
    ServiceCategoriesTableCompanion data,
  ) {
    return ServiceCategoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameFr: data.nameFr.present ? data.nameFr.value : this.nameFr,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      serviceType: data.serviceType.present
          ? data.serviceType.value
          : this.serviceType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServiceCategoriesTableData(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameFr: $nameFr, ')
          ..write('iconName: $iconName, ')
          ..write('serviceType: $serviceType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nameEn, nameFr, iconName, serviceType, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceCategoriesTableData &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameFr == this.nameFr &&
          other.iconName == this.iconName &&
          other.serviceType == this.serviceType &&
          other.createdAt == this.createdAt);
}

class ServiceCategoriesTableCompanion
    extends UpdateCompanion<ServiceCategoriesTableData> {
  final Value<String> id;
  final Value<String> nameEn;
  final Value<String> nameFr;
  final Value<String> iconName;
  final Value<String> serviceType;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ServiceCategoriesTableCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameFr = const Value.absent(),
    this.iconName = const Value.absent(),
    this.serviceType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServiceCategoriesTableCompanion.insert({
    required String id,
    required String nameEn,
    required String nameFr,
    required String iconName,
    required String serviceType,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameEn = Value(nameEn),
       nameFr = Value(nameFr),
       iconName = Value(iconName),
       serviceType = Value(serviceType);
  static Insertable<ServiceCategoriesTableData> custom({
    Expression<String>? id,
    Expression<String>? nameEn,
    Expression<String>? nameFr,
    Expression<String>? iconName,
    Expression<String>? serviceType,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameFr != null) 'name_fr': nameFr,
      if (iconName != null) 'icon_name': iconName,
      if (serviceType != null) 'service_type': serviceType,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServiceCategoriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? nameEn,
    Value<String>? nameFr,
    Value<String>? iconName,
    Value<String>? serviceType,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ServiceCategoriesTableCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameFr: nameFr ?? this.nameFr,
      iconName: iconName ?? this.iconName,
      serviceType: serviceType ?? this.serviceType,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameFr.present) {
      map['name_fr'] = Variable<String>(nameFr.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (serviceType.present) {
      map['service_type'] = Variable<String>(serviceType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceCategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameFr: $nameFr, ')
          ..write('iconName: $iconName, ')
          ..write('serviceType: $serviceType, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookingsTableTable extends BookingsTable
    with TableInfo<$BookingsTableTable, BookingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _garageIdMeta = const VerificationMeta(
    'garageId',
  );
  @override
  late final GeneratedColumn<String> garageId = GeneratedColumn<String>(
    'garage_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceCategoryIdMeta = const VerificationMeta(
    'serviceCategoryId',
  );
  @override
  late final GeneratedColumn<String> serviceCategoryId =
      GeneratedColumn<String>(
        'service_category_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _appointmentDateMeta = const VerificationMeta(
    'appointmentDate',
  );
  @override
  late final GeneratedColumn<DateTime> appointmentDate =
      GeneratedColumn<DateTime>(
        'appointment_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _appointmentTimeMeta = const VerificationMeta(
    'appointmentTime',
  );
  @override
  late final GeneratedColumn<String> appointmentTime = GeneratedColumn<String>(
    'appointment_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedCostMeta = const VerificationMeta(
    'estimatedCost',
  );
  @override
  late final GeneratedColumn<double> estimatedCost = GeneratedColumn<double>(
    'estimated_cost',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    garageId,
    vehicleId,
    serviceCategoryId,
    status,
    appointmentDate,
    appointmentTime,
    notes,
    estimatedCost,
    createdAt,
    updatedAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookings';
  @override
  VerificationContext validateIntegrity(
    Insertable<BookingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('garage_id')) {
      context.handle(
        _garageIdMeta,
        garageId.isAcceptableOrUnknown(data['garage_id']!, _garageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_garageIdMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('service_category_id')) {
      context.handle(
        _serviceCategoryIdMeta,
        serviceCategoryId.isAcceptableOrUnknown(
          data['service_category_id']!,
          _serviceCategoryIdMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('appointment_date')) {
      context.handle(
        _appointmentDateMeta,
        appointmentDate.isAcceptableOrUnknown(
          data['appointment_date']!,
          _appointmentDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_appointmentDateMeta);
    }
    if (data.containsKey('appointment_time')) {
      context.handle(
        _appointmentTimeMeta,
        appointmentTime.isAcceptableOrUnknown(
          data['appointment_time']!,
          _appointmentTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_appointmentTimeMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('estimated_cost')) {
      context.handle(
        _estimatedCostMeta,
        estimatedCost.isAcceptableOrUnknown(
          data['estimated_cost']!,
          _estimatedCostMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BookingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookingsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      garageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}garage_id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      serviceCategoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_category_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      appointmentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}appointment_date'],
      )!,
      appointmentTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}appointment_time'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      estimatedCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated_cost'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $BookingsTableTable createAlias(String alias) {
    return $BookingsTableTable(attachedDatabase, alias);
  }
}

class BookingsTableData extends DataClass
    implements Insertable<BookingsTableData> {
  final String id;
  final String userId;
  final String garageId;
  final String vehicleId;
  final String? serviceCategoryId;
  final String status;
  final DateTime appointmentDate;
  final String appointmentTime;
  final String? notes;
  final double? estimatedCost;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  const BookingsTableData({
    required this.id,
    required this.userId,
    required this.garageId,
    required this.vehicleId,
    this.serviceCategoryId,
    required this.status,
    required this.appointmentDate,
    required this.appointmentTime,
    this.notes,
    this.estimatedCost,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['garage_id'] = Variable<String>(garageId);
    map['vehicle_id'] = Variable<String>(vehicleId);
    if (!nullToAbsent || serviceCategoryId != null) {
      map['service_category_id'] = Variable<String>(serviceCategoryId);
    }
    map['status'] = Variable<String>(status);
    map['appointment_date'] = Variable<DateTime>(appointmentDate);
    map['appointment_time'] = Variable<String>(appointmentTime);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || estimatedCost != null) {
      map['estimated_cost'] = Variable<double>(estimatedCost);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  BookingsTableCompanion toCompanion(bool nullToAbsent) {
    return BookingsTableCompanion(
      id: Value(id),
      userId: Value(userId),
      garageId: Value(garageId),
      vehicleId: Value(vehicleId),
      serviceCategoryId: serviceCategoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceCategoryId),
      status: Value(status),
      appointmentDate: Value(appointmentDate),
      appointmentTime: Value(appointmentTime),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      estimatedCost: estimatedCost == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedCost),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isSynced: Value(isSynced),
    );
  }

  factory BookingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookingsTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      garageId: serializer.fromJson<String>(json['garageId']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      serviceCategoryId: serializer.fromJson<String?>(
        json['serviceCategoryId'],
      ),
      status: serializer.fromJson<String>(json['status']),
      appointmentDate: serializer.fromJson<DateTime>(json['appointmentDate']),
      appointmentTime: serializer.fromJson<String>(json['appointmentTime']),
      notes: serializer.fromJson<String?>(json['notes']),
      estimatedCost: serializer.fromJson<double?>(json['estimatedCost']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'garageId': serializer.toJson<String>(garageId),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'serviceCategoryId': serializer.toJson<String?>(serviceCategoryId),
      'status': serializer.toJson<String>(status),
      'appointmentDate': serializer.toJson<DateTime>(appointmentDate),
      'appointmentTime': serializer.toJson<String>(appointmentTime),
      'notes': serializer.toJson<String?>(notes),
      'estimatedCost': serializer.toJson<double?>(estimatedCost),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  BookingsTableData copyWith({
    String? id,
    String? userId,
    String? garageId,
    String? vehicleId,
    Value<String?> serviceCategoryId = const Value.absent(),
    String? status,
    DateTime? appointmentDate,
    String? appointmentTime,
    Value<String?> notes = const Value.absent(),
    Value<double?> estimatedCost = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSynced,
  }) => BookingsTableData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    garageId: garageId ?? this.garageId,
    vehicleId: vehicleId ?? this.vehicleId,
    serviceCategoryId: serviceCategoryId.present
        ? serviceCategoryId.value
        : this.serviceCategoryId,
    status: status ?? this.status,
    appointmentDate: appointmentDate ?? this.appointmentDate,
    appointmentTime: appointmentTime ?? this.appointmentTime,
    notes: notes.present ? notes.value : this.notes,
    estimatedCost: estimatedCost.present
        ? estimatedCost.value
        : this.estimatedCost,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isSynced: isSynced ?? this.isSynced,
  );
  BookingsTableData copyWithCompanion(BookingsTableCompanion data) {
    return BookingsTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      garageId: data.garageId.present ? data.garageId.value : this.garageId,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      serviceCategoryId: data.serviceCategoryId.present
          ? data.serviceCategoryId.value
          : this.serviceCategoryId,
      status: data.status.present ? data.status.value : this.status,
      appointmentDate: data.appointmentDate.present
          ? data.appointmentDate.value
          : this.appointmentDate,
      appointmentTime: data.appointmentTime.present
          ? data.appointmentTime.value
          : this.appointmentTime,
      notes: data.notes.present ? data.notes.value : this.notes,
      estimatedCost: data.estimatedCost.present
          ? data.estimatedCost.value
          : this.estimatedCost,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BookingsTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('garageId: $garageId, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('serviceCategoryId: $serviceCategoryId, ')
          ..write('status: $status, ')
          ..write('appointmentDate: $appointmentDate, ')
          ..write('appointmentTime: $appointmentTime, ')
          ..write('notes: $notes, ')
          ..write('estimatedCost: $estimatedCost, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    garageId,
    vehicleId,
    serviceCategoryId,
    status,
    appointmentDate,
    appointmentTime,
    notes,
    estimatedCost,
    createdAt,
    updatedAt,
    isSynced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookingsTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.garageId == this.garageId &&
          other.vehicleId == this.vehicleId &&
          other.serviceCategoryId == this.serviceCategoryId &&
          other.status == this.status &&
          other.appointmentDate == this.appointmentDate &&
          other.appointmentTime == this.appointmentTime &&
          other.notes == this.notes &&
          other.estimatedCost == this.estimatedCost &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isSynced == this.isSynced);
}

class BookingsTableCompanion extends UpdateCompanion<BookingsTableData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> garageId;
  final Value<String> vehicleId;
  final Value<String?> serviceCategoryId;
  final Value<String> status;
  final Value<DateTime> appointmentDate;
  final Value<String> appointmentTime;
  final Value<String?> notes;
  final Value<double?> estimatedCost;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const BookingsTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.garageId = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.serviceCategoryId = const Value.absent(),
    this.status = const Value.absent(),
    this.appointmentDate = const Value.absent(),
    this.appointmentTime = const Value.absent(),
    this.notes = const Value.absent(),
    this.estimatedCost = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookingsTableCompanion.insert({
    required String id,
    required String userId,
    required String garageId,
    required String vehicleId,
    this.serviceCategoryId = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime appointmentDate,
    required String appointmentTime,
    this.notes = const Value.absent(),
    this.estimatedCost = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       garageId = Value(garageId),
       vehicleId = Value(vehicleId),
       appointmentDate = Value(appointmentDate),
       appointmentTime = Value(appointmentTime);
  static Insertable<BookingsTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? garageId,
    Expression<String>? vehicleId,
    Expression<String>? serviceCategoryId,
    Expression<String>? status,
    Expression<DateTime>? appointmentDate,
    Expression<String>? appointmentTime,
    Expression<String>? notes,
    Expression<double>? estimatedCost,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (garageId != null) 'garage_id': garageId,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (serviceCategoryId != null) 'service_category_id': serviceCategoryId,
      if (status != null) 'status': status,
      if (appointmentDate != null) 'appointment_date': appointmentDate,
      if (appointmentTime != null) 'appointment_time': appointmentTime,
      if (notes != null) 'notes': notes,
      if (estimatedCost != null) 'estimated_cost': estimatedCost,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookingsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? garageId,
    Value<String>? vehicleId,
    Value<String?>? serviceCategoryId,
    Value<String>? status,
    Value<DateTime>? appointmentDate,
    Value<String>? appointmentTime,
    Value<String?>? notes,
    Value<double?>? estimatedCost,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return BookingsTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      garageId: garageId ?? this.garageId,
      vehicleId: vehicleId ?? this.vehicleId,
      serviceCategoryId: serviceCategoryId ?? this.serviceCategoryId,
      status: status ?? this.status,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      notes: notes ?? this.notes,
      estimatedCost: estimatedCost ?? this.estimatedCost,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (garageId.present) {
      map['garage_id'] = Variable<String>(garageId.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (serviceCategoryId.present) {
      map['service_category_id'] = Variable<String>(serviceCategoryId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (appointmentDate.present) {
      map['appointment_date'] = Variable<DateTime>(appointmentDate.value);
    }
    if (appointmentTime.present) {
      map['appointment_time'] = Variable<String>(appointmentTime.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (estimatedCost.present) {
      map['estimated_cost'] = Variable<double>(estimatedCost.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookingsTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('garageId: $garageId, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('serviceCategoryId: $serviceCategoryId, ')
          ..write('status: $status, ')
          ..write('appointmentDate: $appointmentDate, ')
          ..write('appointmentTime: $appointmentTime, ')
          ..write('notes: $notes, ')
          ..write('estimatedCost: $estimatedCost, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTableTable userProfilesTable =
      $UserProfilesTableTable(this);
  late final $VehiclesTableTable vehiclesTable = $VehiclesTableTable(this);
  late final $MaintenanceRecordsTableTable maintenanceRecordsTable =
      $MaintenanceRecordsTableTable(this);
  late final $GaragesTableTable garagesTable = $GaragesTableTable(this);
  late final $GarageServicesTableTable garageServicesTable =
      $GarageServicesTableTable(this);
  late final $ServiceCategoriesTableTable serviceCategoriesTable =
      $ServiceCategoriesTableTable(this);
  late final $BookingsTableTable bookingsTable = $BookingsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userProfilesTable,
    vehiclesTable,
    maintenanceRecordsTable,
    garagesTable,
    garageServicesTable,
    serviceCategoriesTable,
    bookingsTable,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$UserProfilesTableTableCreateCompanionBuilder =
    UserProfilesTableCompanion Function({
      required String id,
      Value<String?> fullName,
      Value<String?> phone,
      Value<String?> location,
      Value<String> preferredLanguage,
      Value<String?> avatarUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$UserProfilesTableTableUpdateCompanionBuilder =
    UserProfilesTableCompanion Function({
      Value<String> id,
      Value<String?> fullName,
      Value<String?> phone,
      Value<String?> location,
      Value<String> preferredLanguage,
      Value<String?> avatarUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$UserProfilesTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTableTable> {
  $$UserProfilesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferredLanguage => $composableBuilder(
    column: $table.preferredLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfilesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTableTable> {
  $$UserProfilesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferredLanguage => $composableBuilder(
    column: $table.preferredLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTableTable> {
  $$UserProfilesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get preferredLanguage => $composableBuilder(
    column: $table.preferredLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$UserProfilesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTableTable,
          UserProfilesTableData,
          $$UserProfilesTableTableFilterComposer,
          $$UserProfilesTableTableOrderingComposer,
          $$UserProfilesTableTableAnnotationComposer,
          $$UserProfilesTableTableCreateCompanionBuilder,
          $$UserProfilesTableTableUpdateCompanionBuilder,
          (
            UserProfilesTableData,
            BaseReferences<
              _$AppDatabase,
              $UserProfilesTableTable,
              UserProfilesTableData
            >,
          ),
          UserProfilesTableData,
          PrefetchHooks Function()
        > {
  $$UserProfilesTableTableTableManager(
    _$AppDatabase db,
    $UserProfilesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> fullName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String> preferredLanguage = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesTableCompanion(
                id: id,
                fullName: fullName,
                phone: phone,
                location: location,
                preferredLanguage: preferredLanguage,
                avatarUrl: avatarUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> fullName = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String> preferredLanguage = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesTableCompanion.insert(
                id: id,
                fullName: fullName,
                phone: phone,
                location: location,
                preferredLanguage: preferredLanguage,
                avatarUrl: avatarUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfilesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTableTable,
      UserProfilesTableData,
      $$UserProfilesTableTableFilterComposer,
      $$UserProfilesTableTableOrderingComposer,
      $$UserProfilesTableTableAnnotationComposer,
      $$UserProfilesTableTableCreateCompanionBuilder,
      $$UserProfilesTableTableUpdateCompanionBuilder,
      (
        UserProfilesTableData,
        BaseReferences<
          _$AppDatabase,
          $UserProfilesTableTable,
          UserProfilesTableData
        >,
      ),
      UserProfilesTableData,
      PrefetchHooks Function()
    >;
typedef $$VehiclesTableTableCreateCompanionBuilder =
    VehiclesTableCompanion Function({
      required String id,
      required String userId,
      required String make,
      required String model,
      required int year,
      required int mileage,
      Value<String?> vin,
      required String fuelType,
      Value<String?> plateNumber,
      Value<String?> color,
      Value<String> photoUrls,
      Value<String?> notes,
      Value<bool> isPrimary,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$VehiclesTableTableUpdateCompanionBuilder =
    VehiclesTableCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> make,
      Value<String> model,
      Value<int> year,
      Value<int> mileage,
      Value<String?> vin,
      Value<String> fuelType,
      Value<String?> plateNumber,
      Value<String?> color,
      Value<String> photoUrls,
      Value<String?> notes,
      Value<bool> isPrimary,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$VehiclesTableTableFilterComposer
    extends Composer<_$AppDatabase, $VehiclesTableTable> {
  $$VehiclesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mileage => $composableBuilder(
    column: $table.mileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vin => $composableBuilder(
    column: $table.vin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrls => $composableBuilder(
    column: $table.photoUrls,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VehiclesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiclesTableTable> {
  $$VehiclesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mileage => $composableBuilder(
    column: $table.mileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vin => $composableBuilder(
    column: $table.vin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrls => $composableBuilder(
    column: $table.photoUrls,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VehiclesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiclesTableTable> {
  $$VehiclesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get make =>
      $composableBuilder(column: $table.make, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get mileage =>
      $composableBuilder(column: $table.mileage, builder: (column) => column);

  GeneratedColumn<String> get vin =>
      $composableBuilder(column: $table.vin, builder: (column) => column);

  GeneratedColumn<String> get fuelType =>
      $composableBuilder(column: $table.fuelType, builder: (column) => column);

  GeneratedColumn<String> get plateNumber => $composableBuilder(
    column: $table.plateNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get photoUrls =>
      $composableBuilder(column: $table.photoUrls, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isPrimary =>
      $composableBuilder(column: $table.isPrimary, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$VehiclesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehiclesTableTable,
          VehiclesTableData,
          $$VehiclesTableTableFilterComposer,
          $$VehiclesTableTableOrderingComposer,
          $$VehiclesTableTableAnnotationComposer,
          $$VehiclesTableTableCreateCompanionBuilder,
          $$VehiclesTableTableUpdateCompanionBuilder,
          (
            VehiclesTableData,
            BaseReferences<
              _$AppDatabase,
              $VehiclesTableTable,
              VehiclesTableData
            >,
          ),
          VehiclesTableData,
          PrefetchHooks Function()
        > {
  $$VehiclesTableTableTableManager(_$AppDatabase db, $VehiclesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiclesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiclesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiclesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> make = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<int> mileage = const Value.absent(),
                Value<String?> vin = const Value.absent(),
                Value<String> fuelType = const Value.absent(),
                Value<String?> plateNumber = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String> photoUrls = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isPrimary = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehiclesTableCompanion(
                id: id,
                userId: userId,
                make: make,
                model: model,
                year: year,
                mileage: mileage,
                vin: vin,
                fuelType: fuelType,
                plateNumber: plateNumber,
                color: color,
                photoUrls: photoUrls,
                notes: notes,
                isPrimary: isPrimary,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String make,
                required String model,
                required int year,
                required int mileage,
                Value<String?> vin = const Value.absent(),
                required String fuelType,
                Value<String?> plateNumber = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String> photoUrls = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isPrimary = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehiclesTableCompanion.insert(
                id: id,
                userId: userId,
                make: make,
                model: model,
                year: year,
                mileage: mileage,
                vin: vin,
                fuelType: fuelType,
                plateNumber: plateNumber,
                color: color,
                photoUrls: photoUrls,
                notes: notes,
                isPrimary: isPrimary,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VehiclesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehiclesTableTable,
      VehiclesTableData,
      $$VehiclesTableTableFilterComposer,
      $$VehiclesTableTableOrderingComposer,
      $$VehiclesTableTableAnnotationComposer,
      $$VehiclesTableTableCreateCompanionBuilder,
      $$VehiclesTableTableUpdateCompanionBuilder,
      (
        VehiclesTableData,
        BaseReferences<_$AppDatabase, $VehiclesTableTable, VehiclesTableData>,
      ),
      VehiclesTableData,
      PrefetchHooks Function()
    >;
typedef $$MaintenanceRecordsTableTableCreateCompanionBuilder =
    MaintenanceRecordsTableCompanion Function({
      required String id,
      required String vehicleId,
      required String serviceType,
      required String title,
      Value<int?> mileageAtService,
      Value<double?> cost,
      required DateTime serviceDate,
      Value<String?> garageId,
      Value<DateTime?> nextServiceDate,
      Value<int?> nextServiceMileage,
      Value<String?> notes,
      Value<String> photoUrls,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$MaintenanceRecordsTableTableUpdateCompanionBuilder =
    MaintenanceRecordsTableCompanion Function({
      Value<String> id,
      Value<String> vehicleId,
      Value<String> serviceType,
      Value<String> title,
      Value<int?> mileageAtService,
      Value<double?> cost,
      Value<DateTime> serviceDate,
      Value<String?> garageId,
      Value<DateTime?> nextServiceDate,
      Value<int?> nextServiceMileage,
      Value<String?> notes,
      Value<String> photoUrls,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$MaintenanceRecordsTableTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceRecordsTableTable> {
  $$MaintenanceRecordsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vehicleId => $composableBuilder(
    column: $table.vehicleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mileageAtService => $composableBuilder(
    column: $table.mileageAtService,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get garageId => $composableBuilder(
    column: $table.garageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextServiceDate => $composableBuilder(
    column: $table.nextServiceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextServiceMileage => $composableBuilder(
    column: $table.nextServiceMileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrls => $composableBuilder(
    column: $table.photoUrls,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MaintenanceRecordsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceRecordsTableTable> {
  $$MaintenanceRecordsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vehicleId => $composableBuilder(
    column: $table.vehicleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mileageAtService => $composableBuilder(
    column: $table.mileageAtService,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get garageId => $composableBuilder(
    column: $table.garageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextServiceDate => $composableBuilder(
    column: $table.nextServiceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextServiceMileage => $composableBuilder(
    column: $table.nextServiceMileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrls => $composableBuilder(
    column: $table.photoUrls,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MaintenanceRecordsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceRecordsTableTable> {
  $$MaintenanceRecordsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get vehicleId =>
      $composableBuilder(column: $table.vehicleId, builder: (column) => column);

  GeneratedColumn<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get mileageAtService => $composableBuilder(
    column: $table.mileageAtService,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<DateTime> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get garageId =>
      $composableBuilder(column: $table.garageId, builder: (column) => column);

  GeneratedColumn<DateTime> get nextServiceDate => $composableBuilder(
    column: $table.nextServiceDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextServiceMileage => $composableBuilder(
    column: $table.nextServiceMileage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get photoUrls =>
      $composableBuilder(column: $table.photoUrls, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$MaintenanceRecordsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenanceRecordsTableTable,
          MaintenanceRecordsTableData,
          $$MaintenanceRecordsTableTableFilterComposer,
          $$MaintenanceRecordsTableTableOrderingComposer,
          $$MaintenanceRecordsTableTableAnnotationComposer,
          $$MaintenanceRecordsTableTableCreateCompanionBuilder,
          $$MaintenanceRecordsTableTableUpdateCompanionBuilder,
          (
            MaintenanceRecordsTableData,
            BaseReferences<
              _$AppDatabase,
              $MaintenanceRecordsTableTable,
              MaintenanceRecordsTableData
            >,
          ),
          MaintenanceRecordsTableData,
          PrefetchHooks Function()
        > {
  $$MaintenanceRecordsTableTableTableManager(
    _$AppDatabase db,
    $MaintenanceRecordsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceRecordsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MaintenanceRecordsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MaintenanceRecordsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<String> serviceType = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int?> mileageAtService = const Value.absent(),
                Value<double?> cost = const Value.absent(),
                Value<DateTime> serviceDate = const Value.absent(),
                Value<String?> garageId = const Value.absent(),
                Value<DateTime?> nextServiceDate = const Value.absent(),
                Value<int?> nextServiceMileage = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> photoUrls = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaintenanceRecordsTableCompanion(
                id: id,
                vehicleId: vehicleId,
                serviceType: serviceType,
                title: title,
                mileageAtService: mileageAtService,
                cost: cost,
                serviceDate: serviceDate,
                garageId: garageId,
                nextServiceDate: nextServiceDate,
                nextServiceMileage: nextServiceMileage,
                notes: notes,
                photoUrls: photoUrls,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                required String serviceType,
                required String title,
                Value<int?> mileageAtService = const Value.absent(),
                Value<double?> cost = const Value.absent(),
                required DateTime serviceDate,
                Value<String?> garageId = const Value.absent(),
                Value<DateTime?> nextServiceDate = const Value.absent(),
                Value<int?> nextServiceMileage = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> photoUrls = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaintenanceRecordsTableCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                serviceType: serviceType,
                title: title,
                mileageAtService: mileageAtService,
                cost: cost,
                serviceDate: serviceDate,
                garageId: garageId,
                nextServiceDate: nextServiceDate,
                nextServiceMileage: nextServiceMileage,
                notes: notes,
                photoUrls: photoUrls,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MaintenanceRecordsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenanceRecordsTableTable,
      MaintenanceRecordsTableData,
      $$MaintenanceRecordsTableTableFilterComposer,
      $$MaintenanceRecordsTableTableOrderingComposer,
      $$MaintenanceRecordsTableTableAnnotationComposer,
      $$MaintenanceRecordsTableTableCreateCompanionBuilder,
      $$MaintenanceRecordsTableTableUpdateCompanionBuilder,
      (
        MaintenanceRecordsTableData,
        BaseReferences<
          _$AppDatabase,
          $MaintenanceRecordsTableTable,
          MaintenanceRecordsTableData
        >,
      ),
      MaintenanceRecordsTableData,
      PrefetchHooks Function()
    >;
typedef $$GaragesTableTableCreateCompanionBuilder =
    GaragesTableCompanion Function({
      required String id,
      required String name,
      required String address,
      required String city,
      Value<double?> lat,
      Value<double?> lng,
      Value<String?> phone,
      Value<String> photoUrls,
      Value<double> averageRating,
      Value<int> totalReviews,
      Value<bool> isVerified,
      Value<String> workingHours,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$GaragesTableTableUpdateCompanionBuilder =
    GaragesTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> address,
      Value<String> city,
      Value<double?> lat,
      Value<double?> lng,
      Value<String?> phone,
      Value<String> photoUrls,
      Value<double> averageRating,
      Value<int> totalReviews,
      Value<bool> isVerified,
      Value<String> workingHours,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$GaragesTableTableFilterComposer
    extends Composer<_$AppDatabase, $GaragesTableTable> {
  $$GaragesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrls => $composableBuilder(
    column: $table.photoUrls,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get averageRating => $composableBuilder(
    column: $table.averageRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalReviews => $composableBuilder(
    column: $table.totalReviews,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workingHours => $composableBuilder(
    column: $table.workingHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GaragesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GaragesTableTable> {
  $$GaragesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrls => $composableBuilder(
    column: $table.photoUrls,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get averageRating => $composableBuilder(
    column: $table.averageRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalReviews => $composableBuilder(
    column: $table.totalReviews,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workingHours => $composableBuilder(
    column: $table.workingHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GaragesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GaragesTableTable> {
  $$GaragesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lng =>
      $composableBuilder(column: $table.lng, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get photoUrls =>
      $composableBuilder(column: $table.photoUrls, builder: (column) => column);

  GeneratedColumn<double> get averageRating => $composableBuilder(
    column: $table.averageRating,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalReviews => $composableBuilder(
    column: $table.totalReviews,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workingHours => $composableBuilder(
    column: $table.workingHours,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$GaragesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GaragesTableTable,
          GaragesTableData,
          $$GaragesTableTableFilterComposer,
          $$GaragesTableTableOrderingComposer,
          $$GaragesTableTableAnnotationComposer,
          $$GaragesTableTableCreateCompanionBuilder,
          $$GaragesTableTableUpdateCompanionBuilder,
          (
            GaragesTableData,
            BaseReferences<_$AppDatabase, $GaragesTableTable, GaragesTableData>,
          ),
          GaragesTableData,
          PrefetchHooks Function()
        > {
  $$GaragesTableTableTableManager(_$AppDatabase db, $GaragesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GaragesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GaragesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GaragesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<double?> lat = const Value.absent(),
                Value<double?> lng = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> photoUrls = const Value.absent(),
                Value<double> averageRating = const Value.absent(),
                Value<int> totalReviews = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<String> workingHours = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GaragesTableCompanion(
                id: id,
                name: name,
                address: address,
                city: city,
                lat: lat,
                lng: lng,
                phone: phone,
                photoUrls: photoUrls,
                averageRating: averageRating,
                totalReviews: totalReviews,
                isVerified: isVerified,
                workingHours: workingHours,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String address,
                required String city,
                Value<double?> lat = const Value.absent(),
                Value<double?> lng = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> photoUrls = const Value.absent(),
                Value<double> averageRating = const Value.absent(),
                Value<int> totalReviews = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<String> workingHours = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GaragesTableCompanion.insert(
                id: id,
                name: name,
                address: address,
                city: city,
                lat: lat,
                lng: lng,
                phone: phone,
                photoUrls: photoUrls,
                averageRating: averageRating,
                totalReviews: totalReviews,
                isVerified: isVerified,
                workingHours: workingHours,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GaragesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GaragesTableTable,
      GaragesTableData,
      $$GaragesTableTableFilterComposer,
      $$GaragesTableTableOrderingComposer,
      $$GaragesTableTableAnnotationComposer,
      $$GaragesTableTableCreateCompanionBuilder,
      $$GaragesTableTableUpdateCompanionBuilder,
      (
        GaragesTableData,
        BaseReferences<_$AppDatabase, $GaragesTableTable, GaragesTableData>,
      ),
      GaragesTableData,
      PrefetchHooks Function()
    >;
typedef $$GarageServicesTableTableCreateCompanionBuilder =
    GarageServicesTableCompanion Function({
      required String id,
      required String garageId,
      required String serviceCategoryId,
      Value<double?> priceMin,
      Value<double?> priceMax,
      Value<int?> estimatedDuration,
      Value<int> rowid,
    });
typedef $$GarageServicesTableTableUpdateCompanionBuilder =
    GarageServicesTableCompanion Function({
      Value<String> id,
      Value<String> garageId,
      Value<String> serviceCategoryId,
      Value<double?> priceMin,
      Value<double?> priceMax,
      Value<int?> estimatedDuration,
      Value<int> rowid,
    });

class $$GarageServicesTableTableFilterComposer
    extends Composer<_$AppDatabase, $GarageServicesTableTable> {
  $$GarageServicesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get garageId => $composableBuilder(
    column: $table.garageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceCategoryId => $composableBuilder(
    column: $table.serviceCategoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priceMin => $composableBuilder(
    column: $table.priceMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priceMax => $composableBuilder(
    column: $table.priceMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedDuration => $composableBuilder(
    column: $table.estimatedDuration,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GarageServicesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GarageServicesTableTable> {
  $$GarageServicesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get garageId => $composableBuilder(
    column: $table.garageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceCategoryId => $composableBuilder(
    column: $table.serviceCategoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priceMin => $composableBuilder(
    column: $table.priceMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priceMax => $composableBuilder(
    column: $table.priceMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedDuration => $composableBuilder(
    column: $table.estimatedDuration,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GarageServicesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GarageServicesTableTable> {
  $$GarageServicesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get garageId =>
      $composableBuilder(column: $table.garageId, builder: (column) => column);

  GeneratedColumn<String> get serviceCategoryId => $composableBuilder(
    column: $table.serviceCategoryId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get priceMin =>
      $composableBuilder(column: $table.priceMin, builder: (column) => column);

  GeneratedColumn<double> get priceMax =>
      $composableBuilder(column: $table.priceMax, builder: (column) => column);

  GeneratedColumn<int> get estimatedDuration => $composableBuilder(
    column: $table.estimatedDuration,
    builder: (column) => column,
  );
}

class $$GarageServicesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GarageServicesTableTable,
          GarageServicesTableData,
          $$GarageServicesTableTableFilterComposer,
          $$GarageServicesTableTableOrderingComposer,
          $$GarageServicesTableTableAnnotationComposer,
          $$GarageServicesTableTableCreateCompanionBuilder,
          $$GarageServicesTableTableUpdateCompanionBuilder,
          (
            GarageServicesTableData,
            BaseReferences<
              _$AppDatabase,
              $GarageServicesTableTable,
              GarageServicesTableData
            >,
          ),
          GarageServicesTableData,
          PrefetchHooks Function()
        > {
  $$GarageServicesTableTableTableManager(
    _$AppDatabase db,
    $GarageServicesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GarageServicesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GarageServicesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$GarageServicesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> garageId = const Value.absent(),
                Value<String> serviceCategoryId = const Value.absent(),
                Value<double?> priceMin = const Value.absent(),
                Value<double?> priceMax = const Value.absent(),
                Value<int?> estimatedDuration = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GarageServicesTableCompanion(
                id: id,
                garageId: garageId,
                serviceCategoryId: serviceCategoryId,
                priceMin: priceMin,
                priceMax: priceMax,
                estimatedDuration: estimatedDuration,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String garageId,
                required String serviceCategoryId,
                Value<double?> priceMin = const Value.absent(),
                Value<double?> priceMax = const Value.absent(),
                Value<int?> estimatedDuration = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GarageServicesTableCompanion.insert(
                id: id,
                garageId: garageId,
                serviceCategoryId: serviceCategoryId,
                priceMin: priceMin,
                priceMax: priceMax,
                estimatedDuration: estimatedDuration,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GarageServicesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GarageServicesTableTable,
      GarageServicesTableData,
      $$GarageServicesTableTableFilterComposer,
      $$GarageServicesTableTableOrderingComposer,
      $$GarageServicesTableTableAnnotationComposer,
      $$GarageServicesTableTableCreateCompanionBuilder,
      $$GarageServicesTableTableUpdateCompanionBuilder,
      (
        GarageServicesTableData,
        BaseReferences<
          _$AppDatabase,
          $GarageServicesTableTable,
          GarageServicesTableData
        >,
      ),
      GarageServicesTableData,
      PrefetchHooks Function()
    >;
typedef $$ServiceCategoriesTableTableCreateCompanionBuilder =
    ServiceCategoriesTableCompanion Function({
      required String id,
      required String nameEn,
      required String nameFr,
      required String iconName,
      required String serviceType,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$ServiceCategoriesTableTableUpdateCompanionBuilder =
    ServiceCategoriesTableCompanion Function({
      Value<String> id,
      Value<String> nameEn,
      Value<String> nameFr,
      Value<String> iconName,
      Value<String> serviceType,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ServiceCategoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ServiceCategoriesTableTable> {
  $$ServiceCategoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameFr => $composableBuilder(
    column: $table.nameFr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ServiceCategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ServiceCategoriesTableTable> {
  $$ServiceCategoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameFr => $composableBuilder(
    column: $table.nameFr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ServiceCategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServiceCategoriesTableTable> {
  $$ServiceCategoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameFr =>
      $composableBuilder(column: $table.nameFr, builder: (column) => column);

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<String> get serviceType => $composableBuilder(
    column: $table.serviceType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ServiceCategoriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServiceCategoriesTableTable,
          ServiceCategoriesTableData,
          $$ServiceCategoriesTableTableFilterComposer,
          $$ServiceCategoriesTableTableOrderingComposer,
          $$ServiceCategoriesTableTableAnnotationComposer,
          $$ServiceCategoriesTableTableCreateCompanionBuilder,
          $$ServiceCategoriesTableTableUpdateCompanionBuilder,
          (
            ServiceCategoriesTableData,
            BaseReferences<
              _$AppDatabase,
              $ServiceCategoriesTableTable,
              ServiceCategoriesTableData
            >,
          ),
          ServiceCategoriesTableData,
          PrefetchHooks Function()
        > {
  $$ServiceCategoriesTableTableTableManager(
    _$AppDatabase db,
    $ServiceCategoriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServiceCategoriesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ServiceCategoriesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ServiceCategoriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameFr = const Value.absent(),
                Value<String> iconName = const Value.absent(),
                Value<String> serviceType = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServiceCategoriesTableCompanion(
                id: id,
                nameEn: nameEn,
                nameFr: nameFr,
                iconName: iconName,
                serviceType: serviceType,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nameEn,
                required String nameFr,
                required String iconName,
                required String serviceType,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServiceCategoriesTableCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameFr: nameFr,
                iconName: iconName,
                serviceType: serviceType,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ServiceCategoriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServiceCategoriesTableTable,
      ServiceCategoriesTableData,
      $$ServiceCategoriesTableTableFilterComposer,
      $$ServiceCategoriesTableTableOrderingComposer,
      $$ServiceCategoriesTableTableAnnotationComposer,
      $$ServiceCategoriesTableTableCreateCompanionBuilder,
      $$ServiceCategoriesTableTableUpdateCompanionBuilder,
      (
        ServiceCategoriesTableData,
        BaseReferences<
          _$AppDatabase,
          $ServiceCategoriesTableTable,
          ServiceCategoriesTableData
        >,
      ),
      ServiceCategoriesTableData,
      PrefetchHooks Function()
    >;
typedef $$BookingsTableTableCreateCompanionBuilder =
    BookingsTableCompanion Function({
      required String id,
      required String userId,
      required String garageId,
      required String vehicleId,
      Value<String?> serviceCategoryId,
      Value<String> status,
      required DateTime appointmentDate,
      required String appointmentTime,
      Value<String?> notes,
      Value<double?> estimatedCost,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$BookingsTableTableUpdateCompanionBuilder =
    BookingsTableCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> garageId,
      Value<String> vehicleId,
      Value<String?> serviceCategoryId,
      Value<String> status,
      Value<DateTime> appointmentDate,
      Value<String> appointmentTime,
      Value<String?> notes,
      Value<double?> estimatedCost,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$BookingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $BookingsTableTable> {
  $$BookingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get garageId => $composableBuilder(
    column: $table.garageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vehicleId => $composableBuilder(
    column: $table.vehicleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceCategoryId => $composableBuilder(
    column: $table.serviceCategoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get appointmentDate => $composableBuilder(
    column: $table.appointmentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appointmentTime => $composableBuilder(
    column: $table.appointmentTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimatedCost => $composableBuilder(
    column: $table.estimatedCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BookingsTableTable> {
  $$BookingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get garageId => $composableBuilder(
    column: $table.garageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vehicleId => $composableBuilder(
    column: $table.vehicleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceCategoryId => $composableBuilder(
    column: $table.serviceCategoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get appointmentDate => $composableBuilder(
    column: $table.appointmentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appointmentTime => $composableBuilder(
    column: $table.appointmentTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimatedCost => $composableBuilder(
    column: $table.estimatedCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookingsTableTable> {
  $$BookingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get garageId =>
      $composableBuilder(column: $table.garageId, builder: (column) => column);

  GeneratedColumn<String> get vehicleId =>
      $composableBuilder(column: $table.vehicleId, builder: (column) => column);

  GeneratedColumn<String> get serviceCategoryId => $composableBuilder(
    column: $table.serviceCategoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get appointmentDate => $composableBuilder(
    column: $table.appointmentDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get appointmentTime => $composableBuilder(
    column: $table.appointmentTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get estimatedCost => $composableBuilder(
    column: $table.estimatedCost,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$BookingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookingsTableTable,
          BookingsTableData,
          $$BookingsTableTableFilterComposer,
          $$BookingsTableTableOrderingComposer,
          $$BookingsTableTableAnnotationComposer,
          $$BookingsTableTableCreateCompanionBuilder,
          $$BookingsTableTableUpdateCompanionBuilder,
          (
            BookingsTableData,
            BaseReferences<
              _$AppDatabase,
              $BookingsTableTable,
              BookingsTableData
            >,
          ),
          BookingsTableData,
          PrefetchHooks Function()
        > {
  $$BookingsTableTableTableManager(_$AppDatabase db, $BookingsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> garageId = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<String?> serviceCategoryId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> appointmentDate = const Value.absent(),
                Value<String> appointmentTime = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> estimatedCost = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookingsTableCompanion(
                id: id,
                userId: userId,
                garageId: garageId,
                vehicleId: vehicleId,
                serviceCategoryId: serviceCategoryId,
                status: status,
                appointmentDate: appointmentDate,
                appointmentTime: appointmentTime,
                notes: notes,
                estimatedCost: estimatedCost,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String garageId,
                required String vehicleId,
                Value<String?> serviceCategoryId = const Value.absent(),
                Value<String> status = const Value.absent(),
                required DateTime appointmentDate,
                required String appointmentTime,
                Value<String?> notes = const Value.absent(),
                Value<double?> estimatedCost = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookingsTableCompanion.insert(
                id: id,
                userId: userId,
                garageId: garageId,
                vehicleId: vehicleId,
                serviceCategoryId: serviceCategoryId,
                status: status,
                appointmentDate: appointmentDate,
                appointmentTime: appointmentTime,
                notes: notes,
                estimatedCost: estimatedCost,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookingsTableTable,
      BookingsTableData,
      $$BookingsTableTableFilterComposer,
      $$BookingsTableTableOrderingComposer,
      $$BookingsTableTableAnnotationComposer,
      $$BookingsTableTableCreateCompanionBuilder,
      $$BookingsTableTableUpdateCompanionBuilder,
      (
        BookingsTableData,
        BaseReferences<_$AppDatabase, $BookingsTableTable, BookingsTableData>,
      ),
      BookingsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableTableManager get userProfilesTable =>
      $$UserProfilesTableTableTableManager(_db, _db.userProfilesTable);
  $$VehiclesTableTableTableManager get vehiclesTable =>
      $$VehiclesTableTableTableManager(_db, _db.vehiclesTable);
  $$MaintenanceRecordsTableTableTableManager get maintenanceRecordsTable =>
      $$MaintenanceRecordsTableTableTableManager(
        _db,
        _db.maintenanceRecordsTable,
      );
  $$GaragesTableTableTableManager get garagesTable =>
      $$GaragesTableTableTableManager(_db, _db.garagesTable);
  $$GarageServicesTableTableTableManager get garageServicesTable =>
      $$GarageServicesTableTableTableManager(_db, _db.garageServicesTable);
  $$ServiceCategoriesTableTableTableManager get serviceCategoriesTable =>
      $$ServiceCategoriesTableTableTableManager(
        _db,
        _db.serviceCategoriesTable,
      );
  $$BookingsTableTableTableManager get bookingsTable =>
      $$BookingsTableTableTableManager(_db, _db.bookingsTable);
}
