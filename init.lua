local function extractPathComponents(path)
    local components = {}
    for component in path:gmatch("[^/]+") do
        table.insert(components, component)
    end

    return components
end

local import = function(path)
    local callerPath = debug.getinfo(2, "S").source:sub(2)
 
    local pathStack = {}
    
    if (path:sub(1, 1) == ".") then
        local components = extractPathComponents(callerPath)
        
        for i = 1, #components - 1 do
            pathStack[i] = components[i]
        end
    end

    local components = extractPathComponents(path)

    for _, component in ipairs(components) do
        if (component == ".") then
            -- Skip
        elseif (component == "..") then
            table.remove(pathStack, #pathStack)
        else
            table.insert(pathStack, component)
        end
    end

    local out = table.concat(pathStack, ".")
    
    return require(out)
end

local useImport = function(fn)
    _G["import"] = import
    local results = { fn() }
    _G["import"] = nil

    return unpack(results)
end

return {
    import = import,
    useImport = useImport,
}