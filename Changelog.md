#### 8.3.1
* Clicking a specie on tracker or map now will show you a pet on the journal if you own any of that specie.

#### 8.3.0
* Updated for Visions of N'Zoth.
* World Map: tracking type dropdown is currently not fully functional.

##### 8.2.2
* Now shows specie source in all pet tooltips.
* Fixed bug in rival journal.

##### 8.2.1
* Fixed issue with Mechagon Island and Nazjatar preventing pet species from appearing.

##### 8.2.0
* Updated for World of Warcraft patch 8.2.
* Updated species and rival database.

##### 8.1.2
* Updated for World of Warcraft patch 8.1.5.

##### 8.1.1
* General:
  * Fixed settings starting up issue causing many different bugs.
* World Map:
  * Added option to hide rival portraits in the interface options.

##### 8.1.0
* General:
  * Updated for Tides of Vengeance.
* World Map:
  * Updated points of interest.

##### 8.0.6
* World Map:
  * Added points of interest (pets, stables and rivals) to the two new continents.
* Journal:
  * Redesigned rival map artwork.
  * Tabs and rival selection now play sound effects like the rest of the journal.
* Config:
  * Added patron list. See patreon.com/jaliborc to learn how to join the list.
  * The "defaults" button now actually resets the addon settings. It also restarts the tutorial.
  * All panels now have icons.
* Technical:
  * Optional and load on demand modules now only contain a .toc file. All source code is in the main directory.
  * Framework reconstructions in the configuration code to support the patrons list.


##### 8.0.5
* Fixed issue with pet related world quest pins.
* Hopefully fixed Twitch packaging issue.

##### 8.0.4
* World Map:
  * Fixed 2 minor bugs.
* Rivals:
  * Fixed error at the end of a rival battle.
  * Fixed issue with battle history display.

##### 8.0.3
* World Map:
  * Now shows rival locations and their portraits everywhere.
  * Fixed Dalaran, Nagrand (Draenor) and Shadowmoon Valley (Draenor).
  * Improved pin scaling with zoom and different maps.
  * Changing the filtering options in one map now updates the others.
* Rivals:
  * Nicer pin location button on the map.
  * Removed some wrongly classified elite pets belonging to tamers from the list.

##### 8.0.2
* World Map:
  * Filter box now hides when pets are not being tracked.
  * Fixed start error message.
* Rivals:
  * Fixed visual issue.
  * Rival zone map is back.
  * The map is now fully interactive and displays the player and party members locations.
* Other:
  * Fixed an assortment of minor issues.
  * No longer show pet locations on the flight map (yes, that was unintentionally a thing).
  * There are still issues with some zones, such as Dalaran and Nagrand.
  * Zone Map doesn't update yet when filters are changed.
  * 99% appears functional as intended, so tagging release.

##### 8.0.1 (barebones)
* This is a **barebones release**!
  * All of the submodules are back: Journal, Upgrades, Breeds and Config.
  * Yet, not all of the features are currently running.
* World Map:
  * Filter box and tracking type toggle options are back.
  * Stables locations are back.
* Config:
  * Redesigned the FAQ.

#### 8.0.0 (barebones)
* Updated for Battle for Azeroth
* This is a **barebones release**!
  * Only the most basic features of PetTracker are running: Zone Tracker and World Map.
  * None of the submodules are included (Config, Breeds, etc).
* World Map:
  * Pet pins are now also displayed on the *Zone/Battlefield Map*.
	* Any custom made map that uses the new internal map canvas drawing logic is now supported.
* Zone Tracker
  * Fixed a positioning issue when only pets are being tracked.

##### 7.3.0
* Updated for Shadow of Argus
  * Database updated
* World map world quest filtering options are now displayed properly

##### 7.1.4
* Fixed minor issue with dropdown frame

##### 7.1.3
* Rivals:
  * Fixed the level of some tamers, mistakenly marked as lvl 1
  * Added a few missing teams

##### 7.1.2
* World Map:
  * Now ignores pet store, promotion and TCG pets.
* Rivals:
  * Minor bugfix.

