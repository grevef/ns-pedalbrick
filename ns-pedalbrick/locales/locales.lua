Locales = Locales or {}

function Locale(key)
    local lang = Config.Locale or 'en'
    local dict = Locales[lang]

    if not dict then
        return key
    end

    return dict[key] or key
end