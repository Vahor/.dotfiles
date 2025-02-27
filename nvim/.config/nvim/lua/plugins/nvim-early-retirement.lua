---@module "lazy"
---@type LazySpec
return {
  'chrisgrieser/nvim-early-retirement',
  opts = {
    retirementAgeMins = 2,
  },
  config = true,
  event = 'VeryLazy',
}
