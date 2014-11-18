library stagexl_rockdot;

@MirrorsUsed( metaTargets: const[Retain])
import 'dart:mirrors';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:convert';
import 'dart:async';
import "package:googleapis_auth/auth_browser.dart"; 
import 'package:googleapis/plus/v1.dart';

/* required by Logger, configuration in Bootstrap */
import 'package:logging/logging.dart' as logging;

/* Rockdot depends on StageXL */
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_commons/stagexl_commons.dart';
import 'package:stagexl_spring/stagexl_spring.dart';

/* required by Rockdot UGCPlugin */
//import 'package:jsonrpc2/jsonrpc_client.dart';
/* required by RockdotConstants to decode URLVARs */
//import 'package:base64_codec/base64_codec.dart';
//import 'package:rockdart/facebook/facebook.dart';


// CORE #####
part 'src/core/project/abstract_bootstrap.dart';
part 'src/core/project/abstract_project.dart';

part 'src/core/context/rockdot_application_context.dart';
part 'src/core/context/rockdot_context_helper.dart';

part 'src/core/mvc/command_vo.dart';
part 'src/core/mvc/composite_command_with_event.dart';
part 'src/core/mvc/core_command.dart';


part 'src/core/model/countries.dart';
part 'src/core/model/languages.dart';
part 'src/core/model/markets.dart';
part 'src/core/model/rockdot_constants.dart';


// LIBRARY #####

/* required by Rockdot UGCPlugin */
part 'src/core/rpc/dispatcher.dart';
part 'src/core/rpc/jsonrpc_client.dart';
part 'src/core/rpc/jsonrpc_service.dart';
part 'src/core/rpc/rpc_exceptions.dart';


// PLUGINS #####

//facebook
part 'src/plugin/facebook/facebook_plugin.dart';
part 'src/plugin/facebook/command/abstract_fbcommand.dart';
part 'src/plugin/facebook/command/fbfriends_get_command.dart';
part 'src/plugin/facebook/command/fbfriends_get_info_command.dart';
part 'src/plugin/facebook/command/fbinit_browser_command.dart';
part 'src/plugin/facebook/command/fblogin_browser_command.dart';
part 'src/plugin/facebook/command/fblogout_browser_command.dart';
part 'src/plugin/facebook/command/fbphoto_get_albums_command.dart';
part 'src/plugin/facebook/command/fbphoto_get_from_album_command.dart';
part 'src/plugin/facebook/command/fbphoto_upload_command.dart';
part 'src/plugin/facebook/command/fbprompt_invite_browser_command.dart';
part 'src/plugin/facebook/command/fbprompt_share_command.dart';
part 'src/plugin/facebook/command/fbtest_command.dart';
part 'src/plugin/facebook/command/fbuser_get_info_command.dart';
part 'src/plugin/facebook/command/fbuser_get_info_permissions_command.dart';
part 'src/plugin/facebook/command/event/fbevents.dart';
part 'src/plugin/facebook/command/event/vo/vofbinvite.dart';
part 'src/plugin/facebook/command/event/vo/vofbphoto_upload.dart';
part 'src/plugin/facebook/command/event/vo/vofbshare.dart';
part 'src/plugin/facebook/inject/fbmodel_injector.dart';
part 'src/plugin/facebook/inject/i_fbmodel_aware.dart';
part 'src/plugin/facebook/model/fbmodel.dart';
part 'src/plugin/facebook/model/vo/fbalbum_vo.dart';
part 'src/plugin/facebook/model/vo/fbcomment_vo.dart';
part 'src/plugin/facebook/model/vo/fbphoto_vo.dart';
part 'src/plugin/facebook/model/vo/fbuser_vo.dart';

//google
part 'src/plugin/google/google_plugin.dart';
part 'src/plugin/google/command/abstract_google_command.dart';
part 'src/plugin/google/command/google_init_command.dart';
part 'src/plugin/google/command/google_login_command.dart';
part 'src/plugin/google/command/google_plus_get_user_command.dart';
part 'src/plugin/google/command/google_plus_moments_get_command.dart';
part 'src/plugin/google/command/google_plus_people_get_command.dart';
part 'src/plugin/google/command/google_plus_share_render_command.dart';
part 'src/plugin/google/command/event/google_events.dart';
part 'src/plugin/google/inject/google_model_injector.dart';
part 'src/plugin/google/inject/i_google_model_aware.dart';
part 'src/plugin/google/model/google_model.dart';

