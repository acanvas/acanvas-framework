part of stagexl_rockdot;










	/**
	 * @flowerModelElementId _0eA1EC9LEeG0Qay4mHgS6g
	 */
	 class UGCPlugin extends AbstractOrderedFactoryPostProcessor{
		 static const String MODEL_UGC = "MODEL_UGC";
		 Logger _log = new Logger("UGCPlugin");

		 UGCPlugin():super(40) {

		}


		@override IOperation postProcessObjectFactory(IObjectFactory objectFactory)
		{

			/* Objects */
			RockdotContextHelper.registerClass(objectFactory, MODEL_UGC, UGCModel, true);

			/* Object Postprocessors */
			objectFactory.addObjectPostProcessor(new UGCModelInjector(objectFactory));


			/* Commands */
			Map commandMap = new Map();

			/* AMF */
			commandMap[ UGCEvents.CREATE_ITEM ] = UGCCreateItemCommand;
			commandMap[ UGCEvents.READ_ITEM ] = UGCReadItemCommand;

			commandMap[ UGCEvents.READ_ITEM_CONTAINER ] = UGCReadItemContainerCommand;
			commandMap[ UGCEvents.READ_ITEM_CONTAINERS_UID ] = UGCReadItemContainersByUIDCommand;
			commandMap[ UGCEvents.CREATE_ITEM_CONTAINER ] = UGCCreateItemContainerCommand;

			/* Gaming */
			commandMap[ GamingEvents.SET_SCORE_AT_LEVEL] = GamingSetScoreAtLevelCommand;
			commandMap[ GamingEvents.GET_HIGHSCORE ] = GamingGetHighscoreCommand;
			commandMap[ GamingEvents.GET_GAMES ] = GamingGetGamesCommand;
			commandMap[ GamingEvents.CHECK_PERMISSION_TO_PLAY ] = GamingCheckPermissionToPlayCommand;
			commandMap[ GamingEvents.CHECK_PERMISSION_TO_PLAY_LOCALE ] = GamingCheckPermissionToPlayLocaleCommand;
			commandMap[ GamingEvents.SAVE_GAME ] = GamingSaveGameCommand;

			/* UGC (User Generated Content) */
			commandMap[ UGCEvents.INIT ] = UGCInitCommand;
			commandMap[ UGCEvents.TEST ] = UGCTestCommand;
			commandMap[ UGCEvents.USER_REGISTER ] = UGCRegisterCommand;
			commandMap[ UGCEvents.USER_REGISTER_EXTENDED ] = UGCRegisterExtendedCommand;
			commandMap[ UGCEvents.USER_HAS_EXTENDED ] = UGCHasExtendedUserCommand;
			commandMap[ UGCEvents.USER_HAS_EXTENDED_TODAY ] = UGCHasExtendedUserTodayCommand;

			commandMap[ UGCEvents.ITEM_LIKE ] = UGCLikeCommand;
			commandMap[ UGCEvents.ITEM_UNLIKE ] = UGCUnlikeCommand;
			commandMap[ UGCEvents.ITEM_RATE ] = UGCRateCommand;

			commandMap[ UGCEvents.ITEM_COMPLAIN ] = UGCComplainCommand;
			commandMap[ UGCEvents.ITEM_DELETE ] = UGCDeleteCommand;
			commandMap[ UGCEvents.ITEMS_FILTER] = UGCFilterItemCommand;
			commandMap[ UGCEvents.ITEMS_FRIENDS_GET ] = UGCFriendsReadCommand;
			commandMap[ UGCEvents.ITEM_LIKERS_GET ] = UGCGetLikersCommand;
			commandMap[ UGCEvents.USER_MAIL_SEND ] = UGCMailSendCommand;

			commandMap[ UGCEvents.TRACK_INVITE ] = UGCTrackInviteCommand;

			commandMap[ UGCEvents.TASK_GET_CATEGORIES ] = TaskGetCategoriesCommand;
			commandMap[ UGCEvents.TASK_GET_TASK_BY_CATEGORY ] = TaskGetTasksByCategoryCommand;

			RockdotContextHelper.registerCommands(objectFactory, commandMap);


			/* Bootstrap Command */
			RockdotConstants.getBootstrap().add( UGCEvents.INIT );


			return null;
		}


	}

