--Aging Deck
SMODS.Back{
    key = 'Aging',
    atlas = 'v1',
    pos = {x = 0, y = 0},
    loc_txt = {
        name = 'Aging Deck',
        text = {
            'Each played {C:attention}playing card{}',
            'gains {C:attention}+1 rank{}.',
            '{C:inactive}E.g. 2 → 3, 10 → J.{}'
    }
    },
    calculate = function(self, back, context)
    if context.after then
    for _, pcard in ipairs(context.full_hand) do
        G.E_MANAGER:add_event(Event({
            func = (function()
                assert(SMODS.modify_rank(pcard, 1))
                return true
            end)
        }))
    end
end
end
--thx N' on the Balatro discord a lot for helipng me wit this one
}

--Azur Deck
SMODS.Back{
    key = 'Azur',
    atlas = 'v1',
    pos = {x = 0, y = 1},
    loc_txt = {
        name = 'Azur Deck',
        text = {
            'Start with 32 cards.',
            '{C:inactive}Cards ranked 2 to 6 are removed.{}',
            '{C:mult}-1{} Discard, {C:chips}-1{} Hand.'
        }
    },
    config ={
        discards = -1,
        hands = -1,
        ante_scaling = 1.5
    },
    apply = function(self, back)
        -- Retirer toutes les cartes 2 à 6 une fois que le deck est généré
        G.E_MANAGER:add_event(Event({
            func = function()
                local banned_ranks = { ["2"]=true, ["3"]=true, ["4"]=true, ["5"]=true, ["6"]=true }
                for k, v in pairs(G.playing_cards) do
                    if banned_ranks[v.base.id] or banned_ranks[v.base.rank] or banned_ranks[v.base.value] then
                        v:start_dissolve(nil, true)  -- supprime proprement la carte
                    end
                end
                return true
            end,
        }))
    end
}

--Pink Deck
SMODS.Back{
    key = 'Pink',
    atlas = 'v1',
    pos = {x = 1, y = 0},
    loc_txt = {
        name = 'Pink Deck',
        text = {
            '{X:green,C:white,scale:2,E:1}EASY MODE!{}',
            'Start at {C:attention}Ante 0{} with a',
            '{C:tarot,T:v_money_tree}Money Tree{}.',
            '{C:mult}+1{} Discard, {C:chips}+1{} Hand.',
            'Ante scaling is reduced.'
        }
    },
    config ={
        discards = 1,
        hands = 1,
        ante_scaling = 0.5
    },
    apply = function(self,back)
        ease_ante(-1)
    end
}
