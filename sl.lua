local item_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "items")
for _, file in ipairs(item_src) do
    assert(SMODS.load_file("items/" .. file))()
end

SMODS.Atlas{
    key = 'numbers',
    path = 'numbers.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'v1',
    path = 'decks_v1.png',
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = 'joker_v1',
    path = 'joker_v1.png',
    px = 71,
    py = 95
}