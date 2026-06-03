-- Yapılacaklar tablosu (kullanıcı bazlı)
create table if not exists public.todos (
  id          bigint generated always as identity primary key,
  user_id     uuid not null default auth.uid() references auth.users(id) on delete cascade,
  text        text not null check (char_length(text) > 0),
  done        boolean not null default false,
  inserted_at timestamptz not null default now()
);

-- Row Level Security açık
alter table public.todos enable row level security;

-- Politikalar: her kullanıcı yalnızca kendi görevlerine erişebilir.
-- user_id, INSERT sırasında auth.uid() varsayılanıyla otomatik dolar.
drop policy if exists "own select" on public.todos;
drop policy if exists "own insert" on public.todos;
drop policy if exists "own update" on public.todos;
drop policy if exists "own delete" on public.todos;

create policy "own select" on public.todos
  for select to authenticated using (auth.uid() = user_id);

create policy "own insert" on public.todos
  for insert to authenticated with check (auth.uid() = user_id);

create policy "own update" on public.todos
  for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy "own delete" on public.todos
  for delete to authenticated using (auth.uid() = user_id);

-- ============================================================
-- Auth / OTP notları (kod ile değil, Supabase ayarlarından yapılır):
--   * Email confirmations AÇIK olmalı (Authentication > Providers > Email).
--   * 6 haneli kod için "Confirm signup" e-posta şablonu {{ .Token }} içermeli.
--     DİKKAT: Ücretsiz planda varsayılan e-posta sağlayıcısıyla şablon
--     değiştirilemez; özel SMTP (ör. Brevo, Resend, Gmail) gerekir.
--   * OTP uzunluğu: Authentication > Email > "OTP length" = 6.
-- ============================================================
