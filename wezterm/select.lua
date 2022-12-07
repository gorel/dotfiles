local select = {}

local url_regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b"
local ip_addr_regex = "\\b\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\b"

-- quick select mode (CTRL-SHIFT-SPACE)
select.quick_select_patterns = {
   -- match urls
   url_regex,
   -- match ip addresses
   ip_addr_regex,
}

select.hyperlink_rules = {
   -- Linkify things that look like URLs
   {
      regex = url_regex,
      format = "$0",
   },
   -- Linkify v4 ip addresses
   {
      regex = ip_addr_regex,
      format = "$0",
   },
}

return select
