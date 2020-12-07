local tiers = {
  [1] = {'automation-science-pack', 1},
  [2] = {'logistic-science-pack', 1},
  [3] = {'chemical-science-pack', 1},
  [4] = {'utility-science-pack', 1},
  [5] = {'production-science-pack', 1},
  [6] = {'space-science-pack', 1}
}

if data.raw.technology['steel-axe'] then
  for tier, requirement in pairs(tiers) do
    -- if 1, add steel-axe as pre-req, else add previous tier
    local tech_tier = table.deepcopy(data.raw.technology['steel-axe'])
    tech_tier.name = 'faster-handmining-' .. tier
    if tier == 1 then
      tech_tier.prerequisites = {'steel-axe'}
    else
      tech_tier.prerequisites = {'faster-handmining-' .. tier - 1}
    end
    tech_tier.unit.count = tech_tier.unit.count * tier * 20
    local current_requirement = {}
    for i, sci_pack in pairs(tiers) do
      if i <= tier then
        table.insert(current_requirement, sci_pack)
      end
    end
    tech_tier.unit.ingredients = current_requirement
    tech_tier.unit.time = 60
    data:extend({tech_tier})
  end
else
  -- technology doesn't exist - throw error
  log("Technology 'steel-axe' doesn't exist.")
end
