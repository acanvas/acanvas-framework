part of rockdot_dart;



	/**
	 * Copyright (2009 as c), Jung von Matt/Neckar
	 *
	 * @author	Thomas Eckhardt
	 * @since	15.06.2009 13:33:27
	 *
	 * Diese Klasse soll als Vorlage für Textfelder dienen.
	 * Sie überschreibt ein paar Default-Werte lässt aber
	 * eine beliebige Konfiguration zu.
	 *
	 * Beispiel: dynamic TextField tf = new CoreTextField( "Hello World", new TextFormat( "Arial", 11, 0x0 ), true, { width:100, embedFonts:false } );
	 *
	 */
	 class UITextField extends TextField {

		/**
		 * Konstruktor
		 *
		 * @param	value		Der Text mit dem das Textfeld gefüllt werden soll
		 * @param	format 		Das Standard Textformat
		 * @param	html		Soll es sich um ein HTML-Textfeld handeln (Default: true)
		 * @param	properties	Ein Objekt das alle Eigenschaften eines Textfelds definieren kann
		 *
		 * @throws	Error		Falls über properties eine Eigenschaft gesetzt wird, die in der Klasse TextField nicht implementiert ist
		 */
	 UITextField(String value,TextFormat format,[bool html=true]) : super(){

	   defaultTextFormat = format;

			// Standardwerte für dynamische Textfelder setzen
			displayAsPassword = false;
			type = TextFieldType.DYNAMIC;
			maxChars = 0;
		//	restrict = null;

			// Mouse-Interaktion
			//mouseWheelEnabled = false;
			mouseEnabled = false;
			//selectable = false;

			// Textfeldverhalten
			autoSize = TextFieldAutoSize.LEFT;
			wordWrap = true;
			multiline = true;

			// Schriftbild
			//TODO fix embedding autodetection
			//embedFonts = true;//ApplicationFontProxy.EMBED_FONT(format.font);
			//defaultTextFormat = format;
			//this.setTextFormat(format);
			//antiAliasType = AntiAliasType.ADVANCED;
			//gridFitType = GridFitType.SUBPIXEL;
			//sharpness = 0;
			//thickness = 0;

			// Dekorationen
			background = false;
			backgroundColor = 0x0;
			border = false;
			borderColor = 0x0;

			// Text
//			if (html) {
				//condenseWhite = true;
				//htmlText = value;
	//		} else {
				text = value;
//			}

			// Interpretation der übergebenen Eigenschaften
//			if ( properties != null ) {
//				for ( String p in properties ) {
//					if ( this.hasOwnProperty(p) ) {
//						this[ p ] = properties[ p ];
//						// log.info("-------- " + p +" = "+ properties[ p ] );
//					} else {
//						log.warn("The CoreTextField class does not implement this property or method. (Property=" + p + ", Value=" + properties[ p ] + ")");
//					}
//				}
//			}
		}
		int get color {
			return (defaultTextFormat.color);
		}
		void set color(int value) {
			TextFormat format = defaultTextFormat;
			format.color = value;
			defaultTextFormat = (format);
		}
		bool get underline {
			return defaultTextFormat.underline;
		}
		void set underline(bool value) {
			TextFormat format = defaultTextFormat;
			format.underline = value;
			defaultTextFormat = (format);
		}

		@override
		double get width {
			return textWidth;
		}
		@override
		double get height {
			return textHeight;
		}

	}

