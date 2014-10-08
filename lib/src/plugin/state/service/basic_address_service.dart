part of stagexl_rockdot;




	/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */
	 class BasicAddressService implements IAddressService{ void init()
		 {} void changeAddress(String url,[Function callback=null])
		 {
			new RockdotEvent(StateEvents.STATE_REQUEST, url).dispatch();
		} void onAddressChanged(StateVO vo)
		 {}


	}

