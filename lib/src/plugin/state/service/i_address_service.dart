part of rockdot_dart;

	/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */
	 abstract class IAddressService { void init()
		; void changeAddress(String url,[Function callback=null])
		; void onAddressChanged(StateVO event)
		;
	}

