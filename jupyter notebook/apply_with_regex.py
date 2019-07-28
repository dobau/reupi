HTTP_REFERER_MAP = {
            "youtube\.com": "Youtube",
    
            "google\.[com|es|de|ar]": "Google",
    
            "googleadservices\.com": "Google ADS",
            "googleads\.g\.doubleclick\.net": "Google ADS",
            "googlesyndication\.com": "Google ADS",
    
            "facebook\.com": "Facebook",
    
            "mercadopago\.com": "Mercado Pago",
            "mercadolibre\.com": "Mercado Pago",
            "mercadolivre\.com": "Mercado Pago",
            "mlstatic\.com": "Mercado Pago",
    
            "instagram\.com": "Instagram",
    
            "bing\.com": "Microsoft",
    
            "yahoo\.com": "Yahoo",
    
            "t\.co": "Twitter"
        }

def to_source(obj):
    for (key, value) in HTTP_REFERER_MAP.items():
        #value = value.replace('http://', '').replace('https://', '')
        
        if re.search(key, obj):
            return value

    return obj

x['http_referer'] = x['http_referer'].fillna('')
x.apply({'http_referer': to_source}).groupby(['http_referer']).size().sort_values(ascending=False)
