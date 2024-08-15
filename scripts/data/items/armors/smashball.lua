local item, super = Class(Item, "smashball")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Smash Ball"

    -- Item type (item, key, weapon, armor)
    self.type = "armor"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/armor"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A rainbow ball with a + shaped pattern"
    self.description = "When given to certain party members, their fighting spirit awakens"

    -- Default shop price (sell price is halved)
    self.price = 1000
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        defense = 4,
        attack = 4,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Awakened"
    self.bonus_icon = "ui/menu/icon/exclamation"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        susie = false,
        kris = false,
        ralsei = false,
        noelle = false
    }

    -- Character reactions
    self.reactions = {
        berdly = "A smash ball? For me? Kristopher, you know me too well!",
        susie = "What do I even do with this?",
        ralsei = "What is this?",
        noelle = "(Does this... Make me a gamer???)",
    }
end

function item:convertToLightEquip(chara)
    return "light/bandage"
end

return item