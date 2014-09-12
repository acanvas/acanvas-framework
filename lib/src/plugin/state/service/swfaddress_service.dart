part of rockdot_dart;




	/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */
	 class SWFAddressService extends BasicAddressService implements IAddressService{
		 String _defaultTitle;
		 Function _callback;
	 SWFAddressService() {
		}

		@override void init()
		 {
		  window.onHashChange.listen(_onSWFAddressChange);
			_defaultTitle = document.title;
		  _onSWFAddressChange();
		} 
		
		void _onSWFAddressChange([HashChangeEvent e = null])
		 {
		  var hash = window.location.hash;
		  if(hash.length > 0 && hash[0] == "#") hash = hash.substring(1);
			new RockdotEvent(StateEvents.STATE_REQUEST, hash, _callback).dispatch();
		}

		@override void changeAddress(String url,[Function callback=null])
		 {
			_callback = callback;
			if (url.contains("http"))
			 window.open(url, "_blank");
			else
			  window.location.hash = url;
		}

		@override void onAddressChanged(StateVO vo)
		 {
		  
			document.title= (_defaultTitle + " - " + vo.title);
			super.onAddressChanged(vo);
		}
	}

