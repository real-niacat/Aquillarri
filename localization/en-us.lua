local function com(text)
    return { name = "Lily's comments", text = type(text) == "table" and text or { text } }
end

return {
    descriptions = {
        Mod = {
            aquillarri = {
                name = "Aquillarri",
                text = {
                    "{s:0.9}In the depths of {C:aqu_aquill_10,s:1.1}The Nilscape...{}",
                    "Aquillarri adds {E:1,C:attention}upgradable cards{}, with suitably {E:aqu_shadereffect}dramatic{} effects",
                    "and new mechanics to make upgrading more interesting",
                    "While it may not seem so, this mod is meant to be slightly in your favor.",
                    " ",
                    "This mod has many {E:1,C:aqu_aquill_2}visual effects{} that you may find intense.",
                    "If you are photosensitive, consider toggling them off in the {C:attention}config{}",
                }
            }
        },

        Joker = {
            j_aqu_particleloop1 = {
                name = "Particle Loop",
                text = { {
                    "{C:chips}+#1#{} Chips",
                }, {
                    "Retriggers self {C:attention}#3#{} times",
                    "Increases by {C:attention}#4#{} retrigger at end of round",
                    "Gives {C:attention}#2#%{} more Chips per trigger",
                } } --i really, really hate how this is worded, but i don't know how i could do it better
            },
            j_aqu_particleloop2 = {
                name = "Particle Loop",
                text = { {
                    "{C:chips}+#1#{} Chips",
                }, {
                    "Retriggers self {C:attention}#3#{} times",
                    "Increases by {C:attention}#4#{} retriggers at end of round",
                    "Gives {C:attention}#2#%{} more Chips per trigger",
                } }
            },
            j_aqu_particleloop3 = {
                name = "Particle Loop",
                text = { {
                    "{C:chips}+#1#{} Chips",
                    "{X:chips,C:white}X#5#{} Chips"
                }, {
                    "Retriggers self {C:attention}#3#{} times",
                    "Increases by {C:attention}#4#{} retriggers at end of round",
                    "Gives {C:attention}#2#%{} more Chips per trigger",
                } }
            },
            j_aqu_particleloop4 = {
                name = "Particle Loop",
                text = { {
                    "{C:chips}+#1#{} Chips",
                    "{X:chips,C:white}X#5#{} Chips"
                }, {
                    "Retriggers self {C:attention}#3#{} times",
                    "Increases by {C:attention}#4#{} retriggers at end of round",
                    "Gives {C:attention}#2#%{} more Chips per trigger",
                } }
            },
            j_aqu_particleloop5 = {
                name = "Particle Loop",
                text = { {
                    "{C:chips}+#1#{} Chips",
                    "{X:chips,C:white}X#5#{} Chips",
                }, {
                    "Retriggers self {C:attention}#3#{} times",
                    "Increases by {C:attention}#4#{} retriggers at end of round",
                    "Gives {C:attention}#2#%{} more Chips per trigger",
                } }
            },
            j_aqu_scorebound_crystal1 = {
                name = "Scorebound Crystal",
                text = {{
                    "Unscoring cards give {C:mult}+#1#{} Mult",
                }, {
                    "Scored cards give {C:chips}+#2#{} Chips",
                }, {
                    "Both effects get {C:attention}#3#%{} stronger",
                    "for each card receiving the opposite effect"
                }}
            },
            j_aqu_scorebound_crystal2 = {
                name = "Scorebound Crystal",
                text = {{
                    "Unscoring cards give {C:mult}+#1#{} Mult",
                }, {
                    "Scored cards give {C:chips}+#2#{} Chips",
                }, {
                    "Both effects get {C:attention}#3#%{} stronger",
                    "for each card receiving the opposite effect"
                }}
            },
            j_aqu_scorebound_crystal3 = {
                name = "Scorebound Crystal",
                text = {{
                    "Unscoring cards give {X:mult,C:white}X#1#{} Mult",
                }, {
                    "Scored cards give {X:chips,C:white}X#2#{} Chips",
                }, {
                    "Both effects get {C:attention}#3#%{} stronger",
                    "for each card receiving the opposite effect"
                }}
            },
            j_aqu_scorebound_crystal4 = {
                name = "Scorebound Crystal",
                text = {{
                    "Unscoring cards give {X:mult,C:white}X#1#{} Mult",
                }, {
                    "Scored cards give {X:chips,C:white}X#2#{} Chips",
                }, {
                    "Both effects get {C:attention}#3#%{} stronger",
                    "for each card receiving the opposite effect"
                }, {
                    "Leftmost played card gains a random {C:attention}Enhancement{}",
                    "{C:attention}Enhanced{} cards give {X:dark_edition,C:white}^#4#{} more {X:mult,C:white}XMult{} and {X:chips,C:white}XChips{}",
                }}
            },
            j_aqu_scorebound_crystal5 = {
                name = "Scorebound Crystal",
                text = {{
                    "Unscoring cards give {X:mult,C:white}X#1#{} Mult",
                }, {
                    "Scored cards give {X:chips,C:white}X#2#{} Chips",
                }, {
                    "Both effects get {C:attention}#3#%{} stronger",
                    "for each card receiving the opposite effect"
                }, {
                    "Leftmost played card gains a random {C:attention}Enhancement{}",
                    "{C:attention}Enhanced{} cards give {X:dark_edition,C:white}^#4#{} more {X:mult,C:white}XMult{} and {X:chips,C:white}XChips{}",
                }, {
                    "Rightmost played card gains a random {C:dark_edition}Edition{}",
                    "{C:dark_edition}Editioned{} cards give {X:dark_edition,C:white}^^#5#{} more {X:mult,C:white}XMult{} and {X:chips,C:white}XChips{}",
                }}
            },


            j_aqu_magicorb1 = {
                name = "Magic Orb",
                text = {
                    "After {C:attention}#1#{} {C:inactive}[#2#]{} cards spawned in shop,",
                    "next shop card will recieve a random {C:dark_edition}Edition{}",
                    "{C:inactive,s:0.8}(Cannot spawn {C:dark_edition,s:0.8}Negative{C:inactive,s:0.8} Jokers)",
                }
            },
            j_aqu_magicorb2 = {
                name = "Wizard's Orb",
                text = { {
                    "After {C:attention}#1#{} {C:inactive}[#2#]{} cards spawned in shop,",
                    "next shop card will recieve a random {C:dark_edition}Edition{}",
                    "{C:inactive,s:0.8}(Cannot spawn {C:dark_edition,s:0.8}Negative{C:inactive,s:0.8} Jokers)",
                }, {
                    "Increases by an extra card for each {C:dark_edition}Editioned{} Joker owned"
                },
                }
            },
            j_aqu_magicorb3 = {
                name = "Orb of the Master",
                text = { {
                    "After {C:attention}#1#{} {C:inactive}[#2#]{} cards spawned in shop,",
                    "next shop card will recieve a random {C:dark_edition}Edition{}",
                    "{C:inactive,s:0.8}(Cannot spawn {C:dark_edition,s:0.8}Negative{C:inactive,s:0.8} Jokers)",
                }, {
                    "Increases by an extra card for each {C:dark_edition}Editioned{} Joker owned",
                }, {
                    "Buying an {C:dark_edition}Editioned{} card makes the next {C:green}Reroll{} free"
                }
                }
            },

            j_aqu_magicorb4 = {
                name = "Orb of the Ancients",
                text = { {
                    "After {C:attention}#1#{} {C:inactive}[#2#]{} cards spawned in shop,",
                    "next shop card will recieve a random {C:dark_edition}Edition{}",
                    "{C:inactive,s:0.8}(Cannot spawn {C:dark_edition,s:0.8}Negative{C:inactive,s:0.8} Jokers)",
                }, {
                    "Increases by an extra card for each {C:dark_edition}Editioned{} Joker owned",
                }, {
                    "Buying an {C:dark_edition}Editioned{} card makes the next {C:green}Reroll{} free"
                }, {
                    "{C:dark_edition}Editioned{} cards have a {C:green}#3# in #4#{} chance to ",
                    "copy their {C:dark_edition}Edition{} to another card at end of round",
                    "{C:inactive}(May overwrite other Editions)",
                    "{C:inactive,s:0.8}(Cannot copy {C:dark_edition,s:0.8}Negative{C:inactive,s:0.8})"
                }
                }
            },

            j_aqu_magicorb5 = {
                name = "Orb of the Heavens",
                text = { {
                    "After {C:attention}#1#{} {C:inactive}[#2#]{} cards spawned in shop,",
                    "next shop card will recieve a random {C:dark_edition}Edition{}",
                }, {
                    "Increases by an extra card for each {C:dark_edition}Editioned{} Joker owned",
                }, {
                    "Buying an {C:dark_edition}Editioned{} card makes the next {C:green}Reroll{} free"
                }, {
                    "{C:dark_edition}Editioned{} cards have a {C:green}#3# in #4#{} chance to ",
                    "copy their {C:dark_edition}Edition{} to another card at end of round",
                    "{C:inactive}(May overwrite other Editions)",
                    "{C:inactive,s:0.8}(Cannot copy {C:dark_edition,s:0.8}Negative{C:inactive,s:0.8})"
                }, {
                    "Retrigger {C:dark_edition}Editioned{} playing cards once for every {C:dark_edition}Editioned{} Joker owned",
                }
                }
            },

            j_aqu_biava1 = {
                name = "Biblica Avaritia",
                text = { {
                    "Spends {C:money}$#1#{} at end of round to",
                    "create a random {C:uncommon}Uncommon{} or {C:rare}Rare{} Joker",
                    "{C:inactive}(Must have room)",
                } }
            },
            j_aqu_biava2 = {
                name = "Biblica Avaritia",
                text = { {
                    "Spends {C:money}$#1#{} at end of round to",
                    "create a random {C:uncommon}Uncommon{} or {C:rare}Rare{} Joker",
                    "{C:inactive}(Must have room)",
                }, {
                    "Gives {X:mult,C:white}XMult{} equal to {C:attention}#2#%{}",
                    "of your current money",
                    "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)",
                } }
            },
            j_aqu_biava3 = {
                name = "Biblica Avaritia",
                text = { {
                    "Spends {C:money}$#1#{} at end of round to",
                    "create a random {C:uncommon}Uncommon{} or {C:rare}Rare{} Joker",
                    "{C:inactive}(Must have room)",
                }, {
                    "Gives {X:mult,C:white}XMult{} equal to {C:attention}#2#%{}",
                    "of your current money",
                    "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)",
                }, {
                    "When {C:attention}Boss Blind{} defeated, destroy the Joker",
                    "to the right, and gain {C:attention}triple{} its sell value",
                } }
            },
            j_aqu_biava4 = {
                name = "Biblica Avaritia",
                text = { {
                    "Spends {C:money}$#1#{} at end of round to",
                    "create a random {C:uncommon}Uncommon{} or {C:rare}Rare{} Joker",
                    "{C:inactive}(Room not needed)",
                }, {
                    "Gives {X:mult,C:white}XMult{} equal to {C:attention}#2#%{}",
                    "of your current money",
                    "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)",
                }, {
                    "When {C:attention}Boss Blind{} defeated, destroy the Joker",
                    "to the right, and gain {C:attention}quadruple{} its sell value",
                } }
            },
            j_aqu_biava5 = {
                name = "Biblica Avaritia",
                text = { {
                    "Spends {C:money}$#1#{} when a playing card is scored to",
                    "create a random {C:uncommon}Uncommon{} or {C:rare}Rare{} Joker",
                    "{C:inactive}(Room not needed)",
                }, {
                    "Gives {X:mult,C:white}XMult{} equal to {C:attention}#2#%{}",
                    "of your current money",
                    "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)",
                }, {
                    "When {C:attention}Boss Blind{} defeated, destroy all Jokers",
                    "to the right, and gain {C:attention}quadruple{} their sell value",
                } }
            },
            j_aqu_manip1 = {
                name = "Manipulator",
                text = {{
                    "After all other scoring, played cards score",
                    "as if they were {C:attention}held-in-hand{}"
                }}
            },
            j_aqu_manip2 = {
                name = "Manipulator",
                text = {{
                    "After all other scoring, played cards score",
                    "as if they were {C:attention}held in hand{}"
                }, {
                    "After all other scoring, {C:attention}held in hand{} cards score",
                    "as if they were played"
                }}
            },
            j_aqu_manip3 = {
                name = "Manipulator",
                text = {{
                    "After scoring, played cards score",
                    "as if they were {C:attention}held in hand{}"
                }, {
                    "After scoring, {C:attention}held in hand{} cards score",
                    "as if they were played"
                }, {
                    "After scoring, cards in the {C:attention}discard pile{} have",
                    "a {C:green}#1# in #2#{} chance to score as if they were {C:attention}held in hand{}",
                }}
            },
            j_aqu_manip4 = {
                name = "Manipulator",
                text = {{
                    "After scoring, played cards score",
                    "as if they were {C:attention}held in hand{}"
                }, {
                    "After scoring, {C:attention}held in hand{} cards score",
                    "as if they were played"
                }, {
                    "After scoring, cards in the {C:attention}discard pile{} have",
                    "a {C:green}#1# in #2#{} chance to score as if they were {C:attention}held in hand{}",
                }, {
                    "After scoring, cards in the {C:attention}deck{} have",
                    "a {C:green}#1# in #2#{} chance to score as if they were played",
                }}
            },
            j_aqu_manip5 = {
                name = "Manipulator",
                text = {{
                    "After scoring, played cards score",
                    "as if they were {C:attention}held in hand{}"
                }, {
                    "After scoring, {C:attention}held in hand{} cards score",
                    "as if they were played"
                }, {
                    "After scoring, cards in the {C:attention}discard pile{} have",
                    "a {C:green}#1# in #2#{} chance to score as if they were {C:attention}held in hand{}",
                }, {
                    "After scoring, cards in the {C:attention}deck{} have",
                    "a {C:green}#1# in #2#{} chance to score as if they were played",
                }, {
                    "After scoring, score {C:attention}#3#{} random playing cards as if",
                    "they were {C:attention}held in hand{}"
                }, {
                    "After scoring, score {C:attention}#3#{} random playing cards as if",
                    "they were played"
                }}
            },
            j_aqu_perf1 = {
                name = "Perfection",
                text = {{
                    "Adds a random {C:attention}Enhanced{} {C:dark_edition}Ephemeral{} card",
                    "to played hand before scoring"
                }}
            },
            j_aqu_perf2 = {
                name = "Perfection",
                text = {{
                    "Adds a random {C:attention}Enhanced{} {C:dark_edition}Ephemeral{} card",
                    "to played hand before scoring"
                }, {
                    "Adds a random {C:attention}Enhanced{} {C:dark_edition}Ephemeral{} card",
                    "to hand before scoring"
                }}
            },
            j_aqu_perf3 = {
                name = "Perfection",
                text = {{
                    "Adds a random {C:attention}Enhanced{} {C:dark_edition}Ephemeral{} card",
                    "to played hand before scoring"
                }, {
                    "Adds a random {C:attention}Enhanced{} {C:dark_edition}Ephemeral{} card",
                    "to hand before scoring"
                }, {
                    "Adds a random {C:attention}Enhancement{} to the rightmost scoring card in hand"
                }}
            },
            j_aqu_perf4 = {
                name = "Perfection",
                text = {{
                    "Adds a random {C:attention}Enhanced{} {C:dark_edition}Ephemeral{} card",
                    "to played hand before scoring"
                }, {
                    "Adds a random {C:attention}Enhanced{} {C:dark_edition}Ephemeral{} card",
                    "to hand before scoring"
                }, {
                    "Adds a random {C:attention}Enhancement{} to all {C:attention}non-Enhanced{} scoring cards"
                }, {
                    "Create an {C:dark_edition}Ephemeral{} copy of all played cards before scoring"
                }}
            },
            j_aqu_perf5 = {
                name = "Perfection",
                text = {{
                    "Adds three random {C:attention}Enhanced{} {C:dark_edition}Ephemeral{} cards",
                    "to played hand before scoring"
                }, {
                    "Adds a random {C:attention}Enhancement{} to all {C:attention}non-Enhanced{} scoring cards"
                }, {
                    "Create an {C:dark_edition}Ephemeral{} copy of all played cards",
                    "and all cards held in hand before scoring",
                }}
            },
        },

        Back = {
            b_aqu_emc = {
                name = "EMC Deck",
                text = {
                    "Upgraded blinds are now",
                    "{C:attention}weaker{} than normal blinds",
                    "but give {C:red}negative reward bonus{}",
                }
            }
        },

        Edition = {
            e_aqu_ephemeral = {
                name = "Ephemeral",
                text = {
                    "{X:mult,C:white}X#1#{} Mult when scored",
                    "{C:chips}+#2#{} Chips when held in hand",
                    "{C:red}Destroyed{} at end of round",
                    "Always scores",
                }
            }
        },

        Other = {
            aqu_upgrade = {
                name = "Upgradable",
                text = {
                    "This card has an {C:attention}upgraded{} variant",
                    "Upgrades into {X:dark_edition,C:white}#1#{}"
                }
            },

            enables_corruption = {
                name = "Warning",
                text = {
                    "Usage of this card will enable",
                    "{C:attention}Entropic Corruption{} if it is disabled."
                }
            },
        },

        Voucher = {

            v_aqu_pyro_radioactive_plasma = {
                name = "Pyro-Radioactive Plasma",
                text = {
                    "Gives {X:dark_edition,C:white}^Mult{} based on upgraded blind exponent",
                    "Increase {C:attention}Entropic Corruption{} by {C:attention}#1#%{} after hand scores",
                    "{C:inactive}(Currently {X:dark_edition,C:white}^#2#{C:inactive} Mult)",
                }
            },
            v_aqu_hybridized_uran_astatine = {
                name = "Hybridized Uran-Astatine",
                text = {
                    "Upgraded blind exponent is substantially less effective",
                    "{C:inactive}(Does not affect {C:attention}Pyro-Radioactive Plasma{C:inactive})",
                }
            },
            v_aqu_neutronium_zero = {
                name = "Neutronium-0",
                text = {
                    "Creates a random {C:attention}Tag{} when",
                    "an upgraded blind is selected",
                }
            },

        },

        Spectral = {
            c_aqu_nilscape_portal_first = {
                name = "Nilscape Portal",
                text = {
                    "{C:attention}Upgrade{} a selected eligible Joker",
                    "{C:inactive}(Cannot go past {V:1}Tier #1#{C:inactive})",
                }
            },
            c_aqu_nilscape_portal_used = {
                name = "Nilscape Portal",
                text = {
                    "{C:attention}Upgrade{} a selected eligible Joker",
                    "{X:attention,C:white}X#2#{} Entropic Corruption gain",
                    "{C:inactive}(Cannot go past {V:1}Tier #1#{C:inactive})",
                }
            },
            c_aqu_nilscape_portal_blocked = {
                name = "Nilscape Portal",
                text = {
                    "{C:attention}Upgrade{} a selected eligible Joker",
                    "Use on a {V:1}Tier #1#{} Joker to create {C:attention}Closed Portal{}",
                    "{C:inactive}(Cannot go past {V:1}Tier #1#{C:inactive})",
                }
            },
            c_aqu_nilscape_portal_blocked_enabled = {
                name = "Nilscape Portal",
                text = {
                    "{C:attention}Upgrade{} a selected eligible Joker",
                    "Use on a {V:1}Tier #1#{} Joker to create {C:attention}Closed Portal{}",
                    "{X:attention,C:white}X#2#{} Entropic Corruption gain if upgrading",
                    "{C:inactive}(Cannot go past {V:1}Tier #1#{C:inactive})",
                }
            },


            c_aqu_closed_portal = {
                name = "Closed Portal",
                text = { {
                    "Creates a {C:attention}Nilscape Portal{} with a higher",
                    "maximum upgrade {C:aqu_aquill_2}Tier{} when certain conditions are met",
                }, {
                    "Conditions are chosen {C:green}randomly{} when this card is spawned"
                } }
            },
            -- the below is just a base for closed portal effects. commenting it out makes it harder to copy+paste
            c_aqu_clp_ = {
                name = "Closed Portal",
                text = { {
                    "Creates a {C:attention}Nilscape Portal{} with a max of {V:1}Tier #4#{}",
                    "when the following condition is met",
                }, {
                    "",
                    "{C:attention,s:1.2}#1#{s:1.2} / {C:attention,s:1.2}#2#{}",
                } }
            },

            c_aqu_clp_upgrade = {
                name = "Closed Portal",
                text = { {
                    "Creates a {C:attention}Nilscape Portal{} with a max of {V:1}Tier #3#{}",
                    "when the following condition is met",
                }, {
                    "{C:purple}Upgrade{} {C:attention}#2#{} blinds",
                    "{C:attention,s:1.2}#1#{s:1.2} / {C:attention,s:1.2}#2#{}",
                } }
            },
            c_aqu_clp_scorecards = {
                name = "Closed Portal",
                text = { {
                    "Creates a {C:attention}Nilscape Portal{} with a max of {V:1}Tier #3#{}",
                    "when the following condition is met",
                }, {
                    "Score {C:attention}#2#{} playing cards",
                    "{C:attention,s:1.2}#1#{s:1.2} / {C:attention,s:1.2}#2#{}",
                } }
            },
            c_aqu_clp_selljokers = {
                name = "Closed Portal",
                text = { {
                    "Creates a {C:attention}Nilscape Portal{} with a max of {V:1}Tier #3#{}",
                    "when the following condition is met",
                }, {
                    "Sell {C:attention}#2#{} Jokers",
                    "{C:attention,s:1.2}#1#{s:1.2} / {C:attention,s:1.2}#2#{}",
                } }
            },
            c_aqu_clp_earnmoney = {
                name = "Closed Portal",
                text = { {
                    "Creates a {C:attention}Nilscape Portal{} with a max of {V:1}Tier #3#{}",
                    "when the following condition is met",
                }, {
                    "Earn money {C:attention}#2#{} seperate times",
                    "{C:attention,s:1.2}#1#{s:1.2} / {C:attention,s:1.2}#2#{}",
                } }
            },
        },
    },
    misc = {
        labels = {
            aqu_dormant = "Dormant",
            aqu_hyper = "Unshackled",
            aqu_hyperplus = "Unbounded",
            aqu_hyperplusplus = "Empowered",
            aqu_extreme = "Quillic",
            aqu_gems = "Gem",
            aqu_ephemeral = "Ephemeral"

        },
        dictionary = {
            k_aqu_dormant = "Dormant",
            k_aqu_hyper = "Unshackled",
            k_aqu_hyperplus = "Unbounded",
            k_aqu_hyperplusplus = "Empowered",
            k_aqu_extreme = "Quillic",

            k_tier = "Tier",
            k_aqu_credit = "Credits",

            k_aqu_upgrade_blind = "Upgrade Blind",

            ph_aqu_visual = "Visual",
            ph_aqu_gameplay = "Gameplay",

            ph_aqu_upgraded = "Upgraded Blind Bonus",

            ph_aqu_upgrade_1 = "Upgraded Blinds have higher Blind size but higher rewards.",
            ph_aqu_upgrade_2 = "They also increase the spawn rates of Dormant Jokers.",

            ph_aqu_upgrade_corruption_1 = "Upgraded Blinds also lower Entropic Corruption",
            ph_aqu_upgrade_corruption_2 = "Similarly, non-upgraded blinds raise Entropic Corruption",

            ph_aqu_corruption_desc = {
                "Higher Entropic Corruption",
                "heavily increase Blind size",
                "Lower Corruption slightly",
                "increases Upgraded Blind size",
                "Corruption increases when ",
                "playing non-upgraded blinds",
                "Corruption decreases when",
                "playing upgraded blinds",
            },

            ph_aqu_config_alt_upgrade_effect_label = "Alternate Upgrade VFX",
            ph_aqu_config_alt_upgrade_effect_info = {
                "Changes the potentially excessive upgrading VFX",
                "to a much simpler one which flips the card.",
                "Note that this may look less polished."
            },

            ph_aqu_config_upgrade_info_queue_label = "Add Upgrade info-queues",
            ph_aqu_config_upgrade_info_queue_info = {
                "Whenever a card references its upgrades, the",
                "description of the upgrade will also be referenced",
                "This may cause unnecessary text bloat on-screen."
            },

            ph_aqu_config_disable_corruption_label = "Disable Entropic Corruption",
            ph_aqu_config_disable_corruption_info = {
                "Disables Entropic Corruption and all related mechanics.",
                "This setting is best turned off, but if your experience is",
                "majorly worsened by Corruption, consider turning this on."
            },

            ph_aqu_config_disable_screenshader_label = "Disable Screen-wide VFX",
            ph_aqu_config_disable_screenshader_info = {
                "Disables ALL screen-wide visual effects used by the mod.",
                "This may look worse, but will be easier on your eyes."
            },

            ph_aqu_corruption = "Entropic Corruption",
            ph_aqu_corruption_disabled = "Inactive",
        },
        v_dictionary = {
            aqu_dormant_rates = "X#1# Dormant Spawnrate"
        }
    }
}
