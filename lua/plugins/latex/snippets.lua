local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local sn = ls.snippet_node
local d = ls.dynamic_node
local f = ls.function_node -- Helper: generate a row of insert nodes
local function make_row_nodes(cols, start_idx)
    local nodes = {}
    for col = 1, cols do
        table.insert(nodes, i(start_idx + col - 1, ""))
        if col < cols then
            table.insert(nodes, t(" & "))
        end
    end
    return nodes
end
-- Helper to build matrix nodes
local function make_matrix_nodes(r, c, matrix_type)
    local nodes = {}
    local begin_env = matrix_type
    local augmented = false
    if matrix_type == "augm" then
        begin_env = "bmatrix"
        augmented = true
    end

    table.insert(nodes, t("\\begin{" .. begin_env .. "}"))

    for row = 1, r do
        if row > 1 then
            table.insert(nodes, t({ "", "\\\\" }))
        else
            table.insert(nodes, t({ "" }))
        end

        for col = 1, c do
            table.insert(nodes, i((row - 1) * c + col, ""))
            if augmented and col == c then
                table.insert(nodes, t(" & \\vline & "))
            elseif col < c then
                table.insert(nodes, t(" & "))
            end
        end
    end

    table.insert(nodes, t({ "", "\\end{" .. begin_env .. "}" }))
    return nodes
end

-- Helper to create dynamic snippet
local function matrix_snip(trig_pattern, matrix_type)
    return s(
        { trig = trig_pattern, regTrig = true, wordTrig = true },
        d(1, function(_, snip)
            local r = tonumber(snip.captures[1])
            local c = tonumber(snip.captures[2])
            local nodes = make_matrix_nodes(r, c, matrix_type)
            return sn(nil, nodes)
        end, {})
    )
end
-- =========================
-- LuaSnip basic config
-- =========================
ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
})

-- Load friendly-snippets (optional)
require("luasnip.loaders.from_vscode").lazy_load()