//io
part 'src/plugin/io/command/event/vo/io_image_upload_vo.dart';
part 'src/plugin/io/command/event/io_events.dart';
part 'src/plugin/io/command/io_image_upload_command.dart';
part 'src/plugin/io/io_plugin.dart';
part 'src/plugin/io/model/data_proxy.dart';
part 'src/plugin/io/model/data_retrieve_vo.dart';

//screen
part 'src/plugin/screen/displaylist/view/rockdot_managed_sprite_component.dart';
part 'src/plugin/screen/displaylist/view/rockdot_sprite_component.dart';
part 'src/plugin/screen/screen_displaylist_plugin.dart';
part 'src/plugin/screen/common/screen_plugin_base.dart';
part 'src/plugin/screen/common/command/abstract_screen_command.dart';
part 'src/plugin/screen/common/command/screen_plugin_init_command.dart';
part 'src/plugin/screen/common/command/screen_resize_command.dart';
part 'src/plugin/screen/common/command/event/screen_events.dart';
part 'src/plugin/screen/common/inject/i_screen_model_aware.dart';
part 'src/plugin/screen/common/inject/screen_plugin_injector.dart';
part 'src/plugin/screen/common/inject/screen_service_aware.dart';
part 'src/plugin/screen/common/model/screen_constants.dart';
part 'src/plugin/screen/common/model/screen_model.dart';
part 'src/plugin/screen/common/service/abstract_screen_service.dart';
part 'src/plugin/screen/common/service/i_screen_service.dart';
part 'src/plugin/screen/common/view/i_screen.dart';
part 'src/plugin/screen/displaylist/command/screen_appear_command.dart';
part 'src/plugin/screen/displaylist/command/screen_apply_effect_in_command.dart';
part 'src/plugin/screen/displaylist/command/screen_apply_effect_out_command.dart';
part 'src/plugin/screen/displaylist/command/screen_disappear_command.dart';
part 'src/plugin/screen/displaylist/command/screen_init_command.dart';
part 'src/plugin/screen/displaylist/command/screen_set_command.dart';
part 'src/plugin/screen/displaylist/command/screen_transition_run_command.dart';
part 'src/plugin/screen/displaylist/command/screen_transition_prepare_command.dart';
part 'src/plugin/screen/displaylist/command/event/screen_displaylist_events.dart';
part 'src/plugin/screen/displaylist/command/event/vo/screen_displaylist_appear_disappear_vo.dart';
part 'src/plugin/screen/displaylist/command/event/vo/screen_displaylist_effect_apply_vo.dart';
part 'src/plugin/screen/displaylist/command/event/vo/screen_displaylist_transition_apply_vo.dart';
part 'src/plugin/screen/displaylist/command/event/vo/screen_displaylist_transition_prepare_vo.dart';
part 'src/plugin/screen/displaylist/service/screen_displaylist_service.dart';

//state
part 'src/plugin/state/command/abstract_state_command.dart';
part 'src/plugin/state/command/state_address_set_command.dart';
part 'src/plugin/state/command/state_back_command.dart';
part 'src/plugin/state/command/state_forward_command.dart';
part 'src/plugin/state/command/state_plugin_init_command.dart';
part 'src/plugin/state/command/state_request_command.dart';
part 'src/plugin/state/command/state_set_command.dart';
part 'src/plugin/state/command/state_set_params_command.dart';
part 'src/plugin/state/command/event/state_events.dart';
part 'src/plugin/state/command/event/vo/state_change_vo.dart';
part 'src/plugin/state/command/event/vo/state_message_vo.dart';
part 'src/plugin/state/inject/i_state_model_aware.dart';
part 'src/plugin/state/inject/state_model_injector.dart';
part 'src/plugin/state/model/state_model.dart';
part 'src/plugin/state/model/state_constants.dart';
part 'src/plugin/state/model/vo/state_vo.dart';
part 'src/plugin/state/service/i_address_service.dart';
part 'src/plugin/state/service/basic_address_service.dart';
part 'src/plugin/state/service/swfaddress_service.dart';
part 'src/plugin/state/state_plugin.dart';

