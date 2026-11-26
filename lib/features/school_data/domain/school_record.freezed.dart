// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'school_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttendanceRecord {

 String get id; String get studentId; DateTime get date; AttendanceStatus get status; String get recordedBy;
/// Create a copy of AttendanceRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceRecordCopyWith<AttendanceRecord> get copyWith => _$AttendanceRecordCopyWithImpl<AttendanceRecord>(this as AttendanceRecord, _$identity);

  /// Serializes this AttendanceRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AttendanceRecord;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceRecord&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.studentId, _this.studentId) || other.studentId == _this.studentId)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.recordedBy, _this.recordedBy) || other.recordedBy == _this.recordedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AttendanceRecord;
  return Object.hash(runtimeType,_this.id,_this.studentId,_this.date,_this.status,_this.recordedBy);
}

@override
String toString() {
  final _this = this as AttendanceRecord;
  return 'AttendanceRecord(id: ${_this.id}, studentId: ${_this.studentId}, date: ${_this.date}, status: ${_this.status}, recordedBy: ${_this.recordedBy})';
}


}

/// @nodoc
abstract mixin class $AttendanceRecordCopyWith<$Res>  {
  factory $AttendanceRecordCopyWith(AttendanceRecord value, $Res Function(AttendanceRecord) _then) = _$AttendanceRecordCopyWithImpl;
@useResult
$Res call({
 String id, String studentId, DateTime date, AttendanceStatus status, String recordedBy
});




}
/// @nodoc
class _$AttendanceRecordCopyWithImpl<$Res>
    implements $AttendanceRecordCopyWith<$Res> {
  _$AttendanceRecordCopyWithImpl(this._self, this._then);

  final AttendanceRecord _self;
  final $Res Function(AttendanceRecord) _then;

/// Create a copy of AttendanceRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? studentId = null,Object? date = null,Object? status = null,Object? recordedBy = null,}) {
  return _then(AttendanceRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AttendanceStatus,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceRecord].
extension AttendanceRecordPatterns on AttendanceRecord {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceRecord() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceRecord value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceRecord():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceRecord value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceRecord() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String studentId,  DateTime date,  AttendanceStatus status,  String recordedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceRecord() when $default != null:
return $default(_that.id,_that.studentId,_that.date,_that.status,_that.recordedBy);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String studentId,  DateTime date,  AttendanceStatus status,  String recordedBy)  $default,) {final _that = this;
switch (_that) {
case _AttendanceRecord():
return $default(_that.id,_that.studentId,_that.date,_that.status,_that.recordedBy);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String studentId,  DateTime date,  AttendanceStatus status,  String recordedBy)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceRecord() when $default != null:
return $default(_that.id,_that.studentId,_that.date,_that.status,_that.recordedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceRecord implements AttendanceRecord {
  const _AttendanceRecord({required this.id, required this.studentId, required this.date, required this.status, required this.recordedBy});
  factory _AttendanceRecord.fromJson(Map<String, dynamic> json) => _$AttendanceRecordFromJson(json);

@override final  String id;
@override final  String studentId;
@override final  DateTime date;
@override final  AttendanceStatus status;
@override final  String recordedBy;

/// Create a copy of AttendanceRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceRecordCopyWith<_AttendanceRecord> get copyWith => __$AttendanceRecordCopyWithImpl<_AttendanceRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceRecordToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.date, date) || other.date == date)&&(identical(other.status, status) || other.status == status)&&(identical(other.recordedBy, recordedBy) || other.recordedBy == recordedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,studentId,date,status,recordedBy);
}

@override
String toString() {
    return 'AttendanceRecord(id: $id, studentId: $studentId, date: $date, status: $status, recordedBy: $recordedBy)';
}


}

/// @nodoc
abstract mixin class _$AttendanceRecordCopyWith<$Res> implements $AttendanceRecordCopyWith<$Res> {
  factory _$AttendanceRecordCopyWith(_AttendanceRecord value, $Res Function(_AttendanceRecord) _then) = __$AttendanceRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String studentId, DateTime date, AttendanceStatus status, String recordedBy
});




}
/// @nodoc
class __$AttendanceRecordCopyWithImpl<$Res>
    implements _$AttendanceRecordCopyWith<$Res> {
  __$AttendanceRecordCopyWithImpl(this._self, this._then);

  final _AttendanceRecord _self;
  final $Res Function(_AttendanceRecord) _then;

/// Create a copy of AttendanceRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? studentId = null,Object? date = null,Object? status = null,Object? recordedBy = null,}) {
  return _then(_AttendanceRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AttendanceStatus,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GradeRecord {

 String get id; String get studentId; String get subject; double get score; String get term; DateTime get date; String get recordedBy;
/// Create a copy of GradeRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeRecordCopyWith<GradeRecord> get copyWith => _$GradeRecordCopyWithImpl<GradeRecord>(this as GradeRecord, _$identity);

  /// Serializes this GradeRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as GradeRecord;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeRecord&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.studentId, _this.studentId) || other.studentId == _this.studentId)&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&(identical(other.score, _this.score) || other.score == _this.score)&&(identical(other.term, _this.term) || other.term == _this.term)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.recordedBy, _this.recordedBy) || other.recordedBy == _this.recordedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GradeRecord;
  return Object.hash(runtimeType,_this.id,_this.studentId,_this.subject,_this.score,_this.term,_this.date,_this.recordedBy);
}

@override
String toString() {
  final _this = this as GradeRecord;
  return 'GradeRecord(id: ${_this.id}, studentId: ${_this.studentId}, subject: ${_this.subject}, score: ${_this.score}, term: ${_this.term}, date: ${_this.date}, recordedBy: ${_this.recordedBy})';
}


}

/// @nodoc
abstract mixin class $GradeRecordCopyWith<$Res>  {
  factory $GradeRecordCopyWith(GradeRecord value, $Res Function(GradeRecord) _then) = _$GradeRecordCopyWithImpl;
@useResult
$Res call({
 String id, String studentId, String subject, double score, String term, DateTime date, String recordedBy
});




}
/// @nodoc
class _$GradeRecordCopyWithImpl<$Res>
    implements $GradeRecordCopyWith<$Res> {
  _$GradeRecordCopyWithImpl(this._self, this._then);

  final GradeRecord _self;
  final $Res Function(GradeRecord) _then;

/// Create a copy of GradeRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? studentId = null,Object? subject = null,Object? score = null,Object? term = null,Object? date = null,Object? recordedBy = null,}) {
  return _then(GradeRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GradeRecord].
extension GradeRecordPatterns on GradeRecord {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GradeRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GradeRecord() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GradeRecord value)  $default,){
final _that = this;
switch (_that) {
case _GradeRecord():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GradeRecord value)?  $default,){
final _that = this;
switch (_that) {
case _GradeRecord() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String studentId,  String subject,  double score,  String term,  DateTime date,  String recordedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GradeRecord() when $default != null:
return $default(_that.id,_that.studentId,_that.subject,_that.score,_that.term,_that.date,_that.recordedBy);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String studentId,  String subject,  double score,  String term,  DateTime date,  String recordedBy)  $default,) {final _that = this;
switch (_that) {
case _GradeRecord():
return $default(_that.id,_that.studentId,_that.subject,_that.score,_that.term,_that.date,_that.recordedBy);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String studentId,  String subject,  double score,  String term,  DateTime date,  String recordedBy)?  $default,) {final _that = this;
switch (_that) {
case _GradeRecord() when $default != null:
return $default(_that.id,_that.studentId,_that.subject,_that.score,_that.term,_that.date,_that.recordedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GradeRecord implements GradeRecord {
  const _GradeRecord({required this.id, required this.studentId, required this.subject, required this.score, required this.term, required this.date, required this.recordedBy});
  factory _GradeRecord.fromJson(Map<String, dynamic> json) => _$GradeRecordFromJson(json);

@override final  String id;
@override final  String studentId;
@override final  String subject;
@override final  double score;
@override final  String term;
@override final  DateTime date;
@override final  String recordedBy;

/// Create a copy of GradeRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradeRecordCopyWith<_GradeRecord> get copyWith => __$GradeRecordCopyWithImpl<_GradeRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GradeRecordToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradeRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.score, score) || other.score == score)&&(identical(other.term, term) || other.term == term)&&(identical(other.date, date) || other.date == date)&&(identical(other.recordedBy, recordedBy) || other.recordedBy == recordedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,studentId,subject,score,term,date,recordedBy);
}

@override
String toString() {
    return 'GradeRecord(id: $id, studentId: $studentId, subject: $subject, score: $score, term: $term, date: $date, recordedBy: $recordedBy)';
}


}

/// @nodoc
abstract mixin class _$GradeRecordCopyWith<$Res> implements $GradeRecordCopyWith<$Res> {
  factory _$GradeRecordCopyWith(_GradeRecord value, $Res Function(_GradeRecord) _then) = __$GradeRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String studentId, String subject, double score, String term, DateTime date, String recordedBy
});




}
/// @nodoc
class __$GradeRecordCopyWithImpl<$Res>
    implements _$GradeRecordCopyWith<$Res> {
  __$GradeRecordCopyWithImpl(this._self, this._then);

  final _GradeRecord _self;
  final $Res Function(_GradeRecord) _then;

/// Create a copy of GradeRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? studentId = null,Object? subject = null,Object? score = null,Object? term = null,Object? date = null,Object? recordedBy = null,}) {
  return _then(_GradeRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$BehaviorReport {

 String get id; String get studentId; String get description; BehaviorSeverity get severity; String get status; DateTime get date; String get reportedBy;
/// Create a copy of BehaviorReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BehaviorReportCopyWith<BehaviorReport> get copyWith => _$BehaviorReportCopyWithImpl<BehaviorReport>(this as BehaviorReport, _$identity);

  /// Serializes this BehaviorReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BehaviorReport;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BehaviorReport&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.studentId, _this.studentId) || other.studentId == _this.studentId)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.severity, _this.severity) || other.severity == _this.severity)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.reportedBy, _this.reportedBy) || other.reportedBy == _this.reportedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BehaviorReport;
  return Object.hash(runtimeType,_this.id,_this.studentId,_this.description,_this.severity,_this.status,_this.date,_this.reportedBy);
}

@override
String toString() {
  final _this = this as BehaviorReport;
  return 'BehaviorReport(id: ${_this.id}, studentId: ${_this.studentId}, description: ${_this.description}, severity: ${_this.severity}, status: ${_this.status}, date: ${_this.date}, reportedBy: ${_this.reportedBy})';
}


}

/// @nodoc
abstract mixin class $BehaviorReportCopyWith<$Res>  {
  factory $BehaviorReportCopyWith(BehaviorReport value, $Res Function(BehaviorReport) _then) = _$BehaviorReportCopyWithImpl;
@useResult
$Res call({
 String id, String studentId, String description, BehaviorSeverity severity, String status, DateTime date, String reportedBy
});




}
/// @nodoc
class _$BehaviorReportCopyWithImpl<$Res>
    implements $BehaviorReportCopyWith<$Res> {
  _$BehaviorReportCopyWithImpl(this._self, this._then);

  final BehaviorReport _self;
  final $Res Function(BehaviorReport) _then;

/// Create a copy of BehaviorReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? studentId = null,Object? description = null,Object? severity = null,Object? status = null,Object? date = null,Object? reportedBy = null,}) {
  return _then(BehaviorReport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as BehaviorSeverity,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,reportedBy: null == reportedBy ? _self.reportedBy : reportedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BehaviorReport].
extension BehaviorReportPatterns on BehaviorReport {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BehaviorReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BehaviorReport() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BehaviorReport value)  $default,){
final _that = this;
switch (_that) {
case _BehaviorReport():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BehaviorReport value)?  $default,){
final _that = this;
switch (_that) {
case _BehaviorReport() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String studentId,  String description,  BehaviorSeverity severity,  String status,  DateTime date,  String reportedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BehaviorReport() when $default != null:
return $default(_that.id,_that.studentId,_that.description,_that.severity,_that.status,_that.date,_that.reportedBy);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String studentId,  String description,  BehaviorSeverity severity,  String status,  DateTime date,  String reportedBy)  $default,) {final _that = this;
switch (_that) {
case _BehaviorReport():
return $default(_that.id,_that.studentId,_that.description,_that.severity,_that.status,_that.date,_that.reportedBy);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String studentId,  String description,  BehaviorSeverity severity,  String status,  DateTime date,  String reportedBy)?  $default,) {final _that = this;
switch (_that) {
case _BehaviorReport() when $default != null:
return $default(_that.id,_that.studentId,_that.description,_that.severity,_that.status,_that.date,_that.reportedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BehaviorReport implements BehaviorReport {
  const _BehaviorReport({required this.id, required this.studentId, required this.description, required this.severity, required this.status, required this.date, required this.reportedBy});
  factory _BehaviorReport.fromJson(Map<String, dynamic> json) => _$BehaviorReportFromJson(json);

@override final  String id;
@override final  String studentId;
@override final  String description;
@override final  BehaviorSeverity severity;
@override final  String status;
@override final  DateTime date;
@override final  String reportedBy;

/// Create a copy of BehaviorReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BehaviorReportCopyWith<_BehaviorReport> get copyWith => __$BehaviorReportCopyWithImpl<_BehaviorReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BehaviorReportToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BehaviorReport&&(identical(other.id, id) || other.id == id)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.description, description) || other.description == description)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date)&&(identical(other.reportedBy, reportedBy) || other.reportedBy == reportedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,studentId,description,severity,status,date,reportedBy);
}

@override
String toString() {
    return 'BehaviorReport(id: $id, studentId: $studentId, description: $description, severity: $severity, status: $status, date: $date, reportedBy: $reportedBy)';
}


}

/// @nodoc
abstract mixin class _$BehaviorReportCopyWith<$Res> implements $BehaviorReportCopyWith<$Res> {
  factory _$BehaviorReportCopyWith(_BehaviorReport value, $Res Function(_BehaviorReport) _then) = __$BehaviorReportCopyWithImpl;
@override @useResult
$Res call({
 String id, String studentId, String description, BehaviorSeverity severity, String status, DateTime date, String reportedBy
});




}
/// @nodoc
class __$BehaviorReportCopyWithImpl<$Res>
    implements _$BehaviorReportCopyWith<$Res> {
  __$BehaviorReportCopyWithImpl(this._self, this._then);

  final _BehaviorReport _self;
  final $Res Function(_BehaviorReport) _then;

/// Create a copy of BehaviorReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? studentId = null,Object? description = null,Object? severity = null,Object? status = null,Object? date = null,Object? reportedBy = null,}) {
  return _then(_BehaviorReport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as BehaviorSeverity,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,reportedBy: null == reportedBy ? _self.reportedBy : reportedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CheckInOutRecord {

 String get id; String get studentId; bool get checkedIn; DateTime get time; String get recordedBy;
/// Create a copy of CheckInOutRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckInOutRecordCopyWith<CheckInOutRecord> get copyWith => _$CheckInOutRecordCopyWithImpl<CheckInOutRecord>(this as CheckInOutRecord, _$identity);

  /// Serializes this CheckInOutRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CheckInOutRecord;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckInOutRecord&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.studentId, _this.studentId) || other.studentId == _this.studentId)&&(identical(other.checkedIn, _this.checkedIn) || other.checkedIn == _this.checkedIn)&&(identical(other.time, _this.time) || other.time == _this.time)&&(identical(other.recordedBy, _this.recordedBy) || other.recordedBy == _this.recordedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CheckInOutRecord;
  return Object.hash(runtimeType,_this.id,_this.studentId,_this.checkedIn,_this.time,_this.recordedBy);
}

@override
String toString() {
  final _this = this as CheckInOutRecord;
  return 'CheckInOutRecord(id: ${_this.id}, studentId: ${_this.studentId}, checkedIn: ${_this.checkedIn}, time: ${_this.time}, recordedBy: ${_this.recordedBy})';
}


}

/// @nodoc
abstract mixin class $CheckInOutRecordCopyWith<$Res>  {
  factory $CheckInOutRecordCopyWith(CheckInOutRecord value, $Res Function(CheckInOutRecord) _then) = _$CheckInOutRecordCopyWithImpl;
@useResult
$Res call({
 String id, String studentId, bool checkedIn, DateTime time, String recordedBy
});




}
/// @nodoc
class _$CheckInOutRecordCopyWithImpl<$Res>
    implements $CheckInOutRecordCopyWith<$Res> {
  _$CheckInOutRecordCopyWithImpl(this._self, this._then);

  final CheckInOutRecord _self;
  final $Res Function(CheckInOutRecord) _then;

/// Create a copy of CheckInOutRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? studentId = null,Object? checkedIn = null,Object? time = null,Object? recordedBy = null,}) {
  return _then(CheckInOutRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,checkedIn: null == checkedIn ? _self.checkedIn : checkedIn // ignore: cast_nullable_to_non_nullable
as bool,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckInOutRecord].
extension CheckInOutRecordPatterns on CheckInOutRecord {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckInOutRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckInOutRecord() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckInOutRecord value)  $default,){
final _that = this;
switch (_that) {
case _CheckInOutRecord():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckInOutRecord value)?  $default,){
final _that = this;
switch (_that) {
case _CheckInOutRecord() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String studentId,  bool checkedIn,  DateTime time,  String recordedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckInOutRecord() when $default != null:
return $default(_that.id,_that.studentId,_that.checkedIn,_that.time,_that.recordedBy);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String studentId,  bool checkedIn,  DateTime time,  String recordedBy)  $default,) {final _that = this;
switch (_that) {
case _CheckInOutRecord():
return $default(_that.id,_that.studentId,_that.checkedIn,_that.time,_that.recordedBy);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String studentId,  bool checkedIn,  DateTime time,  String recordedBy)?  $default,) {final _that = this;
switch (_that) {
case _CheckInOutRecord() when $default != null:
return $default(_that.id,_that.studentId,_that.checkedIn,_that.time,_that.recordedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckInOutRecord implements CheckInOutRecord {
  const _CheckInOutRecord({required this.id, required this.studentId, required this.checkedIn, required this.time, required this.recordedBy});
  factory _CheckInOutRecord.fromJson(Map<String, dynamic> json) => _$CheckInOutRecordFromJson(json);

@override final  String id;
@override final  String studentId;
@override final  bool checkedIn;
@override final  DateTime time;
@override final  String recordedBy;

/// Create a copy of CheckInOutRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckInOutRecordCopyWith<_CheckInOutRecord> get copyWith => __$CheckInOutRecordCopyWithImpl<_CheckInOutRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckInOutRecordToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckInOutRecord&&(identical(other.id, id) || other.id == id)&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.checkedIn, checkedIn) || other.checkedIn == checkedIn)&&(identical(other.time, time) || other.time == time)&&(identical(other.recordedBy, recordedBy) || other.recordedBy == recordedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,studentId,checkedIn,time,recordedBy);
}

@override
String toString() {
    return 'CheckInOutRecord(id: $id, studentId: $studentId, checkedIn: $checkedIn, time: $time, recordedBy: $recordedBy)';
}


}

/// @nodoc
abstract mixin class _$CheckInOutRecordCopyWith<$Res> implements $CheckInOutRecordCopyWith<$Res> {
  factory _$CheckInOutRecordCopyWith(_CheckInOutRecord value, $Res Function(_CheckInOutRecord) _then) = __$CheckInOutRecordCopyWithImpl;
@override @useResult
$Res call({
 String id, String studentId, bool checkedIn, DateTime time, String recordedBy
});




}
/// @nodoc
class __$CheckInOutRecordCopyWithImpl<$Res>
    implements _$CheckInOutRecordCopyWith<$Res> {
  __$CheckInOutRecordCopyWithImpl(this._self, this._then);

  final _CheckInOutRecord _self;
  final $Res Function(_CheckInOutRecord) _then;

/// Create a copy of CheckInOutRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? studentId = null,Object? checkedIn = null,Object? time = null,Object? recordedBy = null,}) {
  return _then(_CheckInOutRecord(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,checkedIn: null == checkedIn ? _self.checkedIn : checkedIn // ignore: cast_nullable_to_non_nullable
as bool,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as DateTime,recordedBy: null == recordedBy ? _self.recordedBy : recordedBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SchoolAnnouncement {

 String get id; String get title; String get message; String get kind; DateTime get date; String get createdBy;
/// Create a copy of SchoolAnnouncement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SchoolAnnouncementCopyWith<SchoolAnnouncement> get copyWith => _$SchoolAnnouncementCopyWithImpl<SchoolAnnouncement>(this as SchoolAnnouncement, _$identity);

  /// Serializes this SchoolAnnouncement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SchoolAnnouncement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SchoolAnnouncement&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.createdBy, _this.createdBy) || other.createdBy == _this.createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SchoolAnnouncement;
  return Object.hash(runtimeType,_this.id,_this.title,_this.message,_this.kind,_this.date,_this.createdBy);
}

@override
String toString() {
  final _this = this as SchoolAnnouncement;
  return 'SchoolAnnouncement(id: ${_this.id}, title: ${_this.title}, message: ${_this.message}, kind: ${_this.kind}, date: ${_this.date}, createdBy: ${_this.createdBy})';
}


}

/// @nodoc
abstract mixin class $SchoolAnnouncementCopyWith<$Res>  {
  factory $SchoolAnnouncementCopyWith(SchoolAnnouncement value, $Res Function(SchoolAnnouncement) _then) = _$SchoolAnnouncementCopyWithImpl;
@useResult
$Res call({
 String id, String title, String message, String kind, DateTime date, String createdBy
});




}
/// @nodoc
class _$SchoolAnnouncementCopyWithImpl<$Res>
    implements $SchoolAnnouncementCopyWith<$Res> {
  _$SchoolAnnouncementCopyWithImpl(this._self, this._then);

  final SchoolAnnouncement _self;
  final $Res Function(SchoolAnnouncement) _then;

/// Create a copy of SchoolAnnouncement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? message = null,Object? kind = null,Object? date = null,Object? createdBy = null,}) {
  return _then(SchoolAnnouncement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SchoolAnnouncement].
extension SchoolAnnouncementPatterns on SchoolAnnouncement {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SchoolAnnouncement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SchoolAnnouncement() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SchoolAnnouncement value)  $default,){
final _that = this;
switch (_that) {
case _SchoolAnnouncement():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SchoolAnnouncement value)?  $default,){
final _that = this;
switch (_that) {
case _SchoolAnnouncement() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String message,  String kind,  DateTime date,  String createdBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SchoolAnnouncement() when $default != null:
return $default(_that.id,_that.title,_that.message,_that.kind,_that.date,_that.createdBy);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String message,  String kind,  DateTime date,  String createdBy)  $default,) {final _that = this;
switch (_that) {
case _SchoolAnnouncement():
return $default(_that.id,_that.title,_that.message,_that.kind,_that.date,_that.createdBy);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String message,  String kind,  DateTime date,  String createdBy)?  $default,) {final _that = this;
switch (_that) {
case _SchoolAnnouncement() when $default != null:
return $default(_that.id,_that.title,_that.message,_that.kind,_that.date,_that.createdBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SchoolAnnouncement implements SchoolAnnouncement {
  const _SchoolAnnouncement({required this.id, required this.title, required this.message, required this.kind, required this.date, required this.createdBy});
  factory _SchoolAnnouncement.fromJson(Map<String, dynamic> json) => _$SchoolAnnouncementFromJson(json);

@override final  String id;
@override final  String title;
@override final  String message;
@override final  String kind;
@override final  DateTime date;
@override final  String createdBy;

/// Create a copy of SchoolAnnouncement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SchoolAnnouncementCopyWith<_SchoolAnnouncement> get copyWith => __$SchoolAnnouncementCopyWithImpl<_SchoolAnnouncement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SchoolAnnouncementToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SchoolAnnouncement&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.date, date) || other.date == date)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,message,kind,date,createdBy);
}

@override
String toString() {
    return 'SchoolAnnouncement(id: $id, title: $title, message: $message, kind: $kind, date: $date, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class _$SchoolAnnouncementCopyWith<$Res> implements $SchoolAnnouncementCopyWith<$Res> {
  factory _$SchoolAnnouncementCopyWith(_SchoolAnnouncement value, $Res Function(_SchoolAnnouncement) _then) = __$SchoolAnnouncementCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String message, String kind, DateTime date, String createdBy
});




}
/// @nodoc
class __$SchoolAnnouncementCopyWithImpl<$Res>
    implements _$SchoolAnnouncementCopyWith<$Res> {
  __$SchoolAnnouncementCopyWithImpl(this._self, this._then);

  final _SchoolAnnouncement _self;
  final $Res Function(_SchoolAnnouncement) _then;

/// Create a copy of SchoolAnnouncement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? message = null,Object? kind = null,Object? date = null,Object? createdBy = null,}) {
  return _then(_SchoolAnnouncement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ScheduleItem {

 String get id; String get title; DateTime get startDate; DateTime get endDate; String get description;
/// Create a copy of ScheduleItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleItemCopyWith<ScheduleItem> get copyWith => _$ScheduleItemCopyWithImpl<ScheduleItem>(this as ScheduleItem, _$identity);

  /// Serializes this ScheduleItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ScheduleItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.description, _this.description) || other.description == _this.description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ScheduleItem;
  return Object.hash(runtimeType,_this.id,_this.title,_this.startDate,_this.endDate,_this.description);
}

@override
String toString() {
  final _this = this as ScheduleItem;
  return 'ScheduleItem(id: ${_this.id}, title: ${_this.title}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $ScheduleItemCopyWith<$Res>  {
  factory $ScheduleItemCopyWith(ScheduleItem value, $Res Function(ScheduleItem) _then) = _$ScheduleItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime startDate, DateTime endDate, String description
});




}
/// @nodoc
class _$ScheduleItemCopyWithImpl<$Res>
    implements $ScheduleItemCopyWith<$Res> {
  _$ScheduleItemCopyWithImpl(this._self, this._then);

  final ScheduleItem _self;
  final $Res Function(ScheduleItem) _then;

/// Create a copy of ScheduleItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startDate = null,Object? endDate = null,Object? description = null,}) {
  return _then(ScheduleItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleItem].
extension ScheduleItemPatterns on ScheduleItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleItem value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleItem value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  DateTime startDate,  DateTime endDate,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleItem() when $default != null:
return $default(_that.id,_that.title,_that.startDate,_that.endDate,_that.description);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  DateTime startDate,  DateTime endDate,  String description)  $default,) {final _that = this;
switch (_that) {
case _ScheduleItem():
return $default(_that.id,_that.title,_that.startDate,_that.endDate,_that.description);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  DateTime startDate,  DateTime endDate,  String description)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleItem() when $default != null:
return $default(_that.id,_that.title,_that.startDate,_that.endDate,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScheduleItem implements ScheduleItem {
  const _ScheduleItem({required this.id, required this.title, required this.startDate, required this.endDate, required this.description});
  factory _ScheduleItem.fromJson(Map<String, dynamic> json) => _$ScheduleItemFromJson(json);

@override final  String id;
@override final  String title;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  String description;

/// Create a copy of ScheduleItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleItemCopyWith<_ScheduleItem> get copyWith => __$ScheduleItemCopyWithImpl<_ScheduleItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduleItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,startDate,endDate,description);
}

@override
String toString() {
    return 'ScheduleItem(id: $id, title: $title, startDate: $startDate, endDate: $endDate, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ScheduleItemCopyWith<$Res> implements $ScheduleItemCopyWith<$Res> {
  factory _$ScheduleItemCopyWith(_ScheduleItem value, $Res Function(_ScheduleItem) _then) = __$ScheduleItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime startDate, DateTime endDate, String description
});




}
/// @nodoc
class __$ScheduleItemCopyWithImpl<$Res>
    implements _$ScheduleItemCopyWith<$Res> {
  __$ScheduleItemCopyWithImpl(this._self, this._then);

  final _ScheduleItem _self;
  final $Res Function(_ScheduleItem) _then;

/// Create a copy of ScheduleItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startDate = null,Object? endDate = null,Object? description = null,}) {
  return _then(_ScheduleItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ChatMessage {

 String get id; String get threadId; String get sender; String get text; DateTime get sentAt;
/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageCopyWith<ChatMessage> get copyWith => _$ChatMessageCopyWithImpl<ChatMessage>(this as ChatMessage, _$identity);

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChatMessage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessage&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.threadId, _this.threadId) || other.threadId == _this.threadId)&&(identical(other.sender, _this.sender) || other.sender == _this.sender)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.sentAt, _this.sentAt) || other.sentAt == _this.sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChatMessage;
  return Object.hash(runtimeType,_this.id,_this.threadId,_this.sender,_this.text,_this.sentAt);
}

@override
String toString() {
  final _this = this as ChatMessage;
  return 'ChatMessage(id: ${_this.id}, threadId: ${_this.threadId}, sender: ${_this.sender}, text: ${_this.text}, sentAt: ${_this.sentAt})';
}


}

/// @nodoc
abstract mixin class $ChatMessageCopyWith<$Res>  {
  factory $ChatMessageCopyWith(ChatMessage value, $Res Function(ChatMessage) _then) = _$ChatMessageCopyWithImpl;
@useResult
$Res call({
 String id, String threadId, String sender, String text, DateTime sentAt
});




}
/// @nodoc
class _$ChatMessageCopyWithImpl<$Res>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._self, this._then);

  final ChatMessage _self;
  final $Res Function(ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? threadId = null,Object? sender = null,Object? text = null,Object? sentAt = null,}) {
  return _then(ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessage].
extension ChatMessagePatterns on ChatMessage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessage value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessage value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String threadId,  String sender,  String text,  DateTime sentAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.threadId,_that.sender,_that.text,_that.sentAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String threadId,  String sender,  String text,  DateTime sentAt)  $default,) {final _that = this;
switch (_that) {
case _ChatMessage():
return $default(_that.id,_that.threadId,_that.sender,_that.text,_that.sentAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String threadId,  String sender,  String text,  DateTime sentAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessage() when $default != null:
return $default(_that.id,_that.threadId,_that.sender,_that.text,_that.sentAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessage implements ChatMessage {
  const _ChatMessage({required this.id, required this.threadId, required this.sender, required this.text, required this.sentAt});
  factory _ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);

@override final  String id;
@override final  String threadId;
@override final  String sender;
@override final  String text;
@override final  DateTime sentAt;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageCopyWith<_ChatMessage> get copyWith => __$ChatMessageCopyWithImpl<_ChatMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.threadId, threadId) || other.threadId == threadId)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.text, text) || other.text == text)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,threadId,sender,text,sentAt);
}

@override
String toString() {
    return 'ChatMessage(id: $id, threadId: $threadId, sender: $sender, text: $text, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageCopyWith<$Res> implements $ChatMessageCopyWith<$Res> {
  factory _$ChatMessageCopyWith(_ChatMessage value, $Res Function(_ChatMessage) _then) = __$ChatMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String threadId, String sender, String text, DateTime sentAt
});




}
/// @nodoc
class __$ChatMessageCopyWithImpl<$Res>
    implements _$ChatMessageCopyWith<$Res> {
  __$ChatMessageCopyWithImpl(this._self, this._then);

  final _ChatMessage _self;
  final $Res Function(_ChatMessage) _then;

/// Create a copy of ChatMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? threadId = null,Object? sender = null,Object? text = null,Object? sentAt = null,}) {
  return _then(_ChatMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,threadId: null == threadId ? _self.threadId : threadId // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
