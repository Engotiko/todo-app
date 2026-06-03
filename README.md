# 📝 Yapılacaklar Listesi (Todo)

HTML, CSS ve JavaScript ile yazılmış, **Supabase** veritabanına bağlı basit bir todo uygulaması. Görevler buluttaki Postgres veritabanında saklanır; farklı cihaz/tarayıcıdan açıldığında aynı liste görünür.

## Özellikler
- **E-posta + şifre ile kayıt ve giriş** (Supabase Auth)
- **6 haneli OTP ile e-posta doğrulama** — kayıt sonrası gelen kodu girerek hesap onaylanır
- Her kullanıcı yalnızca **kendi görevlerini** görür (RLS ile `user_id` bazlı izolasyon)
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

## OTP e-postası (önemli)
6 haneli kodun e-postaya gömülebilmesi için "Confirm signup" şablonu `{{ .Token }}` içermelidir. Supabase **ücretsiz planda varsayılan e-posta sağlayıcısıyla şablon değiştirilemez**; bu yüzden özel bir **SMTP sağlayıcısı** (ör. Brevo, Resend, Gmail SMTP) yapılandırılmalıdır. SMTP olmadan Supabase yalnızca doğrulama linki gönderir, 6 haneli kod göstermez.

## ⚠️ Güvenlik notu
Görevler RLS ile kullanıcı bazında izole edilmiştir (her kullanıcı yalnızca kendi görevlerini görür). `anon` ve `service_role` anahtarlarını gizli tutun; `service_role` anahtarı asla istemci tarafında kullanılmamalıdır.
