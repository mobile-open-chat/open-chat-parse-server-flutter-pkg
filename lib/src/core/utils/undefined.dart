/// This is a helper for copyWith functions.

const undefined = Object();

/// If [param] not passed to [copyWith] function its value will be [undefined].
/// So we can differentiate between null parameter and not passed parameter.
bool isNotPassedParameter(Object? param) => param == undefined;
