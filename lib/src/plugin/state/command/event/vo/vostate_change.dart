part of rockdot_dart;
	/**
	 * @author Nils Doehring (nilsdoehring(gmail as at).com)
	 */
	 class VOStateChange extends RockdotVO {
		 StateVO oldVO;
		 StateVO newVO;
	 VOStateChange(StateVO oldVO,StateVO newVO) {
			this.oldVO = oldVO;
			this.newVO = newVO;
		}
	}

