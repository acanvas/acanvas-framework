library rockdot_framework.google;

import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:convert' show json;
import "package:googleapis_auth/auth_browser.dart";
import 'package:googleapis/plus/v1.dart';

/* Rockdot depends on StageXL */
import 'package:stagexl/stagexl.dart' show HtmlObject;
import 'package:rockdot_commons/rockdot_commons.dart' show RdSignal;
import 'package:rockdot_spring/rockdot_spring.dart'
    show IObjectPostProcessor, IObjectFactory;

import 'core.dart';
import 'core.plugin.state.dart' show StateMessageVO;
import 'plugin.io.dart' show DataRetrieveVO;

part 'plugin/google/google_plugin.dart';
part 'plugin/google/command/event/vo/google_login_vo.dart';
part 'plugin/google/command/abstract_google_command.dart';
part 'plugin/google/command/google_init_command.dart';
part 'plugin/google/command/google_login_command.dart';
part 'plugin/google/command/google_plus_get_user_command.dart';
part 'plugin/google/command/google_plus_people_get_command.dart';
part 'plugin/google/command/google_plus_share_render_command.dart';
part 'plugin/google/command/event/google_events.dart';
part 'plugin/google/inject/google_model_injector.dart';
part 'plugin/google/inject/i_google_model_aware.dart';
part 'plugin/google/model/google_model.dart';

/* Experimental */
part 'plugin/google/command/speech_api_alpha/google_speech_rest_command.dart';
