local _G, _M = getfenv(0), {}

function _G.GetSoulBagPosition(enabled)
	return SoulBagPosition
end

function _G.SetSoulBagPosition(enabled)
	_G.SoulBagPosition = enabled and 1 or nil
end

local frame3 = CreateFrame("FRAME", "SomeFrameIDK");
frame3:RegisterEvent("CHAT_MSG_LOOT");
frame3:SetScript("OnEvent", function(self, eventName, text)
    if text:find('灵魂碎片') then SimpleWay() end
end)

function DestroyItem(bagID, index)
    local link = GetContainerItemLink(bagID, index)
    print("destroying "..link.." at bag "..bagID.." slot "..index)
    PickupContainerItem(bagID, index)
    DeleteCursorItem()
end

function SimpleWay()
    -- SoulBagCheck()
    local shards_count = 0
    for bagID=0, 4 do
        if bagID == SoulBagPosition then return end
        local bagSlots = GetContainerNumSlots(bagID)
        for slotIndex=1, bagSlots do
            local _, _, _, _, _, _, _, _, _, sitemID = GetContainerItemInfo(bagID, slotIndex)
            if sitemID == 6265 then
                -- simple mind save catch
                if SoulBagPosition then
                    DestroyItem(bagID, slotIndex)
                elseif shards_count <= 20 then
                    shards_count = shards_count + 1
                elseif shards_count > 20 then
                    DestroyItem(bagID, slotIndex)
                end
            end
        end
    end
end
