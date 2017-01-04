json.recent_searches @search_strings do |s|
  json.search_string s.search_string
  json.time s.created_at
end