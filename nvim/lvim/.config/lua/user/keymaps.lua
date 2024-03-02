lvim.builtin.which_key.mappings["f"] = {
  name = "Find",
  p = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects" },
  f = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "Files" },
  r = { "<cmd>lua require('telescope.builtin').oldfiles()<CR>", "Recent" },
  g = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", "Grep" },
  t = { "<cmd>lua require('telescope.builtin').treesitter()<CR>", "Functions" },
  b = { "<cmd>lua require('telescope.builtin').buffers()<CR>", "Buffers" }
}
