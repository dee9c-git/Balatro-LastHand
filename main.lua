local config = SMODS.current_mod.config

G.E_MANAGER.queues.last_hand = {}

local event
event = Event {
    blockable = false,
    blocking = false,
    pause_force = true,
    no_delete = true,
    trigger = "after",
    delay = 1,
    timer = "UPTIME",
    func = function()
        if G.GAME.current_round.hands_left ~= 0 or G.GAME.current_round.hands_played ~= 0 then
            config.hands_left = G.GAME.current_round.hands_left
            config.hands_played = G.GAME.current_round.hands_played
            config.discards_used = G.GAME.current_round.discards_used
        end
        local current = G.localization.misc.dictionary.b_play_hand
        if config.hands_left == 1 and config.show_last_hand then
            G.localization.misc.dictionary.b_play_hand = localize("last_hand", "LastHand")
        elseif config.hands_played == 0 and config.show_first_hand then
            G.localization.misc.dictionary.b_play_hand = localize("first_hand", "LastHand")
        else
            G.localization.misc.dictionary.b_play_hand = localize("play_hand", "LastHand")
        end

        if config.discards_used == 0 and config.show_first_discard then
            G.localization.misc.dictionary.b_discard = localize("first_discard", "LastHand")
        else
            G.localization.misc.dictionary.b_discard = localize("discard", "LastHand")
        end
        -- sendInfoMessage(G.localization.misc.dictionary.b_play_hand, "LastHand")
        if current ~= G.localization.misc.dictionary.b_play_hand then
            init_localization()
        end
    end,
}
G.E_MANAGER:add_event(event, "last_hand")

SMODS.current_mod.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = { r = 0.1, align = "cm", padding = 0.1, colour = G.C.BLACK, minw = 8, minh = 6 },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = "cl", padding = 0 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cl", padding = 0.05 },
                        nodes = {
                            create_toggle { col = true, label = "Show First Hand", scale = 0.85, w = 0, shadow = true, ref_table = config, ref_value = 'show_first_hand' },
                        }
                    },
                }
            },
            {
                n = G.UIT.R,
                config = { align = "cl", padding = 0 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cl", padding = 0.05 },
                        nodes = {
                            create_toggle { col = true, label = "Show Last Hand", scale = 0.85, w = 0, shadow = true, ref_table = config, ref_value = 'show_last_hand' },
                        }
                    },
                }
            },
            {
                n = G.UIT.R,
                config = { align = "cl", padding = 0 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cl", padding = 0.05 },
                        nodes = {
                            create_toggle { col = true, label = "Show First Discard", scale = 0.85, w = 0, shadow = true, ref_table = config, ref_value = 'show_first_discard' },
                        }
                    },
                }
            },
        }
    }
end
