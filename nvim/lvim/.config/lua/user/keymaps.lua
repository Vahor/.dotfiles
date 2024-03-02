-- Find
lvim.keys.normal_mode["fp"] = ":lua require'telescope'.extensions.project.project{}<CR>"
lvim.keys.normal_mode["ff"] = ":lua require('telescope.builtin').find_files()<CR>"
lvim.keys.normal_mode["fr"] = ":lua require('telescope.builtin').oldfiles()<CR>"
lvim.keys.normal_mode["fg"] = ":lua require('telescope.builtin').live_grep()<CR>"
lvim.keys.normal_mode["ft"] = ":lua require('telescope.builtin').treesitter()<CR>"
lvim.keys.normal_mode["fb"] = ":lua require('telescope.builtin').buffers()<CR>"


-- Manage buffers
lvim.keys.normal_mode["["] = ":bp<CR>"
lvim.keys.normal_mode["]"] = ":bn<CR>"

-- Rename
lvim.keys.normal_mode["<F18>"] = ":lua require('renamer').rename()<CR>"
lvim.keys.insert_mode["<F18>"] = ":lua require('renamer').rename()<CR>"
