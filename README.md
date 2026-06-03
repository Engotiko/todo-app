# 📝 Yapılacaklar Listesi (Todo)

HTML, CSS ve JavaScript ile yazılmış, **Supabase** veritabanına bağlı basit bir todo uygulaması. Görevler buluttaki Postgres veritabanında saklanır; farklı cihaz/tarayıcıdan açıldığında aynı liste görünür.

## Özellikler
- **E-posta + şifre ile kayıt ve giriş** (Supabase Auth)
- **E-posta linki ile doğrulama** — kayıt sonrası gelen e-postadaki linke tıklayınca hesap onaylanır ve otomatik giriş yapılır
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

## E-posta doğrulama (link akışı)
Bu proje, Supabase'in varsayılan e-posta servisiyle **link tabanlı** doğrulama kullanır:
kullanıcı kaydolur → gelen e-postadaki linke tıklar → Supabase, Auth ayarlarındaki
**Site URL**'e geri yönlendirir → `supabase-js` adres çubuğundaki oturumu yakalayıp
otomatik giriş yapar.

Gerekli ayarlar (Authentication > URL Configuration):
- **Site URL**: uygulamanın yayınlandığı adres (ör. GitHub Pages URL'i)
- **Redirect URLs** allow-list: aynı adres (alt yollar için `/**` ile)

> **6 haneli kod ister misin?** E-postada girilebilir bir OTP kodu (`{{ .Token }}`)
> göstermek için "Confirm signup" şablonunu düzenlemek gerekir; bu da Supabase
> **ücretsiz planında varsayılan e-posta ile mümkün değildir** — özel bir SMTP
> sağlayıcısı (Brevo, Resend, Gmail SMTP vb.) gerekir. Kod, OTP-kod akışını da
> destekleyecek şekilde yazılabilir; bu sürüm link akışını kullanır.

## ⚠️ Güvenlik notu
Görevler RLS ile kullanıcı bazında izole edilmiştir (her kullanıcı yalnızca kendi görevlerini görür). `anon` ve `service_role` anahtarlarını gizli tutun; `service_role` anahtarı asla istemci tarafında kullanılmamalıdır.
