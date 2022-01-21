lua require("vahor")

nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
nnoremap <C-p> :lua require('telescope.builtin').git_files()<CR>
nnoremap <Leader>pf :lua require('telescope.builtin').find_files()<CR>

nnoremap <leader>vrc :lua require('vahor.telescope').search_dotfiles({ hidden = true })<CR>
nnoremap <leader>gb :lua require('vahor.telescope').git_branches()<CR>
