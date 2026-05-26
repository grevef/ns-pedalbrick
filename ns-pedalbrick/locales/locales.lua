Locales = {}

function Locale(key)
    return Locales[Config.Locale][key] or key
end