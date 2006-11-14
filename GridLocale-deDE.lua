local L = AceLibrary("AceLocale-2.2"):new("Grid")

local strings_deDE = {
	--{{{ GridCore
	["Debugging"] = "Debuggen",
	["Module debugging menu."] = "Debug-Men\195\188",
	["Debug"] = "Debug",
	["Toggle debugging for %s."] = "Aktiviere das Debuggen f\195\188r %s.",
	
	--}}}
	--{{{ GridFrame
	["Frame"] = "Rahmen",
	["Options for GridFrame."] = "Einstellungen die Grid-Rahmen",

	-- ["Show Tooltip"] = true,
	-- ["Show unit tooltip.  Choose 'Always', 'Never', or 'OOC'."] = true,
	-- ["Always"] = true,
	-- ["Never"] = true,
	-- ["OOC"] = true,
	-- ["Center Text Length"] = true,
	-- ["Number of characters to show on Center Text indicator."] = true,
	["Invert Bar Color"] = "Invetiere die Leistenfarbe",
	["Swap foreground/background colors on bars."] = "Tausche die Vordergrund-/Hintergrundfarbe der Leisten",

	-- ["Indicators"] = true,
	["Border"] = "Rand",
	["Health Bar"] = "Gesundheitsleiste",
	["Center Text"] = "Text im Zentrum",
	["Center Icon"] = "Icon im Zentrum",
	["Top Left Corner"] = "Obere linke Ecke",
	["Top Right Corner"] = "Obere rechte Ecke",
	["Bottom Left Corner"] = "Untere linke Ecke",
	["Bottom Right Corner"] = "Untere rechte Ecke",
	-- ["Frame Alpha"] = true,

	-- ["Options for %s indicator."] = true,
	-- ["Statuses"] = true,
	-- ["Toggle status display."] = true,

	--}}}
	--{{{ GridLayout
	["Layout"] = "Anordnung",
	["Options for GridLayout."] = "Optionen f�r die GridAnordnung.",

	-- Layout options
	["Show Frame"] = "Zeige den Rahmen",
	["Sets when the Grid is visible: Choose 'Always', 'Grouped', or 'Raid'."] = "Setzt die Sichtbarkeit von Grid: W\195\164hle 'immer', 'in Gruppe', oder 'in Schlachtzug'.",
	["Always"] = "immer",
	["Grouped"] = "in Gruppe",
	["Raid"] = "in Schlachtzug",
	["Raid Layout"] = "Schlachtzug-Anordnung",
	["Select which raid layout to use."] = "W\195\164hle welche Schlachtzug-Anordnung benutzt wird",
	["Show Party in Raid"] = "Zeige Gruppe im Schlachtzug",
	["Show party/self as an extra group."] = "Zeigen Gruppe/sich selbst als extra Gruppe an.",
	["Horizontal groups"] = "Horizontal gruppieren",
	["Switch between horzontal/vertical groups."] = "Wechselt zwischen horizontaler/verikaler Gruppierung",
	["Frame lock"] = "Rahmen sperren",
	["Locks/unlocks the grid for movement."] = "Sperrt/entsperrt den Rahmen zum Bewegen",

	-- Display options
	-- ["Padding"] = true,
	-- ["Adjust frame padding."] = true,
	["Spacing"] = "Abstand",
	["Adjust frame spacing."] = "Den Abstand anpassen.",
	["Scale"] = "Skalierung",
	["Adjust Grid scale."] = "Skalierung anpassen.",
	["Border"] = "Rand",
	["Adjust border color and alpha."] = "Anpassen der Rahmenfarbe und Transparenz.",
	["Background"] = "Hintergrund",
	["Adjust background color and alpha."] = "Anpassen der Hintergrundfarbe und Transparenz.",

	-- Advanced options
	-- ["Advanced"] = true,
	-- ["Advanced options."] = true,
	-- ["Layout Anchor"] = true,
	-- ["Sets where Grid is anchored relative to the screen."] = true,
	-- ["Group Anchor"] = true,
	-- ["Sets where groups are anchored relative to the layout frame."] = true,
	-- ["Reset Position"] = true,
	-- ["Resets the layout frame's position and anchor."] = true,

	--}}}
	--{{{ GridLayoutLayouts
	["None"] = "Keine",
	["By Group 40"] = "40er Gruppe",
	["By Group 25"] = "25er Gruppe",
	["By Group 20"] = "20er Gruppe",
	["By Group 15"] = "15er Gruppe",
	["By Group 10"] = "10er Gruppe",
	["By Class"] = "Nach Klasse",
	["Onyxia"] = "Onyxia",
	
	--}}}
	--{{{ GridRange
	-- used for getting spell range from tooltip
	-- ["(%d+) yd range"] = true,

	--}}}
	--{{{ GridStatus
	["Status"] = "Status",
	["Options for %s."] = "Optionen f\195\188r %s.",

	-- module prototype
	["Status: %s"] = "Status: %s",
	["Color"] = "Farbe",
	["Color for %s"] = "Farbe f\195\188r %s",
	["Priority"] = "Priorit\195\164t",
	["Priority for %s"] = "Priorit\195\164t f\195\188r %s",
	["Range filter"] = "Entfernungsfilter",
	["Range filter for %s"] = "Entfernungsfilter f\195\188r %s",
	["Enable"] = "Aktivieren",
	["Enable %s"] = "Aktivieren %s",
	
	--}}}
	--{{{ GridStatusAggro
	["Aggro"] = "Aggro",
	["Aggro alert"] = "Aggro-Alarm",
	
	--}}}
	--{{{ GridStatusAuras
	["Debuff type: "] = "Schw\195\164chungszauber: ",
	["Poison"] = "Gift",
	["Disease"] = "Krankheit",
	["Magic"] = "Magie",
	["Curse"] = "Fluch",
	["Add new Buff"] = "Neuen St\195\164rkungszauber hinzuf\195\188gen",
	["Adds a new buff to the status module"] = "F\195\188gt einen neuen St\195\164rkungszauber zum Status Modul hinzu",
	["Add new Debuff"] = "Neuen Schw\195\164chungszauber hinzuf\195\188gen",
	["Adds a new debuff to the status module"] = true,
	["Delete (De)buff"] = true,
	["Deletes an existing debuff from the status module"] = "F\195\188gt einen neuen Schw\195\164chungszauber zum Status Modul hinzu",
	["Remove %s from the menu"] = "Entfernt %s vom Men\195\188",
	["Debuff: "] = "Schw\195\164chungszauber: ",
	["Buff: "] = "St\195\164rkungszauber: ",

	--}}}
	--{{{ GridStatusName
	["Unit Name"] = "Namen",
	["Color by class"] = "In Klassenfarbe",
	
	--}}}
	--{{{ GridStatusMana
	["Mana threshold"] = "Mana Grenzwert",
	["Set the percentage for the low mana warning."] = "Setzt den % Grenzwert f\195\188r die Wenig-Mana Warnung",
	["Low Mana warning"] = "Wenig-Mana Warnung",
	["Low Mana"] = "Wenig Mana",
	
	--}}}
	--{{{ GridStatusHeals
	["Heals"] = "Heilungen",
	["Incoming heals"] = "eingehende Heilung",
	["(.+) begins to cast (.+)."] = "(.+) beginnt (.+) zu wirken.",
	["(.+) gains (.+) Mana from (.+)'s Life Tap."] = "(.+) bekommt (.+) Mana durch (.+)'s Lebensentzug.",
	["^Corpse of (.+)$"] = "^Corpse of (.+)$",
	
	--}}}
	--{{{ GridStatusHealth
	["Unit health"] = "Gesundheit",
	["Health deficit"] = "Gesundheitsdefizit",
	["Low HP warning"] = "Wenig-HP Warnung",
	["Death warning"] = "Todeswarnung",
	["Offline warning"] = "Offlinewarnung",
	["Health"] = "Gesundheit",
	["Show dead as full health"] = "Zeige Tote mit voller Gesundheit an",
	["Treat dead units as being full health."] = "Behandele Tote als h\195\164tten sie volle Gesundheit",
	["Use class color"] = "Benutze Klassenfarbe",
	["Color health based on class."] = "F\195\164rbe den Gesundheitsbalken in Klassenfarbe",
	["Health threshold"] = "Gesundheitsgrenzwert",
	["Only show deficit above % damage."] = "Zeige Defizit bei mehr als % Schaden",
	["Color deficit based on class."] = "F\195\164rbe das Defizit nach Klassenfarbe",
	["Low HP threshold"] = "Wenig HP Grenzwert",
	["Set the HP % for the low HP warning."] = "Setzt den % Grenzwert f\195\188r die Wenig-Gesundheit Warnung",

	--}}}
	--{{{ GridStatusRange
	["Range check frequency"] = "H\195\164ufigkeit der Reichweitensmessung",
	["Seconds between range checks"] = "Sekunden zwischen der Reichweitensmessung",
	["Out of Range"] = "Au\195\159er Reichweite",

	--}}}
	--{{{ GridStatusTarget
	["Your Target"] = "Dein Ziel",

	--}}}
}

L:RegisterTranslations("deDE", function() return strings_deDE end)