//ugc
part 'src/plugin/ugc/ugcplugin.dart';
part 'src/plugin/ugc/command/abstract_ugccommand.dart';
part 'src/plugin/ugc/command/gaming_check_permission_to_play_command.dart';
part 'src/plugin/ugc/command/gaming_check_permission_to_play_locale_command.dart';
part 'src/plugin/ugc/command/gaming_get_games_command.dart';
part 'src/plugin/ugc/command/gaming_get_highscore_command.dart';
part 'src/plugin/ugc/command/gaming_save_game_command.dart';
part 'src/plugin/ugc/command/gaming_set_score_at_level_command.dart';
part 'src/plugin/ugc/command/gaming_set_score_command.dart';
part 'src/plugin/ugc/command/task_get_categories_command.dart';
part 'src/plugin/ugc/command/task_get_tasks_by_category_command.dart';
part 'src/plugin/ugc/command/ugccomplain_command.dart';
part 'src/plugin/ugc/command/ugccreate_item_command.dart';
part 'src/plugin/ugc/command/ugccreate_item_container_command.dart';
part 'src/plugin/ugc/command/ugcdelete_command.dart';
part 'src/plugin/ugc/command/ugcfilter_item_command.dart';
part 'src/plugin/ugc/command/ugcfriends_read_command.dart';
part 'src/plugin/ugc/command/ugcget_likers_command.dart';
part 'src/plugin/ugc/command/ugchas_extended_user_command.dart';
part 'src/plugin/ugc/command/ugchas_extended_user_today_command.dart';
part 'src/plugin/ugc/command/ugcinit_command.dart';
part 'src/plugin/ugc/command/ugclike_command.dart';
part 'src/plugin/ugc/command/ugcmail_send_command.dart';
part 'src/plugin/ugc/command/ugcrate_command.dart';
part 'src/plugin/ugc/command/ugcread_item_command.dart';
part 'src/plugin/ugc/command/ugcread_item_container_command.dart';
part 'src/plugin/ugc/command/ugcread_item_containers_by_ui_dcommand.dart';
part 'src/plugin/ugc/command/ugcregister_command.dart';
part 'src/plugin/ugc/command/ugcregister_extended_command.dart';
part 'src/plugin/ugc/command/ugctest_command.dart';
part 'src/plugin/ugc/command/ugctrack_invite_command.dart';
part 'src/plugin/ugc/command/ugcunlike_command.dart';
part 'src/plugin/ugc/command/event/gaming_events.dart';
part 'src/plugin/ugc/command/event/ugcevents.dart';
part 'src/plugin/ugc/command/event/vo/ugcdata_vo.dart';
part 'src/plugin/ugc/command/event/vo/ugcfilter_vo.dart';
part 'src/plugin/ugc/command/event/vo/ugcrating_vo.dart';
part 'src/plugin/ugc/inject/i_ugcmodel_aware.dart';
part 'src/plugin/ugc/inject/ugcmodel_injector.dart';
part 'src/plugin/ugc/model/ugcgaming_model.dart';
part 'src/plugin/ugc/model/ugcmodel.dart';
part 'src/plugin/ugc/model/dto/ugc_audio_item_dto.dart';
part 'src/plugin/ugc/model/dto/ugc_game_dto.dart';
part 'src/plugin/ugc/model/dto/ugc_image_item_dto.dart';
part 'src/plugin/ugc/model/dto/ugc_item_container_role_dto.dart';
part 'src/plugin/ugc/model/dto/ugc_item_container_dto.dart';
part 'src/plugin/ugc/model/dto/ugc_item_dto.dart';
part 'src/plugin/ugc/model/dto/ugc_task_dto.dart';
part 'src/plugin/ugc/model/dto/ugc_text_item_dto.dart';
part 'src/plugin/ugc/model/dto/ugc_user_extended_dto.dart';
part 'src/plugin/ugc/model/dto/ugc_user_dto.dart';
part 'src/plugin/ugc/model/dto/ugc_video_item_dto.dart';


