package com.thingsiam.utils
{
	import flash.text.TextFormat;
	import flash.utils.describeType;
	
	public class Typography
	{		
		public static function tfToStyleSheet( tf:TextFormat ):Object
		{	//not necessarily comprehensive, but mostly matches TextFormat attributes to the object format StyleSheets expect
			//marginLeft => leftMargin is my favorite
			var style:Object = new Object();
			for each( var param in describeType(tf).child("accessor") )
			{
				switch(param.@name.toString())
				{
					case "color":
						style["color"] = '#'+tf[param.@name].toString(16);
					break;
					case "font":
						style["fontFamily"] = tf[param.@name];
					break;
					case "size":
						style["fontSize"] = tf[param.@name];
					break;
					case "bold":
						style["fontWeight"] = tf[param.@name] ? "bold" : "normal";
					break;
					case "italic":
						style["fontStyle"] = tf[param.@name] ? "italic" : "normal";
					break;
					case "leftMargin":
						style["marginLeft"] = tf[param.@name];
					break;
					case "rightMargin":
						style['marginRight'] = tf[param.@name];
					break;
					default:
						style[param.@name] = tf[param.@name];
					break;
				}
			}
			
			return style;
		}
	}
}