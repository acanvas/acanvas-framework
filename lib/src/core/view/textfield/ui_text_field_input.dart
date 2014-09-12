part of rockdot_dart;

	/**
	 * Copyright (2009 as c), Jung von Matt/Neckar
	 * All rights reserved.
	 *
	 * @author	Thomas Eckhardt
	 * @since	22.07.2009 12:11:50
	 */

	 class UITextFieldInput extends UITextField
	{
		/*
		 * Konstruktor
		 * 
		 * @param value			Der Text mit dem das Textfeld gefüllt werden soll
		 * @param format 		Das Standard Textformat
		 * @param properties	Ein Objekt das alle Eigenschaften eines Textfelds definieren kann
		 */
	 UITextFieldInput(String value,TextFormat format):super( value, format, false )
		{
			// Setze die Standardeigenschaften eines Input-Feldes sofern diese nicht im Objekt
			// "properties" übergeben wurde.
			
			type = TextFieldType.INPUT;
			//selectable = true;
			mouseEnabled = true;
			autoSize = TextFieldAutoSize.NONE;
			wordWrap = false;
			multiline = false;

			
			
		}
	 
    //TODO implement restrict
    String restrict= "";

    //TODO implement selectable
    bool selectable = false;
	}