##### 7.1.1
* Rivals:
  * Should now create much less taint in the Collections Journal.

#### 7.1.0
* Updated for Return to Kharazan
* World Map:
  * Fixed missing dark lines in multi-pet tooltip.
* Rivals:
  * Added several Legion pet tamers and elite teams.
  * Encounters with a single pet will now properly display their pet type in the encounter list.
  * Can now handle pets with no known breed data for stats computation or no known location.

##### 7.0.3
* Added remaining pet location in Broken Isles.
* Added multiple rivals in the Broken Isles and a few from Draenor.

##### 7.0.2
* Added pets in Suramar, Highmountain, Val'sharah, Stormheim, Azsuna.

##### 7.0.1
* Fixed widely reported error message, caused by new pet source.
* Fixed issue with tutorials and tamer gossip option to open the Rivals tab.
* The close button on the Rivals tab now properly closes the journal.
* Updated database.

#### 7.0.0
* Updated for Legion prepatch
* Rival tabs changed order

##### 6.2.6
* World Map:
  * You can now filter pets by ability names.
  * Fixed issue causing dropdown to appear at the bottom of the screen sometimes.
  * Fixed bug that caused errors when filtering pets with a few special characters.
  * Improved search suggestion box interaction with dropdown menus.
* Zone Tracker:
  * Fixed issue with positioning issue with instance objectives.

##### 6.2.5
* Small bug fixes.
* Now takes into account the nerf to wild pets when computing breeds.

##### 6.2.4
* Added new pet locations and rivals, including legendaries from Tanaan Jungle.

##### 6.2.3
* Fixed issue detecting wild pet breeds.
* Quality filtering should now work in german servers.

##### 6.2.2
* Fixed many species locations.
* Added new rival.
* Fixed error in Rival Journal.

##### 6.2.1
* "Tell Me About Yourself" gossip option is working again.
* The tamer journal is now fully translatable.

#### 6.2
* Updated for Fury of Hellfire

##### 6.1.3
* Added french translations ^^(thanks to HipNoTiK)^
* Rivals:
  * Minor bugfixes.

##### 6.1.2
* Rivals:
  * Added King and Queen Floret.
  * Should no longer have problems displaying recorded fights with missing pets.
* World Map:
  * Minor tooltip bugfix.

##### 6.1.1
* Rivals:
  * Small bugfixes.

##### 6.1.0
* Updated for WoW patch 6.1
* Rivals:
  * Now located next to the Pet Journal tab.
  * Now shows a proper title and icon independently of the previous displayed tab.

##### 6.0.17
* Fixed issue causing some rivals to not be visible.
* Isle of Thunder stable masters now display on the correct locations.

##### 6.0.16
* Hot hotfix.

##### 6.0.15
* Hopefully fixed taining issues.
* World map tooltip now properly scales with map resizing addons.
* Minor bugfixes.

##### 6.0.14
* Rivals on the garrison are now shown to be on the correct zone according to faction and not always on Lunarfall.

##### 6.0.13
* Added garrison rival pets from quests and dailies.
* Search on russian locales now working much better.

##### 6.0.12
* Enemy Actions:
  * Now it is much easier to drag the frame when unlocked.

##### 6.0.11
* General:
  * Updated draenor data. Now includes all tamers and pet locations!

##### 6.0.10
* Rivals:
  * Fixed issue causing rival gossip information option to not show up.

##### 6.0.9
* General:
  * Updated database with new information from Draenor.
  * Russian localization update.

##### 6.0.8
* World map:
  * Fixed issue causing tooltips to be possible for tooltips to overlap.
* Objectives:
  * Now prepared for compatibility with addons that also append themselves to the tracker.
* Rivals:
  * Added some missing celestials.
* General:
  * Added italian localization (by Tharktan).

##### 6.0.7
* World Map:
  * Fixed issue tainting objectives frame and preventing clicks on quest items.
* Rivals:
  * Added Tommy Newcomer to the list.

##### 6.0.6
* Zone Tracker:
  * Should no longer corrupt the objectives frame, preventing quest items from being clicked on.
  * Now adapts to the remaining screen space to limit the number of pets to be displayed.
