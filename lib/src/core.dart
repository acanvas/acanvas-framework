library stagexl_rockdot.core;

@MirrorsUsed( metaTargets: const[Retain])
import 'dart:mirrors';
import 'dart:html' as html;
import 'dart:math' as math;
import 'dart:convert';
import 'dart:async';

/* required by Logger, configuration in Bootstrap */
import 'package:logging/logging.dart' as logging;

/* Rockdot depends on StageXL */
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_commons/stagexl_commons.dart';
import 'package:stagexl_spring/stagexl_spring.dart';

import 'state.dart' show StateConstants, StateMessageVO, StateEvents, StateVO;
import 'screen.dart' show ScreenConstants, RockdotManagedSpriteComponent;

export 'screen.dart';
export 'state.dart';
export 'io.dart' show DataRetrieveVO;

/* required by Rockdot UGCPlugin */
//import 'package:jsonrpc2/jsonrpc_client.dart';
/* required by RockdotConstants to decode URLVARs */
//import 'package:base64_codec/base64_codec.dart';
//import 'package:rockdart/facebook/facebook.dart';

// CORE #####
part 'core/project/abstract_bootstrap.dart';
part 'core/project/abstract_plugin.dart';

part 'core/context/rockdot_application_context.dart';
part 'core/context/rockdot_context_helper.dart';

part 'core/mvc/command_vo.dart';
part 'core/mvc/composite_command_with_event.dart';
part 'core/mvc/core_command.dart';

part 'core/model/countries.dart';
part 'core/model/languages.dart';
part 'core/model/markets.dart';
part 'core/model/rockdot_constants.dart';


// LIBRARY #####

/* required by Rockdot UGCPlugin */
part 'core/rpc/dispatcher.dart';
part 'core/rpc/jsonrpc_client.dart';
part 'core/rpc/jsonrpc_service.dart';
part 'core/rpc/rpc_exceptions.dart';
