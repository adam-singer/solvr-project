// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This is commercial software. Use or redistribution of this code in full
// or in part without the express written consent of Solvr is prohibited.

part of solvr_kernel_math_registry;

/** Kernel loader responsible for registrering functions and methods */
class Loader {
  Loader() {
    // Basic types
    _addType(ObjectTypes.OBJECT);
    // Interfaces
    _addType(InterfaceTypes.COLLECTION);
    _addType(InterfaceTypes.ALGEBRAIC_COLLECTION);
    // Collections
    _addType(ObjectTypes.DICT);
    _addType(ObjectTypes.LIST);
    _addType(ObjectTypes.MATRIX);
    _addType(ObjectTypes.SET);
    _addType(ObjectTypes.TUPLE);
    _addType(ObjectTypes.VECTOR);
    // Values
    _addType(ObjectTypes.BOOL);
    _addType(ObjectTypes.NUMBER);
    _addType(ObjectTypes.SYMBOL);

    // Important! must be called before methods are added as
    // we validate the types used in methods against the
    // type hierarchy
    _buildTypeHierarchy();

    // Load methods and functions
    _addModule(new AlgebraModule());
    _addModule(new BuiltinModule());
    _addModule(new CalculusModule());
    // TODO _addModule(new LinearAlgebraModule())
    _addModule(new NumberTheoryModule());
  }

  _addType(IType newType) {
    if(_types.containsKey(newType)) {
      throw new KernelError("type ${newType.simpleName} conflicts with ${_types[newType]}");
    }
    _types[newType] = new Set<SuperTypeable>();
  }

  _buildTypeHierarchy() {
    _types.forEach((IType newType, Set<IType> derives) {
      bool sameAsNew(IType t) => t == newType;
      _types.keys.forEach((SuperTypeable existingType) {
        // check if existing type implements this interface
        // if so then register it as deriving from the
        // interface - this allows us to later easily ensure
        // that methods defined in a interface is also
        // registered for types that implements it
        if(existingType.interfaces != null && existingType.interfaces.any(sameAsNew)) {
          derives.add(existingType);
        } else if(existingType.superTypes != null && existingType.superTypes.any(sameAsNew)) {
          derives.add(existingType);
        }
      });
      _logger.debug("type ${newType} is extended by ${derives}");
    });
  }

  _addModule(ModuleObject module) {
    // Functions
    module.functions.forEach((FunctionObject function) {
      if(!_globalFunctions.containsKey(function.name)) {
        _globalFunctions[function.name] = [];
      } else {
        _globalFunctions[function.name].forEach((FunctionObject existingFunction) {
          if(hasSameElements(existingFunction.expectedArgumentTypes, function.expectedArgumentTypes)) {
            throw new KernelError("Registry error: function ${function} with arguments ${existingFunction.expectedArgumentTypes} already registered by ${existingFunction.module}");
          }
        });
      }
      _logger.debug("${module} adds function: ${function.name} with arguments ${function.expectedArgumentTypes} to area [${function.area}]");
      _globalFunctions[function.name].add(function);
      // register for area
      if(!_areaFunctions.containsKey(function.area)) {
        _areaFunctions[function.area] = new Map<String, List<FunctionObject>>();
      }
      var functionForArea = _areaFunctions[function.area];
      if(!functionForArea.containsKey(function.name)) {
        functionForArea[function.name] = [];
      }
      functionForArea[function.name].add(function);
    });

    // Methods
    module.methods.forEach((MethodObject method) {
      if(!_types.containsKey(method.targetType)) {
        throw new KernelError("cannot register method ${method.name} for unknown type ${method.targetType}");
      }
      if(!_methodTypes.containsKey(method.name)) {
        _methodTypes[method.name] = new HashSet<IType>();
      } else {
        if(_methodTypes[method.name].contains(method.targetType)) {
          // We do currently not support method overloading
          throw "cannot overload method ${method.name} for ${method.targetType}";
        }
        // We do currently not support method overriding so check if any types
        // in the target hierarchy already defines the method
        for(IType superType in method.targetType.superTypes) {
          if(_methodTypes[method.name].contains(superType)) {
            throw new KernelError("cannot override method ${method.name} already defined in ${superType}");
          }
        }
      }
      _methodTypes[method.name].add(method.targetType);
      // Register this method for the target class and all classes that derives from it
      List<IType> registerFor = [ method.targetType ];
      registerFor.addAll(_types[method.targetType]);
      registerFor.forEach((IType type) {
        _logger.debug("${module} adds method: ${method.name} to type [${type}]");
        _methodMap[_fullMethodName(type, method.name)] = method;
      });
    });
  }

  FunctionObject getFunctionFor(String functionName, TupleExpr args) {
    var functions = _globalFunctions[functionName];
    var res = null;
    if(functions != null) {
      var overloaded = functions.length > 1;
      var lastSpecificity;
      functions.forEach((FunctionObject function) {
        var specificity = function.specificity(args);
        if(specificity >= 0) {
          _logger.debug("function: ${functionName} matches arguments: ${args} with specificity $specificity overloaded: $overloaded");
          if(overloaded) {
            // when overloaded always chose the most specific function
            if(res == null || specificity < lastSpecificity) {
              res = function;
              lastSpecificity = specificity;
            }
          } else {
            res = function;
            return;
          }
        } else {
          _logger.debug("function: ${functionName} does not match: ${args}");
        }
      });
    } else {
      _logger.debug("no function exists with name: ${functionName}");
    }
    return res;
  }

  MethodObject getMethodFor(String methodName, IType type) {
    final String name = _fullMethodName(type, methodName);
    if(_methodMap.containsKey(name)){
      return _methodMap[name];
    }
    return null;
  }

  String _fullMethodName(IType type, String methodName) => "${type.qualifiedName}.${methodName}";

  Iterable<AreaType> get areas => _areaFunctions.keys;

  Map<String, List<FunctionObject>> getFunctionsFor(AreaType area) => _areaFunctions[area];

  static final _logger = LoggerFactory.getLoggerFor(Loader);
  // Map<function-name, List<function-impl>>
  final _globalFunctions = new Map<String, List<FunctionObject>>();
  // Map<Area, Map<function-name, List<function-impl>>>
  final _areaFunctions = new Map<AreaType, Map<String, List<FunctionObject>>>();
  // Map<method-name, Set<types-that-defines-this-method-name>>
  final _methodTypes = new Map<String, Set<IType>>();
  // Map<full-method-name, method-impl>
  final _methodMap = new Map<String, MethodObject>();
  // Map<type, Set<types-that-extends-this-type>>
  final _types = new Map<SuperTypeable, Set<SuperTypeable>>();
}