* General:
  * Pet sources should now be properly detected on german servers.
  * Updated pet locations database.

##### 6.0.5
* Fixed bugs affecting tamer history panel and preventing new battles from being saved.
* Fixed issue preventing tamer gossip option from appearing.
* Chinese locales updated by adavak.

##### 6.0.4
* Fixed many minor bugs.

##### 6.0.3
* Fixed error appearing at login in some situations.
* The objective tracker now limits the number of pets it shows at the same time to ensure it fits on the screen.

##### 6.0.2
* Fixed issue causing tutorials to appear on every login session.

##### 6.0.1 (beta)
* Updated database with some information from Draenor. A lot missing though, expect to get it when the expansion comes out.
* Got rid of LibPetBreedInfo, which was not being properly updated. Now PetTracker has it's own breed database.
* Fixed some issues introduced by the new patch.

##### 6.0.0 (beta)
* General:
  * The addon is now ready for Warlords of Draenor expansion.
  * Ingame FAQ and tutorials updated to the revamped interface and featuring some of the new features.
  * As such, most of the tutorial and FAQ localizations had to be deleted. Looking for translators!
  * Some portuguese and spanish localizations added
* World Map:
  * Adapted the pet browsing experience to the new world map layout.
  * The pet filtering bar now only shows if there are actual pets to filter.
* Zone Tracker:
  * Adapted to the revamped objectives tracker.
  * Options are now found by clicking on the *Battle Pets* header.
* Enemy Actions:
  * Now draggable. Kind of works, but it is hard to select the actions. Plan to improve upon this.

##### 5.4.26
* General:
  * Talking to a tamer now provides a gossip option to see his/hers information in the journal.
  * Large internal changes to afford the new features.
* Journal:
  * Tamer _History_ tab is now fully functional, showing previous fights and allowing to quickly load previously used teams.
  * If one opens the journal for the first time while in combat, the tamer tab is not available until the end of combat to avoid security issues.

##### 5.4.25
* World Map:
  * No longer shows tamer pets as collectible species.
  * Now still displays objectives on normal map when Carbonite is enabled.

##### 5.4.24
* Journal:
  * Added elite pets as tamers (ex: Beasts of Fable)
  * Tamers now display the continent they are in and may be searched by continent name
  * Fixed an issue causing pet stats to not be displayed

##### 5.4.23
* Journal:
  * Tamers can now be searched by zone, quest completed status and rewards.
  * Tamer display has been redesigned and divided into three tabs: _Team_, _Location_ and _History_.
  * More information is now displayed, such as zone name and related quest information.
  * _Location_ provides a map of where to find the trainer.
  * _History_ on development and planned for future release.

##### 5.4.22
* Breeds:
  * Fixed issue with petchat  links and tooltips on the auction house.

##### 5.4.21
* Breeds:
  * Fixed issue with auction house pet tootlips

##### 5.4.20
* Breeds:
  * Fixed issue causing stack overflows.

##### 5.4.19
* World Map:
  * Hopefully fixed more inconsistencies with tamer icons behaviour.

##### 5.4.18
* World Map:
  * Fixed bug affecting some machines when clicking on tamers icons.

##### 5.4.17
* Breeds:
  * Fixed minor bug.

##### 5.4.16
* World Map:
  * Now tamer blips are marked when their related quests have been completed for the day.
  * Clicking on a tamer blip will now open the tamer journal.

##### 5.4.15
* Fixed incompatibility with Carbonite causing small lockups and lag when using both addons (requires Carbonite 5.4.2-Alpha-2 or above).

##### 5.4.14
* Battles:
  * Fixed issue causing sometimes breeds not to be properly computed during combat.

##### 5.4.13
* World Map
  * Added new common search.
  * Fixed issue making dropdown menu unclickable in fullscreen.

##### 5.4.12
* Breeds:
  * Fixed small bug.
* Battle:
  * Fixed conflict with some addons.

