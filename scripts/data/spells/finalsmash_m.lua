local spell, super = Class(Spell, "finalsmash_m")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "FinalSmash"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Fire\nDamage"
    -- Menu description
    self.description = "Deals powerful fire damage to\nall of the enemies."

    -- TP cost
    self.cost = 200

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemies"

    -- Tags that apply to this spell
    self.tags = {"fatal", "damage"}
end

function spell:getTPCost(chara)
    local cost = super.getTPCost(self, chara)
    if chara and chara:checkArmor("smashball") then
        cost = Utils.round(cost / 2)
    end
    return cost
end

function spell:onCast(user, target)
    local object = Finalsmash_m(user)
    object.damage = math.ceil(((user.chara:getStat("magic") * 40) + 600))
    object.layer = BATTLE_LAYERS["above_ui"]
    Game.battle:addChild(object)

    return false
end

return spell