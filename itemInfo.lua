----------------------------------------------------------
------ rathena
------ sader1992
------ https://rathena.org/board/profile/30766-sader1992/
------ added Divide-Pride Holic
----------------------------------------------------------
function add_url()
	local elvesOriginURL = "<URL>[ Elves Origin]<INFO>https://elvesorigin.com/</INFO></URL>"
	local divinePrideURL = "<URL>[ Divine Pride]<INFO>https://divine-pride.net/database/item/</INFO></URL>"
	return elvesOriginURL, divinePrideURL
end

function add_item_link(v)
	local elvesOriginLink = "<URL>Elves:" .. tostring(v) .. " <INFO>https://elvesorigin.com/item/view/?id=" .. tostring(v) .. "</INFO></URL>"
	local divinePrideLink = "<URL>Divine:" .. tostring(v) .. " <INFO>https://divine-pride.net/database/item/" .. tostring(v) .. "</INFO></URL>"
	return elvesOriginLink, divinePrideLink
end

function main()
	IInfo = {"System.elves_pre","System.itemInfo_re","System.iteminfo_kro2"}
	-- Example!
	-- IInfo = {"System.import_iteminfo","System.kro_iteminfo5","System.kro_iteminfo4","System.kro_iteminfo3","System.kro_iteminfo2","System.kro_iteminfo1","System.kro_iteminfo"}
	ItemList = {}
	local elvesOriginURL, divinePrideURL = add_url()
	for key,ItemInfo in pairs(IInfo) do
		require(ItemInfo)
		for ItemID, DESCS in pairs(tbl) do
			if not ItemList[ItemID] then
				ItemList[ItemID] = true
				result, msg = AddItem(ItemID, DESCS.unidentifiedDisplayName, DESCS.unidentifiedResourceName, DESCS.identifiedDisplayName, DESCS.identifiedResourceName, DESCS.slotCount, DESCS.ClassNum)
				if not result == true then
					return false, msg
				end
				AddItemUnidentifiedDesc(ItemID, elvesOriginURL)
				AddItemUnidentifiedDesc(ItemID, divinePrideURL)
for k, v in pairs(DESCS.unidentifiedDescriptionName) do
    print("Unidentified Description: " .. v)
    result, msg = AddItemUnidentifiedDesc(ItemID, v)
    if not result == true then
        return false, msg
    end
end

for k, v in pairs(DESCS.identifiedDescriptionName) do
    print("Identified Description: " .. v)
    result, msg = AddItemIdentifiedDesc(ItemID, v)
    if not result == true then
        return false, msg
    end
end

local elvesOriginLink, divinePrideLink = add_item_link(ItemID)
AddItemUnidentifiedDesc(ItemID, elvesOriginLink)
AddItemUnidentifiedDesc(ItemID, divinePrideLink)

-- Add item links to identified descriptions
AddItemIdentifiedDesc(ItemID, elvesOriginLink)
AddItemIdentifiedDesc(ItemID, divinePrideLink)

				
				if nil ~= DESCS.EffectID then
					result, msg = AddItemEffectInfo(ItemID, DESCS.EffectID)
				end
				if not result == true then
					return false, msg
				end
				if nil ~= DESCS.costume then
					result, msg = AddItemIsCostume(ItemID, DESCS.costume)
				end
				if not result == true then
					return false, msg
				end
			end
		end
	end
	return true, "good"
end