##### 5.4.11 (beta)
* Enemies abilities are now properly displayed in PvP battles, thanks to a new pet battle tracking mechanism!
  * When it's not possible to determine the enemy's ability for a given slot, both possible spells are displayed side by side.
  * As battle progresses, more abilities are detected and their cooldowns shown.
* Now the Zone Tracker is interactive: clicking on listed pets will open their section on the Pet Journal.
* Fixed issue causing World Map options dropdown to not be visible while in fullscreen mode.

##### 5.4.10
* General:
  * Updated german localization (by Drizorpala - WoW Raider)
  * Minor bug fixes
* Map:
  * Solved taint issues caused by the extended dropdown menu.
* Breeds:
  * Fixed incompatibilities with PetBattleTeams and PetBattleMaster.
* Added missing species.
  * Bugfixes.

##### 5.4.9
* Breeds:
  * Solved minor bug.
* Tamer Journal:
  * Now more load on demand.

##### 5.4.8
* Journal and Breeds:
  * Hopefully solved all intrusive taint.

##### 5.4.7
* Tagging as release.

##### 5.4.6 (beta)
* Journal:
  * First take on the Tamer Journal empty space: now displays daily quest status and rewards! More features to come.
  * Fixed issue causing quality of tamer pets to appear of lower quality than they are.
  * Added dirty hack to prevent a Blizzard issue from causing dialog errors to pop up.

##### 5.4.6 (beta)
* Journal:
  * Added support tamers located at instances/scenarios (i.e: Celestial Tournament)
* General:
  * Updated chinese translations ^^(thanks to Adavak)^^

##### 5.4.5 (beta)
* World Map:
  * Removed some incorrect pet locations.
  * Fixed issue causing tamer pets to count torwards total number of species in any given zone.

##### 5.4.4 (beta)
* Config:
  * Added missing files.

##### 5.4.3 (beta)
* General:
  * Added missing folders, which contain all the features announced last version!
* World Map:
  * Added missing stable master in Valley of the Four Winds.

##### 5.4.2 (beta)
* New Modules:
  * _Breeds_: displays breeds in the Pet Journal, while in battle and on tooltips using a never seen before symbology!
  * _Config_: _load on demand_ options menu, tutorial and in-game FAQ!
* Alerts (now Upgrades):
  * The wild upgrade alert box is now optional.
  * Added option to quickly forfeit battles when no wild upgrades are available.

##### 5.4.1
* General:
  * Added Isle of Thunder missing pets.

##### 5.4.0
* General:
  * Updated for patch Siege of Ogrimmar.
  * Small bugfixes.

##### 5.3.20
* General:
  * Fixed critical issue on the internal system introduced last version.
  * Small internal optimization.

##### 5.3.19
* Alerts:
  * Glow box now stays hidden for the entire battle after having been hidden once.
  * Several bugfixes and performance improvements.
* Switcher:
  * Fixed issue causing wrong levels to be displayed.
  * No longer shows modifier icons for abilities with no offensive capabilities (eg: Evanescence)

##### 5.3.18
* Alerts:
  * Moved alert popup back to it's old location.

##### 5.3.17
* World Map:
  * Pet tamer extra information now works on all locales!
  * Fixed issues preventing information to be shown for some tamers (eg: MacDonald)

##### 5.3.16
* Battle:
  * Fixed lua error introduced last version.

##### 5.3.15
* General:
  * Added russian translations ^^(by mozgin and Pascal_tgn)^^.
* World Map:
  * Fixed issue causing errors when clicking on pet locations.
* Tamer Journal:
  * Pets are now displayed in the correct order.
  * Fixed issue preventing Journal from being open on uncommon situations.

##### 5.3.14
* General:
  * Added missing LibPetBreedInfo.
  * Updated LibPetJournal.
  * Reduced download size.
* Alerts:
  * Fixed issue preventing bangs from being hidden after having been displayed.

##### 5.3.13
* Tamer Journal:
  * The search bar is now fully funtional, allowing to search tamers by names, pet types and levels.
  * The tab now only loads when it's actually open for the first time, saving loading time.
* World Map:
  * Added missing suwmmer pet, the Qiraji Guardling.
  * Fixed issue with search by level.

