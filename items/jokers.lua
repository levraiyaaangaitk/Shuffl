--Weezer
SMODS.Joker{
    key = 'weezer',
    loc_txt = {
        name = 'Weezer',
        text = {

        }
    },
    atlas = 'joker_v1',
    pos = {x = 1, y = 0},
    rarity = 1,
    cost = 3,
    blueprint_compat=true,
    eternal_compat=true,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return { nil }
    end,
    calculate = function (self,card,context)
    end
}

--SUPREME
SMODS.Joker{
    key = 'supreme',
    loc_txt = {
        name = 'SUPREME',
        text = {

        }
    },
    atlas = 'joker_v1',
    pos = {x = 2, y = 0},
    rarity = 1,
    cost = 3,
    blueprint_compat=true,
    eternal_compat=true,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return { nil }
    end,
    calculate = function (self,card,context)
    end
}

--I Hate Joker
SMODS.Joker{
    key = 'ihj',
    loc_txt = {
        name = 'I Hate Joker',
        text = {
            "Get {C:attention}1 Free{} {C:enhanced}Tags{}",
            "every {C:attention}#1#{} items",
            "bought from the shop.",
            "{C:inactive}At least #2# item(s) left to bought.{}"
        }
    },
    config = {
        extra = {
            itemtobuy = 5,
            lefttobuy = 5
        }
    },
    atlas = 'joker_v1',
    pos = {x = 1, y = 1},
    rarity = 1,
    cost = 4,
    blueprint_compat=true,
    eternal_compat=true,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.itemtobuy, card.ability.extra.lefttobuy} }
    end,
    calculate = function (self,card,context)
        if context.buying_card then
            if card.ability.extra.lefttobuy > 1 then
                card.ability.extra.lefttobuy = card.ability.extra.lefttobuy - 1
            elseif card.ability.extra.lefttobuy == 1 then
                card.ability.extra.lefttobuy = card.ability.extra.itemtobuy
                local tag_key
			    repeat
				    tag_key = get_next_tag_key("shuffl_ihj")
			    until tag_key ~= "tag_boss"

			    local tag = Tag(tag_key)
			    if tag.name == "Orbital Tag" then
				    local _poker_hands = {}
				    for k, v in pairs(G.GAME.hands) do
					    if v.visible then
						    _poker_hands[#_poker_hands + 1] = k
					    end
				    end
				    tag.ability.orbital_hand = pseudorandom_element(_poker_hands, pseudoseed("shuffl_ihj"))
			    end
			    add_tag(tag)
            end
        end
    end
}

--The Numbers
SMODS.Joker{
    key = "thenumbers",
    atlas = 'numbers',
    config = {
        extra = {
            xmult = 1,
            gain = 0.1,
            idtoshow = '5',
            idtoplay = 5,
            loose = 0.1
        }
    },
    rarity = 2,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    unlocked = true,
    discovered = true,
    pos = {x = 4, y = 0},
    loc_txt = {
        name = 'The Numbers',
        text = {
            '{C:white,X:mult}x#1#{} Mult.',
            'Gain {C:white,X:mult}x#2#{} for every {C:attention}#3#{} played,',
            'Loose {C:white,X:mult}x#4#{} if not.',
            '{C:inactive}The card value change when the round end.{}'
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.gain, card.ability.extra.idtoshow, card.ability.extra.loose } }
    end,
    calculate = function (self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == card.ability.extra.idtoplay then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.gain
                return{
                    card = card,
                    message = '+' .. card.ability.extra.gain,
                    colour = G.C.MULT
                }
            elseif context.other_card:get_id() ~= card.ability.extra.idtoplay then
                if card.ability.extra.xmult > 1 then
                    card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.loose
                    return{
                        card = card,
                        message = '-' .. card.ability.extra.loose,
                        colour = G.C.MULT
                    }
                end
            end
        end
        if context.joker_main and card.ability.extra.xmult > 1 then
            return{
                xmult = card.ability.extra.xmult
            }
        end
        if context.end_of_round then
            card.ability.extra.idtoplay = math.random(2,14)
            if card.ability.extra.idtoplay >=11 and card.ability.extra.idtoplay <=14 then
                if card.ability.extra.idtoplay == 11 then
                    card.ability.extra.idtoshow = "Jack"
                    G.P_CENTERS.j_sl_thenumbers.pos.x = 10
                elseif card.ability.extra.idtoplay == 12 then
                    card.ability.extra.idtoshow = "Queen"
                    G.P_CENTERS.j_sl_thenumbers.pos.x = 11
                elseif card.ability.extra.idtoplay == 13 then
                    card.ability.extra.idtoshow = "King"
                    G.P_CENTERS.j_sl_thenumbers.pos.x = 12
                elseif card.ability.extra.idtoplay == 14 then
                    card.ability.extra.idtoshow = "Ace"
                    G.P_CENTERS.j_sl_thenumbers.pos.x = 13
                end
            else
                card.ability.extra.idtoshow = card.ability.extra.idtoplay
                G.P_CENTERS.j_sl_thenumbers.pos.x = card.ability.extra.idtoplay - 1
            end
        end
    end
}

--Venom Jimbo
SMODS.Joker{
    key = 'venom',
    loc_txt = {
        name = 'Venom Jimbo',
        text = {
            'Gains {C:chips}+#2#{} Chips for',
            'every {C:planet}Planet{} Card sold.',
            '{C:inactive}(currently {}{C:chips}+#1#{}{C:inactive} Chips){}'
        }
    },
    config = {
        extra = {
            chips = 0,
            extra = 15
        }
    },
    atlas = 'joker_v1',
    pos = {x = 0, y = 0},
    rarity = 2,
    cost = 5,
    blueprint_compat=true,
    eternal_compat=true,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.extra } }
    end,
    calculate = function (self,card,context)
        if context.selling_card and context.card.ability.set == "Planet" then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.extra
            return{
                colour = G.C.CHIPS,
                message = "+"..card.ability.extra.extra
            }
        end
        if context.joker_main then
            if card.ability.extra.chips > 0 then
                return{
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}

--The End of Jimbo
SMODS.Joker{
    key = 'teoj',
    loc_txt = {
        name = 'The End of Jimbo',
        text = {
            '{C:white,X:mult}x#1#{} Mult for',
            'played card on the {C:attention}final',
            '{C:attention}hand{} of the round.'
        }
    },
    atlas = 'joker_v1',
    pos = {x = 0, y = 1},
    config = {
        extra = {
            xmult = 1.5
        }
    },
    rarity = 3,
    cost = 7,
    blueprint_compat=true,
    eternal_compat=true,
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.xmult} }
    end,
    calculate = function (self,card,context)
        if G.GAME.current_round.hands_left == 0 then
            if context.individual and context.cardarea == G.play then
                return{
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}