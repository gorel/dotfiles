-- This is a really neat plugin for case-sensitive substitution
-- Basically, do :%S instead of %s and it will do smart substitution:
-- :%S/badjob/goodjob/g
--    - 'badjob' -> 'goodjob'
--    - 'BadJob' -> 'GoodJob'
--    - 'badJob' -> 'goodJob'
--    - 'BADJOB' -> 'GOODJOB'
-- https://github.com/tpope/vim-abolish
-- https://stackoverflow.com/a/23144847
return {
  "tpope/vim-abolish",
  event = "CmdlineEnter",
  keys = {
    "crs", -- coerce to snake_case
    "crm", -- coerce to MixedCase (PascalCase)
    "crc", -- coerce to camelCase
    "cru", -- coerce to UPPER_CASE
    "cr-", -- coerce to dash-case (kebab-case)
    "cr.", -- coerce to dot.case
  },
}
