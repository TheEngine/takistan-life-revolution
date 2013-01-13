A_DEBUG_ON 		= true;
A_FA_DEBUG_ON 	= true;

A_DEBUG	= {
		if (A_DEBUG_ON) then {
				if ((typeName _this) == "STRING") then {
						server globalChat _this;
					} else {
						hint "A_DEBUG: NON STRING PASS";
					};
			};
	};

A_FA_DEBUG = {
		if (A_FA_DEBUG_ON) then {
				_this call A_DEBUG;
			};
	};