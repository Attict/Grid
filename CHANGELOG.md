### Version 7.0.3.0-beta

* Updated for WoW 7.0 (Legion)
* Added options for offline and wrong zone groups

### Version 6.2.0.1754-beta

* Updated ToC for 6.2
* Fixed autolayout by group: it now shows as many groups as needed to show the highest group with an online player in it when in group mode. (ticket #795)
* Another fix for pets not being displayed (ticket #798)
* Fix for right-click menu enabled on startup despite setting (ticket #807)
* Fix for layout when in a party (not raid) in the world

### Version 6.0.3.1746-beta

* Layout size is now based on the maximum group size for the current instance, rather than the actual group size, to resolve several issues (ticket #795)
* Fixed pets not being displayed when using the By Group layout (ticket #798)
* Fixed the Low Mana Warning status not activating (ticket #780)

#### Known issues in this version

* The background frame does not always resize itself correctly when the group size changes in combat.
* Some group members may still be hidden if your raid is full (20 players in a mythic raid, 30 players in other difficulties) but you have arranged your raid groups so that not all groups are full (eg. only 2 players in group 1). If you use this kind of group arrangement, please post a ticket or in the forum thread to let me know.

### Version 6.0.3.1740-beta

* Fixed a number of layout-related issues
* Fixed an error when switching profiles (ticket #783)
* Fixed an issue with the Center Icon size (ticket #785)
* Fixed an issue with the Mouseover status sticking or activating randomly (ticket #791)
* Added a status to display Stagger on monks (thanks Greltok!)

### Version 6.0.3.1714-beta

* There is now only one "Raid" layout selection, and the built-in layouts will automatically adjust to match your current instance type and group size.
* There is now a "By Role" layout that will group players by their assigned tank/healer/damager roles.
* There are no longer separate "w/ Pets" layouts; use the "Show Pets" option on the Layout tab to add pets to any of the built-in layouts.

-------------------

### Version 6.0.3.1710

* Temporary fix for raid difficulty detection: LFR, Normal, and Heroic will use your chosen "Flexible Raid" layout, and Mythic will use your "25 Player Raid" layout. In the near future, all built-in layouts will automatically adjust their size for your current raid, and there will only be one "Raid" layout setting.
* Fixed an issue with right-click bindings in Clique (ticket #747)
* Fixed the Mouseover status not triggering when "Show Tooltip" was set to "Never" (ticket #770)
* Fixed another issue with status counts (eg. aura stacks) (ticket #768)
* Fixed the Resurrection status (ticket #745)

#### Known issues in this version:

* WoW is currently reporting incoming heal and absorb amounts that are much too small, so Grid will also show incoming heal and absorb amounts that are much too small. There is nothing I can do about this other than wait for Blizzard to fix the problem on their end.

-------------------

### Version 6.0.2.1699

* **General:**
* Fixed the options for changing the frame height/width
* **Statuses:**
* Fixed the Mouseover status (ticket #748)
* Fixed the icons for the Role and Master Looter statuses
* Fixed the appearance of the Group Leader, Group Assistant, and Master Looter statuses when shown on icon-type indicators
* **Indicators:**
* Fixed the Healing Bar indicator
* Fixed the Center Icon indicator showing stack counts of 0 or 1
* Fixed an error that could sometimes occur when using the Health Bar Color indicator
* Fixed count property not being passed to indicators (ticket #741)
* [API] All default indicators are now reset before any third-party indicators

### Version 6.0.2.1679

* Fixed center icon intercepting mouse clicks
* Removed debug prints triggered by outdated layout plugins
* Removed outdated spell name auto-completion library

### Version 6.0.2.1674

* Updated for WoW 6.0
* Updated Clique support
* Added status modules for Group Leader, Raid Assistant, Master Looter, and Raid Icon
* [API] GridStatus now calls :UpdateAllUnits (if it exists) on status modules when resetting them.
* [API] There is now an API for indicators. See the project page for details.

### Version 5.4.7.1653

* Added Soulstone support to the Incoming Resurrection status
* Added an option to choose a layout to use in Flex Raids (Greltok)
* Improved options layout for statuses with multiple colors (Greltok)
* Most statuses will no longer try to update for units not in visible range (ticket #714)
* Moved Grid's options to the standard Interface Options window, with an option to prefer the old standalone window
* Removed combined count/duration option for aura text (feel free to use a plugin if you want to spam yourself)
* [API] GridRoster's IsGUIDInRaid method has been renamed to IsGUIDInGroup. The old name still exists as an alias, but plugins are encouraged to update anyway.

### Version 5.4.1.1628

* Fixed dispellable debuff detection for priests with Mass Dispel
* Added a combined count/duration display for aura text (Mikk)

### Version 5.3.0.1621

* Fixed switching to the "None" layout

### Version 5.3.0.1618

* Moved the drag tab up slightly to avoid overlapping the backdrop
* Fixed an issue causing the Center Icon indicator to appear behind the frame
* Fixed the icon display for the Unit Name status
* Added support for druids dispelling diseases with Cleanse via Symbiosis cast on a paladin

### Version 5.3.0.1611

* Fixed a frame layering issue
* Fixed an error that occurred when switching profiles while using the "show duration" option for auras

### Version 5.3.0.1606

* Fixed errors caused by missing files

### Version 5.3.0.1604

* Updated for WoW 5.3
* Fixed the "Show tab" option (thanks Greltok)
* Fixed the "Enable right-click menu" option on login (ticket #696)

### Version 5.2.0.1600

* Added a basic status module for absorbs
* Added an option to enable the standard right-click unit menu
* Added clamp insets to allow the frame borders to be offscreen
* Fixed dispel capability detection for druids, and for warlocks with imps
* Fixed the "World Raid as 40 Player" option (thanks Greltok)
* Fixed the default aura status for Eternal Flame
* Fixed errors from the resurrection status module

### Version 5.2.0.1573

* Fixed an error in WoW 5.2

### Version 5.2.0.1571

* Updated for WoW 5.2
* Added an in-game Help panel with basic info, tips, and FAQs
* Added a 40-Player Raid layout setting
* Added a By Class 40 layout
* Added an option to use the 40-Player Raid layout while in a raid group outside of an instance
* Added an option to change the layout frame background texture
* Removed the "Clamp to screen" option; the frame is now permanently clamped, since there's no real reason to allow it to be moved off-screen
* Changed the "Hide tab" and "Hide minimap icon" option to "Show tab" and "Show minimap icon" -- translators should verify the localization of these options

### Version 5.0.5.1554

* Updated for WoW 5.1

### Version 5.0.5.1552

* Fixed an issue causing delays in updating for group changes in battlegrounds (ticket #631)
* Fixed an issue causing blank indicators after switching profiles ([ticket #661]](http://www.wowace.com/addons/grid/tickets/661/))
* Fixed an issue causing Grid not to reappear when leaving a pet battle due to PvP combat

### Version 5.0.5.1548

* Fixed some issues with old custom aura statuses

### Version 5.0.5.1539

* Fixed pet battle hiding so that Grid stays properly hidden when the None layout is selected (ticket #648).

### Version 5.0.5.1537

* Added default buffs for monks.
* Added an option to show the Debuff Type statuses only when your character can dispel them.
* Grid is now hidden during pet battles (ticket #643).
* Status opacity now has its own option, instead of being part of the status color option.
* Fixed an issue with range checking while solo (ticket #627).
* Fixed an issue causing icons to be hidden on auras with duration text or coloring enabled (ticket #644).
* Removed backwards compatibility with WoW 4.x.
* The Resurrect status module now uses LibResInfo-1.0.
* Added partial Italian localization from kappesante and Holydeath1984.
* Removed the Class Filter and Range Filter options for statuses. This was announced on the download page and in the forum thread months ago, and nobody presented any compelling arguments for keeping these options, but if you missed the announcements, and this change ruins your life, please come to the WowAce forum thread and tell us why they were useful.

### Version 5.0.4.1520

* Fixed a bug in the Ready Check module (ticket #626)

### Version 5.0.4.1517

* Updated for WoW 5.0.4
* The "Minimum Value" setting for the Incoming Heals status is now a percentage of the unit's maximum health, rather than a fixed value.
* Fixed the text color when disabling the "Invert text color" option.
* Fixed range checking on dead targets for monks.
* Fixed the Resurrection module's handling of res casts on targets who already had a res available.
* Fixed errors in Spanish clients (ticket #611).
* Added monks to the By Class layouts.
* Added the Blizzard raid bar texture.
* Increased the default font size from 11 to 12.
* Increased the default width of the config frame to prevent random wrapping bugs.
* [API] Status parameter may be passed as either the traditional argument list, or as a table.
* [API] Status "range" parameter is now treated as a boolean, not a number.