##### 5.3.12 (beta)
* Tamer Journal:
  * Now displays families for trainers with a dominant family type.
* World Map:
  * Largely improved filter performance - simpified implementation.

##### 5.3.11 (beta)
* World Map:
  * Now the search bar reads specie tooltips. For instance, typing "Guild" will now find pets sold by guild vendors.
* Alerts:
  * Fixed issue causing error messages on unusual situations.

##### 5.3.10 (beta)
* Alerts:
  * Fixed issue causing higher level pets of lower quality to be considered upgrades.
  * Legendary wild pets are no longer considered upgrades.
* Battle, Journal:
  * Fixed issue causing ability icons to be faded out.
  * Fixed issue causing the Tamer Journal to crash for users with PetTracker Switcher disabled.

##### 5.3.9 (beta)
* New feature:
  * Intoducing the Tamer Journal! In this journal you can see information about the teams of all existing pet tamers.
* Battle:
  * Fixed issue causing enemy actions to appear locked when in cooldown.
* General:
  * Improved database encoding, now takes 60% less memory.

##### 5.3.8 (beta)
* World Map:
  * Now displays more pet tamer information on the world map. Only on english clients for now.
  * Fixed issue causing the tooltip to not be displayed when "Show Battle Pets" is disabled.
  * Fixed wrong pet location at Krasarang Wilds.
* Zone Tracker:
  * Now maximum pet level owned is also displayed on the zone tracker.
  * Fixed issue causing objectives header to not always react properly to the tracker changes.
  * Fixed issue causing the progress bar to remain visible even when there are no pets to be tracked.
* Alerts:
  * Now takes into account pet level as well.
* General:
  * Many internal changes preparing for awesome new feature in the very near future.

##### 5.3.7
* Chinese localizations added!

##### 5.3.6
* Bugs:
  * Settings have once more been reset to hotfix an issue with the zone tracker.
  * Fixed an issue with the "Zone Tracker" checkbox in the pet journal.
* World Map:
  * Pet and stable location database has been largely optimized, taking now 25% less memory.
  * The filter suggestions box is now better placed to match the new filter location.

##### 5.3.5
* Stable master locations are now displayed on the world map!
* Settings have been reset, to prepare for the upcoming options menu.
  * Simple explanation: it was better for adding new options.
  * Technical explanation: we don't want to polute the global environment.

##### 5.3.4
* Hotfix of bug preventing the zone tracker options from being displayed.

##### 5.3.3
* In-game tutorials have been added!
* The world map pet search box has been temporarily relocated to the top right corner of the map. We're working on better solutions for the presentation of this new feature.

##### 5.3.2
* Added the new pets introduced by patch 5.3: Escalation.
* Now the world map blips properly update when changing dungeon levels.

##### 5.3.1
* The search filter is now remembered between logins.
* Hopefully fixed issues with "missing" and "not maximized" searches on non-english clients.

#### 5.3.0
* Updated for patch 5.3: Escalation.
* World map:
  * Introducing Flash Find for pet locations! Now pets can be filtered by name, type, family, source, zones and quality.
* Added spanish and portuguese localizations.

##### 5.2.3
* Fixed issue causing World Map pet blips to not update when browsing zones.

##### 5.2.2
* Largely optimized the World Map and Zone Tracker redrawing schedules. This will hopefully fix an issue causing lag spikes between zones and subzones.

##### 5.2.1
* You have asked for it, and here is it: quality glowing borders are back!
* Pet Switcher:
  * The speed/power icons were swapped. Fixed.

#### 5.2
* Updated for patch 5.2: The Thunder King
* Added new Isle of Thunder and Isle of Giants pets. Elite pets still not on the map.

##### 5.1.10
* World Map:
  * Temple of Ahn'Qiraj pets added.
