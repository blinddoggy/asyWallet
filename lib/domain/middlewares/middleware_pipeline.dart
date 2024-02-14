class MiddlewarePipeline {
  final List<MiddlewareValidation> _middlewares = [];
  bool isDuplicated = false;

  void addMiddleware(MiddlewareValidation middleware) {
    _middlewares.add(middleware);
  }

  String? executePipeline() {
    for (final middleware in _middlewares) {
      if (middleware.validation() && !isDuplicated) {
        isDuplicated = true;
        return middleware.redirectTo;
      }
    }
    isDuplicated = false;
    return null;
  }
}

class MiddlewareValidation {
  final String redirectTo;
  final bool Function() validation;
  final String? name;
  final String? description;

  MiddlewareValidation({
    required this.redirectTo,
    required this.validation,
    this.name,
    this.description,
  });
}
