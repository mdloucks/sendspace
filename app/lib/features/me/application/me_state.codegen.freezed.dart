// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'me_state.codegen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MeState {

 AsyncValue<ProfilesRow> get profile; AsyncValue<List<PostsRow>> get posts;
/// Create a copy of MeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeStateCopyWith<MeState> get copyWith => _$MeStateCopyWithImpl<MeState>(this as MeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.posts, posts) || other.posts == posts));
}


@override
int get hashCode => Object.hash(runtimeType,profile,posts);

@override
String toString() {
  return 'MeState(profile: $profile, posts: $posts)';
}


}

/// @nodoc
abstract mixin class $MeStateCopyWith<$Res>  {
  factory $MeStateCopyWith(MeState value, $Res Function(MeState) _then) = _$MeStateCopyWithImpl;
@useResult
$Res call({
 AsyncValue<ProfilesRow> profile, AsyncValue<List<PostsRow>> posts
});




}
/// @nodoc
class _$MeStateCopyWithImpl<$Res>
    implements $MeStateCopyWith<$Res> {
  _$MeStateCopyWithImpl(this._self, this._then);

  final MeState _self;
  final $Res Function(MeState) _then;

/// Create a copy of MeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profile = null,Object? posts = null,}) {
  return _then(_self.copyWith(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as AsyncValue<ProfilesRow>,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<PostsRow>>,
  ));
}

}


/// @nodoc


class _MeState implements MeState {
  const _MeState({required this.profile, required this.posts});
  

@override final  AsyncValue<ProfilesRow> profile;
@override final  AsyncValue<List<PostsRow>> posts;

/// Create a copy of MeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeStateCopyWith<_MeState> get copyWith => __$MeStateCopyWithImpl<_MeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeState&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.posts, posts) || other.posts == posts));
}


@override
int get hashCode => Object.hash(runtimeType,profile,posts);

@override
String toString() {
  return 'MeState(profile: $profile, posts: $posts)';
}


}

/// @nodoc
abstract mixin class _$MeStateCopyWith<$Res> implements $MeStateCopyWith<$Res> {
  factory _$MeStateCopyWith(_MeState value, $Res Function(_MeState) _then) = __$MeStateCopyWithImpl;
@override @useResult
$Res call({
 AsyncValue<ProfilesRow> profile, AsyncValue<List<PostsRow>> posts
});




}
/// @nodoc
class __$MeStateCopyWithImpl<$Res>
    implements _$MeStateCopyWith<$Res> {
  __$MeStateCopyWithImpl(this._self, this._then);

  final _MeState _self;
  final $Res Function(_MeState) _then;

/// Create a copy of MeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? posts = null,}) {
  return _then(_MeState(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as AsyncValue<ProfilesRow>,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as AsyncValue<List<PostsRow>>,
  ));
}


}

// dart format on
