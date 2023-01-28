module('z', package.seeall)

local function parse_item(lines)
    local items = {}
    for _, line in ipairs(lines) do
        for path, legacy, frecent in string.gmatch(line, '(.*)|(.*)|(.*)') do
            table.insert(items, {
                path = path,
                legacy = tonumber(legacy),
                frecent = tonumber(frecent),
            })
        end
    end
    return items
end

local function fzf_find()
    local zdata = os.getenv('ZSHZ_DATA') or '~/.z'
    zdata = vim.fs.normalize(zdata)
    local file = io.open(zdata)
    if file == nil then
        return
    end
    local lines = {}
    for line in file:lines() do
        table.insert(lines, line)
    end
    file:close()

    local items = parse_item(lines)
    local zshz_completion = os.getenv('ZSHZ_COMPLETION') or 'frecent'
    if zshz_completion == 'legacy' then
        table.sort(items, function(lhs, rhs) return lhs.legacy > rhs.legacy end)
    else
        table.sort(items, function(lhs, rhs) return lhs.frecent > rhs.frecent end)
    end

    local pathes = {}
    for _, item in ipairs(items) do
        table.insert(pathes, item.path)
    end

    vim.fn['z#run'](pathes)
end

function setup()
    local fzf_prefix = vim.g.fzf_command_prefix or 'FZF'
    vim.api.nvim_create_user_command(fzf_prefix .. 'Z', fzf_find, {
        desc = 'z',
        nargs = 0,
    })
end
