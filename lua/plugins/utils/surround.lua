return
{
    "nvim-mini/mini.surround",
    config = function()
        require("mini.surround").setup({
            mappings = {
                visual = "s", -- use 's' in visual mode instead of 'sa'
                add = "sa",
                delete = "sd",
                find = "sf",
                find_left = "sF",
                highlight = "sh",
                replace = "sr",
            }
        })
    end
}
