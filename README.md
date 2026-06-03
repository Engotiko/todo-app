# 📝 Yapılacaklar Listesi (Todo)

HTML, CSS ve JavaScript ile yazılmış, **Supabase** veritabanına bağlı basit bir todo uygulaması. Görevler buluttaki Postgres veritabanında saklanır; farklı cihaz/tarayıcıdan açıldığında aynı liste görünür.

## Özellikler
- Görev ekleme, tamamlama (üstü çizili), silme
- Filtreler: Tümü / Aktif / Tamamlanan
- Tamamlananları toplu temizleme
- Kalan görev sayacı
- Veriler Supabase'de kalıcı

## Teknolojiler
- Saf HTML/CSS/JavaScript (build adımı yok, tek dosya: `index.html`)
- [Supabase](https://supabase.com) (Postgres + REST API) — `@supabase/supabase-js` CDN üzerinden

## Kurulum
1. Supabase'de bir proje oluştur.
2. `schema.sql` içeriğini Supabase **SQL Editor**'de çalıştır (`todos` tablosu + RLS politikaları).
3. `index.html` içindeki `SUPABASE_URL` ve `SUPABASE_ANON_KEY` değerlerini kendi projenin değerleriyle güncelle.
4. `index.html`'i tarayıcıda aç.

## ⚠️ Güvenlik notu
Bu demo kimlik doğrulaması (auth) **içermez**. RLS açık olsa da politikalar `anon` rolüne tam erişim verir — yani anon anahtarını bilen herkes görevleri okuyup yazabilir. Kişisel/demo kullanım içindir. Gerçek bir uygulamada Supabase Auth ekleyip görevleri kullanıcıya göre kısıtlayın.
