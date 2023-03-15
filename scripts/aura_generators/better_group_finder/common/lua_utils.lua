function aura_env:RgbColorToHex(r, g, b)
    return self:NumericColorToHex(r) .. self:NumericColorToHex(g) .. self:NumericColorToHex(b)
end

function aura_env:NumericColorToHex(color)
    color = math.floor(color * 255)
    local hexColor = string.format("%x", color)
    if (hexColor:len() == 1) then
        return "0" .. hexColor
    end
    return hexColor
end
