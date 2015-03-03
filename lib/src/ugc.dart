library stagexl_rockdot.ugc;

@MirrorsUsed( metaTargets: const[Retain])
import 'dart:mirrors';

import 'dart:html' as html;
import 'dart:math' as math;
import 'dart:convert';

import 'package:stagexl_commons/stagexl_commons.dart';
import 'package:stagexl_spring/stagexl_spring.dart';

import 'core.dart';
import 'state.dart' show IStateModelAware, StateModel;
import 'facebook.dart' show IFBModelAware, FBModel, FBUserVO;
//import 'io.dart' show DataRetrieveVO;

part 'plugin/ugc/ugcplugin.dart';
part 'plugin/ugc/command/abstract_ugccommand.dart';
part 'plugin/ugc/command/gaming_check_permission_to_play_command.dart';
part 'plugin/ugc/command/gaming_check_permission_to_play_locale_command.dart';
part 'plugin/ugc/command/gaming_get_games_command.dart';
part 'plugin/ugc/command/gaming_get_highscore_command.dart';
part 'plugin/ugc/command/gaming_save_game_command.dart';
part 'plugin/ugc/command/gaming_set_score_at_level_command.dart';
part 'plugin/ugc/command/gaming_set_score_command.dart';
part 'plugin/ugc/command/task_get_categories_command.dart';
part 'plugin/ugc/command/task_get_tasks_by_category_command.dart';
part 'plugin/ugc/command/ugccomplain_command.dart';
part 'plugin/ugc/command/ugccreate_item_command.dart';
part 'plugin/ugc/command/ugccreate_item_container_command.dart';
part 'plugin/ugc/command/ugcdelete_command.dart';
part 'plugin/ugc/command/ugcfilter_item_command.dart';
part 'plugin/ugc/command/ugcfriends_read_command.dart';
part 'plugin/ugc/command/ugcget_likers_command.dart';
part 'plugin/ugc/command/ugchas_extended_user_command.dart';
part 'plugin/ugc/command/ugchas_extended_user_today_command.dart';
part 'plugin/ugc/command/ugcinit_command.dart';
part 'plugin/ugc/command/ugclike_command.dart';
part 'plugin/ugc/command/ugcmail_send_command.dart';
part 'plugin/ugc/command/ugcrate_command.dart';
part 'plugin/ugc/command/ugcread_item_command.dart';
part 'plugin/ugc/command/ugcread_item_container_command.dart';
part 'plugin/ugc/command/ugcread_item_containers_by_ui_dcommand.dart';
part 'plugin/ugc/command/ugcregister_command.dart';
part 'plugin/ugc/command/ugcregister_extended_command.dart';
part 'plugin/ugc/command/ugctest_command.dart';
part 'plugin/ugc/command/ugctrack_invite_command.dart';
part 'plugin/ugc/command/ugcunlike_command.dart';
part 'plugin/ugc/command/event/gaming_events.dart';
part 'plugin/ugc/command/event/ugcevents.dart';
part 'plugin/ugc/command/event/vo/ugcdata_vo.dart';
part 'plugin/ugc/command/event/vo/ugcfilter_vo.dart';
part 'plugin/ugc/command/event/vo/ugcrating_vo.dart';
part 'plugin/ugc/inject/i_ugcmodel_aware.dart';
part 'plugin/ugc/inject/ugcmodel_injector.dart';
part 'plugin/ugc/model/ugcgaming_model.dart';
part 'plugin/ugc/model/ugcmodel.dart';
part 'plugin/ugc/model/dto/ugc_audio_item_dto.dart';
part 'plugin/ugc/model/dto/ugc_game_dto.dart';
part 'plugin/ugc/model/dto/ugc_image_item_dto.dart';
part 'plugin/ugc/model/dto/ugc_item_container_role_dto.dart';
part 'plugin/ugc/model/dto/ugc_item_container_dto.dart';
part 'plugin/ugc/model/dto/ugc_item_dto.dart';
part 'plugin/ugc/model/dto/ugc_task_dto.dart';
part 'plugin/ugc/model/dto/ugc_text_item_dto.dart';
part 'plugin/ugc/model/dto/ugc_user_extended_dto.dart';
part 'plugin/ugc/model/dto/ugc_user_dto.dart';
part 'plugin/ugc/model/dto/ugc_video_item_dto.dart';