* Added support for the new [[http://www.curse.com/addons/wow/pettracker-broker|PetTracker Broker]]!

##### 5.1.9 (beta)
* World Map:
  * Pets obtainable on raids and dungeons have finaly been added! Molten Core, Blackwing Lair, all is yours to explore!
  * Some missing pets have been added (ex: Cogblade Raptor).
  * Promotion pets are now ignored and no longer display in the zone tracker nor in the world map.
  * Tooltips now scale with the rest of the interface.
* Pet Switcher:
  * The enemy actions no longer hide whe the pet switcher is shown.
* Upgrade Alerts:
  * Now properly displays over the enemy pet buffs/debufs.
* This new version uses a brand new refurbished pet database. If any pet previously available happens to be missing, please post a ticket and it shall be fixed next version.

##### 5.1.8
* Pets with unexpected ability types are now distinguished on the world map.
* Added partial translations.

##### 5.1.7
* PetTracker now ignores pet locations that are clearly wrong (ie: in the unreachable sea).

##### 5.1.6
* PetTracker now supports instances! (some 5.1 pets are still missing)
* Added new pet locations.

#### 5.1.5
* The world map filter now displays which option is selected.
* The world map button is now bigger when the map is in windowed mode.

##### 5.1.4
* World map filter settings is now remembered between sessions.
* The zone tracker can now also be toggled on the right-button menu dropdown.
* The "Zone Tracker" checkbox no longer overlapps the CollectMe button.

##### 5.1.3
* Fixed type preventing the tracker progress bar from displaying correctly.

##### 5.1.2
* Added TomTom support! Now you can right click on any spot and set a waypoint in TomTom for it.
* Fixed rare visual issue with the tracker progress bar.

##### 5.1.1
* Locations for the new patch 5.1 pets added!
* Several locations of already existing pets added as well.

#### 5.1.0
* Updated for patch 5.1: Landfall!

##### 5.0.9
* The objectives tracker dropdown now has an option for showing or hiding captured pets.

##### 5.0.8
* Added winter pets.
* World map tooltip now displays all pets under the cursor.
* Reduced download size and memory usage.

##### 5.0.7
* The ZoneTracker has been remade from the ground-up:
  * The tracker now displays all pet states, instead of only the missing ones.
  * The progress bar displays all states as well.
  * The source and icon of each specie is now displayed next to each specie name.
  * The tracker can now be toggled at the journal, next to the "Find Battle" button.
  * The tracker now uses the same database as of the world map, instead of crawling the journal for information. This will result in a much better performance (as crawling the journal is slow) and more precision in the species displayed, as the journal is not always correct. Yet, the biggest advantage is that now the pet display is fully controlled by the addon, which will allow it to be improved as the pet locations display is enhanced.
* The improved pet switcher and wild upgrade alerts are now optional features!
  * If user reaction is positive, more features might become optional in the future.

##### 5.0.6
* Upgrade Alerts no longer show in non-wild battles.
* The PetSwitcher now works with ElvUI.
* Enemy pet actions no longer are hidden for one turn after switching pets.

##### 5.0.5
* Released wild upgrade alerts!
* PetSwitcher:
  * Ability types are now displayed next to ability buttons.
  * No longer can be closed after the player pet has died (because could not be opened again).
* World Map:
  * The "On/off" switcher state is now recorded between sessions.

##### 5.0.4
* World Map:
  * Reduced the number of points in too cluttered zones.
  * Improved database size - now 3 times smaller.
* Pet Switcher:
	* Added experience bar
	* Pet tooltips are now displayed when hovering pet icons.
	* Type tooltips are now displayed when hovering type icons.

##### 5.0.3
* World map tracking can now be toggled separately. Pets can be filtered by ownership status.

##### 5.0.2
* Pet quality display has been improved by far.
* World Map:
  * Pet tracking now works on all localizations!
  * Optimized pet location display performance.
  * New pet locations added.
* Pet Switcher:
  * Now displays the quality of pets as well.
  * Pet switcher can no longer be hidden in a PvP match.
  * Pet switcher can now be toggled using the switch pet button.
  * Fixed bug causing pet switcher to not disappear when a match is forfeit.

##### 5.0.1
* Released World Map pet tracking!
* Now both the pet tracker and the world map display disable themselves while the "pet tracking" option is disabled on the minimap.
* Large internal refactoring, for better performance and stability of the battle features.

#### 5.0.0
* Initial pre-release.