-- =========================
-- LaTeX snippets
-- =========================
ls.add_snippets("tex", {

    -- ==== Math operators ====
    s("f", { t("\\frac{"), i(1), t("}{"), i(2), t("}") }),
    s("all", { t("\\Rightarrow ") }),
    s("sall", { t("\\Leftarrow ") }),
    s("sse", { t("\\Leftrightarrow ") }),
    s("not", { t("\\neg ") }),
    s("or", { t("\\lor ") }),
    s("et", { t("\\land ") }),
    s("tc", { t("\\mid ") }),
    s("mod", { t("\\models ") }),
    s("nmod", { t("\\not\\models ") }),
    s("->", { t("\\to ") }),
    s("<-", { t("\\leftarrow ") }),
    s("<->", { t("\\leftrightarrow ") }),

    -- ==== Integrali ====
    s("int", { t("\\int "), i(1), t(" \\, d"), i(2) }), -- indefinito
    -- Definite integral snippet (expanded fully)
    s("intd", {
        t("\\int_{"),
        i(1, "a"),
        t("}^{"),
        i(2, "b"),
        t("} "),
        i(3, "x^2"),
        t(" \\, d"),
        i(4, "x"),
    }),

    -- ==== Sommatorie ====
    s("sum", { t("\\sum_{"), i(1), t("}^{"), i(2), t("} "), i(3) }),

    -- ==== Prodotti ====
    s("prod", { t("\\prod_{"), i(1), t("}^{"), i(2), t("} "), i(3) }),

    -- ==== Limiti ====
    s("lim", { t("\\lim_{"), i(1), t(" \\to "), i(2), t("} "), i(3) }),

    -- ==== Advanced functions ====
    s("sin", { t("\\sin("), i(1), t(")") }),
    s("cos", { t("\\cos("), i(1), t(")") }),
    s("tan", { t("\\tan("), i(1), t(")") }),
    s("csc", { t("\\csc("), i(1), t(")") }),
    s("sec", { t("\\sec("), i(1), t(")") }),
    s("cot", { t("\\cot("), i(1), t(")") }),
    s("arcsin", { t("\\arcsin("), i(1), t(")") }),
    s("arccos", { t("\\arccos("), i(1), t(")") }),
    s("arctan", { t("\\arctan("), i(1), t(")") }),

    -- ==== Exponentials / Logarithms ====
    s("exp", { t("^{"), i(1), t("}") }),
    s("ln", { t("\\ln("), i(1), t(")") }),
    s("log", { t("\\log("), i(1), t(")") }),
    s("rad", {
        t("\\sqrt["),
        i(1, "n"), -- root index
        t("]{"),
        i(2, "x"), -- content
        t("}"),
    }),

    -- ==== Complex numbers ====
    s("im", { t("i") }),
    s("Re", { t("\\Re("), i(1), t(")") }),
    s("Im", { t("\\Im("), i(1), t(")") }),

    -- ==== Vectors / linear algebra ====
    s("vec", { t("\\vec{"), i(1), t("}") }),
    s("vers", { t("\\hat{"), i(1), t("}") }),
    s("abs", { t("\\lvert "), i(1, "x"), t("\\rvert") }),
    s("norm", { t("\\lVert "), i(1, "x"), t("\\rVert") }),
    s("dot", { t("\\cdot ") }),
    s("cross", { t("\\times ") }),
    s("Box", { t("\\boxed{"), i(1), t("}") }),

    -- ==== Derivatives / Partial derivatives / Nabla ====
    s("d", { t("\\frac{d "), i(1, "f"), t("}{d "), i(2, "x"), t("}") }),
    s("d2", { t("\\frac{d^2 "), i(1, "f"), t("}{d "), i(2, "x^2"), t("}") }),
    s("dn", { t("\\frac{d^"), i(1, "n"), t(" "), i(2, "f"), t("}{d "), i(3, "x^"), i(1), t("}") }),
    s("fp", { i(1, "f"), t("'("), i(2, "x"), t(")") }),
    s("fs", { i(1, "f"), t("''("), i(2, "x"), t(")") }),
    s("fn", { i(1, "f"), t("^{("), i(2, "n"), t(")}("), i(3, "x"), t(")") }),
    s("pd", { t("\\frac{\\partial "), i(1, "f"), t("}{\\partial "), i(2, "x"), t("}") }),                            -- ∂f/∂x
    s("pd2", { t("\\frac{\\partial^2 "), i(1, "f"), t("}{\\partial "), i(2, "x^2"), t("}") }),                       -- ∂²f/∂x²
    s("pdn", { t("\\frac{\\partial^"), i(1, "n"), t(" "), i(2, "f"), t("}{\\partial "), i(3, "x^"), i(1), t("}") }), -- ∂^n f / ∂x^n

    -- =========================
    -- Nabla / vector calculus
    -- =========================
    s("grad", { t("\\nabla "), i(1, "f") }),         -- ∇f
    s("div", { t("\\nabla \\cdot "), i(1, "F") }),   -- ∇·F
    s("curl", { t("\\nabla \\times "), i(1, "F") }), -- ∇×F
    -- ==== Integrals, sums, products, limits (advanced) ====

    -- ==== Misc symbols ====
    s("inf", { t("\\infty") }),
    s("partial", { t("\\partial") }),
    s("nabla", { t("\\nabla") }),
    s("suminf", { t("\\sum_{n=0}^{\\infty} "), i(1), t("}") }),
    s("prodinf", { t("\\prod_{n=0}^{\\infty} "), i(1), t("}") }),
    s("intinf", { t("\\int_{0}^{\\infty} "), i(1), t(" \\, dx") }),

    -- Lowercase Greek letters
    s("a", { t("\\alpha ") }),
    s("b", { t("\\beta ") }),
    s("g", { t("\\gamma ") }),
    s("d", { t("\\delta ") }),
    s("e", { t("\\epsilon ") }),
    s("z", { t("\\zeta ") }),
    s("h", { t("\\eta ") }),
    s("th", { t("\\theta ") }),
    s("i", { t("\\iota ") }),
    s("k", { t("\\kappa ") }),
    s("l", { t("\\lambda ") }),
    s("m", { t("\\mu ") }),
    s("n", { t("\\nu ") }),
    s("x", { t("\\xi ") }),
    s("om", { t("\\omicron ") }),
    s("p", { t("\\pi ") }),
    s("r", { t("\\rho ") }),
    s("s", { t("\\sigma ") }),
    s("t", { t("\\tau ") }),
    s("f", { t("\\phi ") }),
    s("c", { t("\\chi ") }),
    s("psi", { t("\\psi ") }),
    s("o", { t("\\omega ") }),

    -- Uppercase Greek letters
    s("A", { t("\\Alpha ") }),
    s("B", { t("\\Beta ") }),
    s("G", { t("\\Gamma ") }),
    s("D", { t("\\Delta ") }),
    s("E", { t("\\Epsilon ") }),
    s("Z", { t("\\Zeta ") }),
    s("H", { t("\\Eta ") }),
    s("Th", { t("\\Theta ") }),
    s("I", { t("\\Iota ") }),
    s("K", { t("\\Kappa ") }),
    s("L", { t("\\Lambda ") }),
    s("M", { t("\\Mu ") }),
    s("N", { t("\\Nu ") }),
    s("X", { t("\\Xi ") }),
    s("Om", { t("\\Omicron ") }),
    s("P", { t("\\Pi ") }),
    s("R", { t("\\Rho ") }),
    s("S", { t("\\Sigma ") }),
    s("T", { t("\\Tau ") }),
    s("F", { t("\\Phi ") }),
    s("C", { t("\\Chi ") }),
    s("Psi", { t("\\Psi ") }),
    s("O", { t("\\Omega ") }),

    -- ==== Quantifiers ====
    s("po", { t("\\forall ") }),
    s("es", { t("\\exists ") }),
    s("app", { t("\\in ") }),

    -- ==== Sets and numbers ====
    s("nn", { t("\\mathbb{N}") }),
    s("zz", { t("\\mathbb{Z}") }),
    s("qq", { t("\\mathbb{Q}") }),
    s("rr", { t("\\mathbb{R}") }),
    s("inc", { t("\\subset ") }),
    s("uni", { t("\\cup ") }),
    s("int", { t("\\cap ") }),
    s("neg", { t("\\overline ") }),
    s("ov", { t("\\bar ") }),
    s("ul", { t("\\underline{"), i(1), t("}") }),
    s("txt", { t("\\text{"), i(1), t("}") }),
    s("ps", {
        t("\\langle "),
        i(1, "u"),
        t(", "),
        i(2, "v"),
        t(" \\rangle"),
    }),

    -- ==== Calligraphic letters ====
    s("mc", { t("\\mathcal{"), i(1), t("}") }),
    s("mcl", { t("\\mathrsfs{"), i(1), t("}") }),

    -- ==== Brackets / Delimiters ====
    s("()", { t("\\left("), i(1), t("\\right)") }),
    s("[]", { t("\\left["), i(1), t("\\right]") }),
    s("{}", { t("\\left\\{"), i(1), t("\\right\\}") }),
    -- Logic derivability (|-L)
    s("der", { t("\\vdash ") }),
    s("box", { t("\\Box ") }),

    -- ==== Math environments ====
    s("dm", {
        t("\\["),
        t({ "", "\t" }), -- newline + indentation
        i(1),
        t({ "", "\\]" }),
    }),
    -- Simple bmatrix (square brackets)
    s("bm", {
        t("\\begin{bmatrix}"),
        t({ "", "\t" }),
        i(1, "a_{11} & a_{12} \\\\ a_{21} & a_{22}"),
        t({ "", "\\end{bmatrix}" }),
    }),

    -- Parentheses matrix
    s("pm", {
        t("\\begin{pmatrix}"),
        t({ "", "\t" }),
        i(1, "a_{11} & a_{12} \\\\ a_{21} & a_{22}"),
        t({ "", "\\end{pmatrix}" }),
    }),

    -- Vertical bars matrix (determinant)
    s("vm", {
        t("\\begin{vmatrix}"),
        t({ "", "\t" }),
        i(1, "a_{11} & a_{12} \\\\ a_{21} & a_{22}"),
        t({ "", "\\end{vmatrix}" }),
    }),

    -- Double vertical bars (norm or determinant)
    s("Vn", {
        t("\\begin{Vmatrix}"),
        t({ "", "\t" }),
        i(1, "a_{11} & a_{12} \\\\ a_{21} & a_{22}"),
        t({ "", "\\end{Vmatrix}" }),
    }),

    -- Augmented matrix (for linear systems)
    s("augm", {
        t("\\begin{bmatrix}"),
        t({ "", "\t" }),
        i(1, "a_{11} & a_{12} & \\vline & b_1 \\\\ a_{21} & a_{22} & \\vline & b_2"),
        t({ "", "\\end{bmatrix}" }),
    }),
    -- Identity matrix: trigger like "id3" for 3x3
    s(
        { trig = "id(%d)", regTrig = true, wordTrig = false },
        d(1, function(_, snip)
            local n = tonumber(snip.captures[1])
            local nodes = { t("\\begin{bmatrix}") }

            for row = 1, n do
                if row > 1 then
                    table.insert(nodes, t({ "", "\\\\" }))
                end
                for col = 1, n do
                    if row == col then
                        table.insert(nodes, t("1"))
                    else
                        table.insert(nodes, t("0"))
                    end
                    if col < n then
                        table.insert(nodes, t(" & "))
                    end
                end
            end

            table.insert(nodes, t({ "", "\\end{bmatrix}" }))
            return sn(nil, nodes)
        end, {})
    ),
    s("Id", {
        t("\\mathbb{I}_{"),
        i(1, "n"),
        t("}"),
    }),

    -- Zero matrix shortcut
    s("0m", {
        t("\\mathbf{0}_{"),
        i(1, "n\\times m"),
        t("}"),
    }),

    -- Generic m x n matrix
    s("mat", {
        t("\\begin{bmatrix}"),
        t({ "", "\t" }),
        i(1, "a_{11} & \\dots & a_{1n} \\\\ \\vdots & \\ddots & \\vdots \\\\ a_{m1} & \\dots & a_{mn}"),
        t({ "", "\\end{bmatrix}" }),
    }),
    -- s(
    --   { trig = "mat(%d)(%d)", regTrig = true, wordTrig = false },
    --   d(1, function(_, snip)
    --     local r = tonumber(snip.captures[1])
    --     local c = tonumber(snip.captures[2])

    --     local nodes = {}
    --     table.insert(nodes, t("\\begin{bmatrix}"))

    --     for row = 1, r do
    --       if row > 1 then
    --         table.insert(nodes, t({ "", "\\\\" }))
    --       end
    --       for col = 1, c do
    --         table.insert(nodes, i((row - 1) * c + col, ""))
    --         if col < c then
    --           table.insert(nodes, t(" & "))
    --         end
    --       end
    --     end

    --     table.insert(nodes, t({ "", "\\end{bmatrix}" }))

    --     -- Wrap in a snippet node, required by dynamic_node
    --     return sn(nil, nodes)
    --   end, {})
    -- ),
    --
    s(
        { trig = "augm(%d)(%d)(%d)(%d)", regTrig = true, wordTrig = true },
        d(1, function(_, snip)
            local r1 = tonumber(snip.captures[1])
            local c1 = tonumber(snip.captures[2])
            local r2 = tonumber(snip.captures[3])
            local c2 = tonumber(snip.captures[4])

            local rows = math.max(r1, r2)
            local nodes = { t("\\begin{bmatrix}") }

            local node_index = 1 -- tracks insert node numbers

            for row = 1, rows do
                if row > 1 then
                    table.insert(nodes, t({ "", "\\\\" }))
                end

                -- Left block
                if row <= r1 then
                    local left_nodes = make_row_nodes(c1, node_index)
                    for _, n in ipairs(left_nodes) do
                        table.insert(nodes, n)
                    end
                else
                    for col = 1, c1 do
                        table.insert(nodes, t("0"))
                        if col < c1 then
                            table.insert(nodes, t(" & "))
                        end
                    end
                end
                node_index = node_index + c1

                table.insert(nodes, t(" & \\vline & "))

                -- Right block
                if row <= r2 then
                    local right_nodes = make_row_nodes(c2, node_index)
                    for _, n in ipairs(right_nodes) do
                        table.insert(nodes, n)
                    end
                else
                    for col = 1, c2 do
                        table.insert(nodes, t("0"))
                        if col < c2 then
                            table.insert(nodes, t(" & "))
                        end
                    end
                end
                node_index = node_index + c2
            end

            table.insert(nodes, t({ "", "\\end{bmatrix}" }))
            return sn(nil, nodes)
        end, {})
    ),
    matrix_snip("mat(%d)(%d)", "bmatrix"),
    matrix_snip("pmat(%d)(%d)", "pmatrix"),
    matrix_snip("vmat(%d)(%d)", "vmatrix"),
    matrix_snip("Vmat(%d)(%d)", "Vmatrix"),

    s("align", {
        t("\\begin{align*}"),
        t({ "", "\t" }),
        i(1),
        t({ "", "\\end{align*}" }),
    }),
})

-- =========================
-- Keymaps for LuaSnip
-- =========================
local keymap_opts = { silent = true }

-- Expand snippet with double space
vim.keymap.set({ "i", "s" }, "<Tab>", function()
    if ls.expandable() then
        ls.expand()
    end
end, keymap_opts)
-- <Tab> jumps to next insert node
vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if ls.jumpable(1) then
        ls.jump(1)
        return ""
    else
        return vim.api.nvim_replace_termcodes("<C-l>", true, true, true)
    end
end, keymap_opts)

-- <S-Tab> jumps to previous insert node
vim.keymap.set({ "i", "s" }, "<C-h>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
        return ""
    else
        return vim.api.nvim_replace_termcodes("<C-h>", true, true, true)
    end
end, keymap_opts)
