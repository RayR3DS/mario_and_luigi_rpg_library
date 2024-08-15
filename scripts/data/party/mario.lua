local character, super = Class(PartyMember, "mario")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Mario"

    -- Actor (handles overworld/battle sprites)
    self:setActor("mario")
    self:setLightActor("mario_lw")

    -- Display level (saved to the save file)
    self.level = Game.chapter
    -- Default title / class (saved to the save file)
    self.title = "Plumber\nArrived from a\ndifferent world."

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = 1
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {1, 0, 0}

    -- Whether the party member can act / use spells
    self.has_act = true
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = false
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "M-Action"
    
    -- Spells
    self:addSpell("pacify")
    self:addSpell("fireball")
    self:addSpell("finalsmash_m")

    -- Current health (saved to the save file)
    self.health = 120

    -- Base stats (saved to the save file)
    self.stats = {
        health = 120,
        attack = 10,
        defense = 5,
        magic = 0
    }
    -- Max stats from level-ups
    self.max_stats = {
        health = 180
    }

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/hammer"

    -- Equipment (saved to the save file)
    self:setWeapon("golden_hammer")
    self:setArmor(1, "smashball")

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {255/255, 15/255, 29/255}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    -- self.dmg_color = {18/255, 181/255, 94/255}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    -- self.attack_bar_color = {43/255, 165/255, 100/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    -- self.attack_box_color = {0, 114/255, 53/255}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    -- self.xact_color = {18/255, 181/255, 94/255}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/mario/head"
    -- Path to head icons used in battle
    self.head_icons = "party/mario/icon"
    -- Name sprite
    self.name_sprite = "party/mario/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/cut"
    -- Sound played when this character attacks
    self.attack_sound = "hammer"
    -- Pitch of the attack sound
    self.attack_pitch = 1

    -- Battle position offset (optional)
    self.battle_offset = {2, 1}
    -- Head icon position offset (optional)
    self.head_icon_offset = nil
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = nil
end

function character:getGameOverMessage(main)
    return {
        "Oh, no! ".. main.name ..", are you all right?",
        "Do not die on me, ".. main.name .."! Do not!!!"
    }
end

function character:onAttackHit(enemy, damage)
    if damage > 0 then
        Assets.playSound("impact", 0.8)
        Game.battle:shakeCamera()
    end
end

function character:onLevelUp(level)
    self:increaseStat("health", 2)
    if level % 2 == 0 then
        self:increaseStat("health", 1)
    end
    if level % 10 == 0 then
        self:increaseStat("attack", 1)
        self:increaseStat("magic", 1)
    end
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1 then
        
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)

        love.graphics.print("So Retro", x, y, 0, 0.8, 1)
        love.graphics.print("Yes", x+130, y)

        return true

    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Fire:", x, y)

        love.graphics.draw(icon, x+90, y+6, 0, 2, 2)
        love.graphics.draw(icon, x+110, y+6, 0, 2, 2)
        love.graphics.draw(icon, x+130, y+6, 0, 2, 2)
        return true
    end
end

return character