local function com(text)
    return { name = "Lily's comments", text = type(text) == "table" and text or { text } }
end

return {
    descriptions = {
        Joker = {
            j_aqu_particleloop1 = {
                name = "Particle Loop",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "{C:green}#2# in #3#{} Chance to retrigger itself",
                    "Gains {C:chips}+#4#{} Chips per consecutive retrigger",
                    "{C:inactive}(Unmodifiable Probabilities){}",
                }
            },
            j_aqu_particleloop2 = {
                name = "Particle Loop",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "{C:green}#2# in #3#{} Chance to retrigger itself",
                    "Gains {C:chips}+#4#{} Chips per consecutive retrigger",
                    "{C:inactive}(Unmodifiable Probabilities){}",
                }
            },
            j_aqu_particleloop3 = {
                name = "Particle Loop",
                text = {
                    "{X:chips,C:white}X#1#{} Chips",
                    "{C:green}#2# in #3#{} Chance to retrigger itself",
                    "Gains {X:chips,C:white}X#4#{} Chips per consecutive retrigger",
                    "{C:inactive}(Unmodifiable Probabilities){}",
                }
            },
            j_aqu_particleloop4 = {
                name = "Particle Loop",
                text = {
                    "{X:chips,C:white}X#1#{} Chips",
                    "{C:green}#2# in #3#{} Chance to retrigger itself",
                    "Gains {X:chips,C:white}X#4#{} Chips per consecutive retrigger",
                    "{C:inactive}(Unmodifiable Probabilities){}",
                }
            },
            j_aqu_particleloop5 = {
                name = "Particle Loop",
                text = {
                    "{X:dark_edition,C:white}^#1#{} Chips",
                    "{C:green}#2# in #3#{} Chance to retrigger itself",
                    "Gains {X:dark_edition,C:white}^#4#{} Chips per consecutive retrigger",
                    "{C:inactive}(Unmodifiable Probabilities){}",
                }
            },
            j_aqu_magicorb1 = {
                name = "Magic Orb",
                text = {
                    "After {C:attention}#1#{} {C:inactive}[#2#]{} cards spawned in shop,",
                    "next shop card will recieve a random {C:dark_edition}Edition{}",
                }
            },
            j_aqu_magicorb2 = {
                name = "Wizard's Orb",
                text = { {
                    "After {C:attention}#1#{} {C:inactive}[#2#]{} cards spawned in shop,",
                    "next shop card will recieve a random {C:dark_edition}Edition{}",
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
                }, {
                    "Increases by an extra card for each {C:dark_edition}Editioned{} Joker owned",
                }, {
                    "Buying an {C:dark_edition}Editioned{} card makes the next {C:green}Reroll{} free"
                }, {
                    "{C:dark_edition}Editioned{} cards have a {C:green}#3# in #4#{} chance to ",
                    "copy their {C:dark_edition}Edition{} to another card at end of round",
                    "{C:inactive}(May overwrite other Editions)"
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
                    "{C:inactive}(May overwrite other Editions)"
                }, {
                    "Retrigger {C:dark_edition}Editioned{} cards once for every {C:dark_edition}Editioned{} Joker owned",
                }
                }
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

        Other = {
            aqu_upgrade = {
                name = "Upgradable",
                text = {
                    "This card has an {C:attention}upgraded{} variant",
                    "Upgrades into {X:dark_edition,C:white}#1#{}"
                }
            },

            lily_j_joker = com("i love this guy")
        },

        Spectral = {
            c_aqu_nilscape_portal_first = {
                name = "Nilscape Portal",
                text = {
                    "{C:attention}Upgrade{} a selected eligible Joker",
                    "Upgraded blinds permanently give {C:money}$#1#{} more",
                    "Increase upgraded blind exponent by {X:dark_edition,C:white}^#2#{}",
                    "Enables {C:attention}Entropic Corruption{}"
                }
            },
            c_aqu_nilscape_portal_used = {
                name = "Nilscape Portal",
                text = {
                    "{C:attention}Upgrade{} a selected eligible Joker",
                    "Upgraded blinds permanently give {C:money}$#1#{} more",
                    "Increase upgraded blind exponent by {X:dark_edition,C:white}^#2#{}",
                    "{X:attention,C:white}X#3#{} Entropic Corruption gain"
                }
            }
        },
    },
    misc = {
        labels = {
            aqu_dormant = "Dormant",
            aqu_hyper = "Hyper",
            aqu_hyperplus = "Hyper+",
            aqu_hyperplusplus = "Hyper++",
            aqu_extreme = "Extreme",
            aqu_gems = "Gem",

        },
        dictionary = {
            k_aqu_dormant = "Dormant",
            k_aqu_hyper = "Hyper",
            k_aqu_hyperplus = "Hyper+",
            k_aqu_hyperplusplus = "Hyper++",
            k_aqu_extreme = "Extreme",
            k_aqu_gems = "Gem",
            b_aqu_gems_cards = "Gem Cards",

            ph_aqu_upgrade_1 = "Upgraded Blinds have higher Blind size but higher rewards.",
            ph_aqu_upgrade_2 = "They also increase the spawn rates of Dormant Jokers.",

            ph_aqu_corruption_desc = {
                "Higher Entropic Corruption",
                "exponentially increases Blind size.",
                "Reaching max corruption",
                "will make blinds impossible.",
            },

            ph_aqu_corruption = "Entropic Corruption",
            ph_aqu_corruption_disabled = "Inactive",
        },
        v_dictionary = {
            aqu_dormant_rates = "X#1# Dormant Spawnrate"
        }
    }
}
