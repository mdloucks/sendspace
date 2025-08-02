// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_state.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecordState {

 List<ClimbType> get climbTypes; ClimbType? get selectedClimbType; File? get selectedVideo; String? get error; String get title; String get description; String get grade; FormStatus get status;
/// Create a copy of RecordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecordStateCopyWith<RecordState> get copyWith => _$RecordStateCopyWithImpl<RecordState>(this as RecordState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordState&&const DeepCollectionEquality().equals(other.climbTypes, climbTypes)&&(identical(other.selectedClimbType, selectedClimbType) || other.selectedClimbType == selectedClimbType)&&(identical(other.selectedVideo, selectedVideo) || other.selectedVideo == selectedVideo)&&(identical(other.error, error) || other.error == error)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(climbTypes),selectedClimbType,selectedVideo,error,title,description,grade,status);

@override
String toString() {
  return 'RecordState(climbTypes: $climbTypes, selectedClimbType: $selectedClimbType, selectedVideo: $selectedVideo, error: $error, title: $title, description: $description, grade: $grade, status: $status)';
}


}

/// @nodoc
abstract mixin class $RecordStateCopyWith<$Res>  {
  factory $RecordStateCopyWith(RecordState value, $Res Function(RecordState) _then) = _$RecordStateCopyWithImpl;
@useResult
$Res call({
 List<ClimbType> climbTypes, ClimbType? selectedClimbType, File? selectedVideo, String? error, String title, String description, String grade, FormStatus status
});




}
/// @nodoc
class _$RecordStateCopyWithImpl<$Res>
    implements $RecordStateCopyWith<$Res> {
  _$RecordStateCopyWithImpl(this._self, this._then);

  final RecordState _self;
  final $Res Function(RecordState) _then;

/// Create a copy of RecordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? climbTypes = null,Object? selectedClimbType = freezed,Object? selectedVideo = freezed,Object? error = freezed,Object? title = null,Object? description = null,Object? grade = null,Object? status = null,}) {
  return _then(_self.copyWith(
climbTypes: null == climbTypes ? _self.climbTypes : climbTypes // ignore: cast_nullable_to_non_nullable
as List<ClimbType>,selectedClimbType: freezed == selectedClimbType ? _self.selectedClimbType : selectedClimbType // ignore: cast_nullable_to_non_nullable
as ClimbType?,selectedVideo: freezed == selectedVideo ? _self.selectedVideo : selectedVideo // ignore: cast_nullable_to_non_nullable
as File?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormStatus,
  ));
}

}


/// @nodoc


class _RecordState implements RecordState {
  const _RecordState({final  List<ClimbType> climbTypes = const [], this.selectedClimbType, this.selectedVideo, this.error, this.title = '', this.description = '', this.grade = '', this.status = FormStatus.loading}): _climbTypes = climbTypes;
  

 final  List<ClimbType> _climbTypes;
@override@JsonKey() List<ClimbType> get climbTypes {
  if (_climbTypes is EqualUnmodifiableListView) return _climbTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_climbTypes);
}

@override final  ClimbType? selectedClimbType;
@override final  File? selectedVideo;
@override final  String? error;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  String grade;
@override@JsonKey() final  FormStatus status;

/// Create a copy of RecordState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecordStateCopyWith<_RecordState> get copyWith => __$RecordStateCopyWithImpl<_RecordState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecordState&&const DeepCollectionEquality().equals(other._climbTypes, _climbTypes)&&(identical(other.selectedClimbType, selectedClimbType) || other.selectedClimbType == selectedClimbType)&&(identical(other.selectedVideo, selectedVideo) || other.selectedVideo == selectedVideo)&&(identical(other.error, error) || other.error == error)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_climbTypes),selectedClimbType,selectedVideo,error,title,description,grade,status);

@override
String toString() {
  return 'RecordState(climbTypes: $climbTypes, selectedClimbType: $selectedClimbType, selectedVideo: $selectedVideo, error: $error, title: $title, description: $description, grade: $grade, status: $status)';
}


}

/// @nodoc
abstract mixin class _$RecordStateCopyWith<$Res> implements $RecordStateCopyWith<$Res> {
  factory _$RecordStateCopyWith(_RecordState value, $Res Function(_RecordState) _then) = __$RecordStateCopyWithImpl;
@override @useResult
$Res call({
 List<ClimbType> climbTypes, ClimbType? selectedClimbType, File? selectedVideo, String? error, String title, String description, String grade, FormStatus status
});




}
/// @nodoc
class __$RecordStateCopyWithImpl<$Res>
    implements _$RecordStateCopyWith<$Res> {
  __$RecordStateCopyWithImpl(this._self, this._then);

  final _RecordState _self;
  final $Res Function(_RecordState) _then;

/// Create a copy of RecordState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? climbTypes = null,Object? selectedClimbType = freezed,Object? selectedVideo = freezed,Object? error = freezed,Object? title = null,Object? description = null,Object? grade = null,Object? status = null,}) {
  return _then(_RecordState(
climbTypes: null == climbTypes ? _self._climbTypes : climbTypes // ignore: cast_nullable_to_non_nullable
as List<ClimbType>,selectedClimbType: freezed == selectedClimbType ? _self.selectedClimbType : selectedClimbType // ignore: cast_nullable_to_non_nullable
as ClimbType?,selectedVideo: freezed == selectedVideo ? _self.selectedVideo : selectedVideo // ignore: cast_nullable_to_non_nullable
as File?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FormStatus,
  ));
}


}

// dart format on
